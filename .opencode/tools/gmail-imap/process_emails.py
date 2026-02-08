#!/usr/bin/env python3
"""Process emails with AI evaluation and action suggestions."""

import imaplib
import email
import os
import sys
import json
import re
import subprocess
from datetime import datetime
from urllib.parse import quote

# Configuration
TRACKING_FILE = "/home/gratheon/git/mind/agent/data/notified_emails.json"

def load_notified_emails():
    """Load set of already notified email IDs."""
    if os.path.exists(TRACKING_FILE):
        try:
            with open(TRACKING_FILE, 'r') as f:
                data = json.load(f)
                return set(data.get('notified_ids', []))
        except:
            return set()
    return set()

def save_notified_email(email_id):
    """Mark an email as notified."""
    notified = load_notified_emails()
    notified.add(email_id)
    
    # Keep only last 1000 to prevent file from growing too large
    notified = set(list(notified)[-1000:])
    
    os.makedirs(os.path.dirname(TRACKING_FILE), exist_ok=True)
    with open(TRACKING_FILE, 'w') as f:
        json.dump({'notified_ids': list(notified)}, f)

def connect():
    """Connect to Gmail IMAP."""
    email_addr = os.getenv('GMAIL_EMAIL')
    password = os.getenv('GMAIL_APP_PASSWORD', '').replace(' ', '')
    
    if not email_addr or not password:
        print("Error: Set GMAIL_EMAIL and GMAIL_APP_PASSWORD in .env", file=sys.stderr)
        sys.exit(1)
    
    mail = imaplib.IMAP4_SSL('imap.gmail.com')
    mail.login(email_addr, password)
    return mail

def decode_header(header):
    """Decode email header."""
    if not header:
        return ""
    decoded = email.header.decode_header(header)
    result = ""
    for part, charset in decoded:
        if isinstance(part, bytes):
            result += part.decode(charset or 'utf-8', errors='ignore')
        else:
            result += part
    return result

def fetch_emails_json(mail, folder='INBOX', limit=10, unread_only=False):
    """Fetch emails and return as JSON for AI processing."""
    mail.select(folder)
    
    # First, get list of unread email IDs
    status, unseen_messages = mail.search(None, '(UNSEEN)')
    unread_ids = set()
    if status == 'OK':
        unread_ids = set(unseen_messages[0].split())
    
    # Search for emails to fetch
    if unread_only:
        status, messages = mail.search(None, '(UNSEEN)')
    else:
        status, messages = mail.search(None, '(ALL)')
    
    if status != 'OK':
        return []
    
    email_ids = messages[0].split()
    if not email_ids:
        return []
    
    email_ids = email_ids[-limit:]  # Get last N emails
    email_ids.reverse()  # Most recent first
    
    emails = []
    for eid in email_ids:
        status, msg_data = mail.fetch(eid, '(RFC822)')
        if status != 'OK':
            continue
        
        msg = email.message_from_bytes(msg_data[0][1])
        
        # Extract email details
        subject = decode_header(msg['Subject'])
        from_addr = decode_header(msg['From'])
        date = msg['Date']
        message_id = msg.get('Message-ID', '')
        
        # Get body
        body = ""
        if msg.is_multipart():
            for part in msg.walk():
                content_type = part.get_content_type()
                if content_type == "text/plain":
                    try:
                        body = part.get_payload(decode=True).decode('utf-8', errors='ignore')
                        break
                    except:
                        pass
        else:
            try:
                body = msg.get_payload(decode=True).decode('utf-8', errors='ignore')
            except:
                pass
        
        # Check if this email ID is in the unread set
        is_unread = eid in unread_ids
        
        emails.append({
            'id': eid.decode(),
            'message_id': message_id,
            'subject': subject,
            'from': from_addr,
            'date': date,
            'body': body[:2000] if len(body) > 2000 else body,
            'is_unread': is_unread
        })
    
    return emails

def extract_email_address(from_field):
    """Extract email address from From field."""
    match = re.search(r'<([^>]+)>', from_field)
    if match:
        return match.group(1)
    match = re.search(r'[\w\.-]+@[\w\.-]+', from_field)
    if match:
        return match.group(0)
    return from_field

def generate_gmail_link(subject, from_email):
    """Generate Gmail search link for the email."""
    search_query = f"from:{from_email} subject:{subject}"
    encoded_query = quote(search_query)
    return f"https://mail.google.com/mail/u/0/#search/{encoded_query}"

def evaluate_importance(eml):
    """Evaluate if email is important based on content and sender."""
    subject_lower = eml['subject'].lower()
    from_lower = eml['from'].lower()
    body_lower = eml['body'].lower()
    
    # High importance keywords
    high_priority_keywords = [
        'urgent', 'action required', 'asap', 'deadline', 'meeting', 'interview',
        'offer', 'payment', 'invoice', 'bill', 'bank', 'security', 'alert',
        'important', 'confirmed', 'approved', 'rejected', 'application',
        'interview', 'job', 'opportunity', 'proposal', 'contract'
    ]
    
    # Low importance / spam indicators
    low_priority_keywords = [
        'newsletter', 'unsubscribe', 'promotional', 'sale', 'discount',
        'marketing', 'notification', 'noreply', 'no-reply', 'do-not-reply'
    ]
    
    # Check for high priority
    for keyword in high_priority_keywords:
        if keyword in subject_lower or keyword in body_lower:
            return True, f"Contains priority keyword: {keyword}"
    
    # Check for low priority (spam/newsletters)
    for keyword in low_priority_keywords:
        if keyword in subject_lower or keyword in body_lower:
            return False, f"Likely promotional: {keyword}"
    
    # Personal emails (not noreply)
    if 'noreply' not in from_lower and 'no-reply' not in from_lower:
        if re.search(r'@gmail\.com|@yahoo\.com|@outlook\.com|@hotmail\.com', from_lower):
            return True, "Personal email domain"
    
    # Default: moderate importance for unread personal emails
    if eml['is_unread']:
        return True, "Unread message"
    
    return False, "Low priority or automated message"

def get_email_content(eml):
    """Get email content - full if short, summary if long."""
    body = eml['body']
    
    # Clean up HTML tags
    clean_body = re.sub(r'<[^>]+>', '', body)
    clean_body = re.sub(r'\s+', ' ', clean_body).strip()
    
    # If email is short (< 500 chars), return full content
    if len(clean_body) <= 500:
        return clean_body, False  # False = not summarized
    
    # Otherwise summarize - first 2 sentences or 400 chars
    sentences = clean_body.split('.')
    summary = '.'.join(sentences[:2])[:400]
    if not summary.endswith('.'):
        summary += '...'
    
    return summary, True  # True = was summarized

def suggest_response(eml):
    """Suggest a draft response based on email content."""
    subject = eml['subject']
    body = eml['body']
    from_name = eml['from']
    
    # Extract name from From field
    name_match = re.search(r'^([^<]+)', from_name)
    name = name_match.group(1).strip() if name_match else "there"
    
    subject_lower = subject.lower()
    body_lower = body.lower()
    
    if 'meeting' in subject_lower or 'schedule' in subject_lower:
        return f"Hi {name},\n\nThank you for reaching out. I am available [suggest times]. Let me know what works best for you.\n\nBest regards"
    
    if 'interview' in subject_lower or 'job' in subject_lower:
        return f"Hi {name},\n\nThank you for the opportunity. I am interested and would like to discuss further. When would be a good time to talk?\n\nBest regards"
    
    if 'question' in subject_lower or 'help' in body_lower:
        return f"Hi {name},\n\nThank you for your message. I'd be happy to help with [specific topic]. Here is what I suggest...\n\nBest regards"
    
    if 'security' in subject_lower or 'alert' in subject_lower:
        return "Reviewed and acknowledged. Will take necessary action if needed."
    
    return f"Hi {name},\n\nThank you for your email. I will review this and get back to you shortly.\n\nBest regards"

def send_discord_notification(eml, is_important, reason, content, was_summarized, draft_response, gmail_link):
    """Send notification to Discord with email content and draft in message."""
    channel_id = os.getenv('DISCORD_CHANNEL_ID')
    if not channel_id:
        print("❌ Error: DISCORD_CHANNEL_ID environment variable not set")
        return False
    os.environ['DISCORD_CHANNEL_ID'] = channel_id
    
    # Clean up content
    clean_content = re.sub(r'\n{3,}', '\n\n', content).strip()
    
    # Truncate content if too long for Discord (max 2000 chars for message)
    max_content_len = 800
    if len(clean_content) > max_content_len:
        clean_content = clean_content[:max_content_len] + "..."
    
    # Create message with email content, draft, and Gmail link
    summary_indicator = " 📋 (summarized)" if was_summarized else ""
    
    message = f"""📧 **{eml['subject']}**{summary_indicator}

{clean_content}

💬 **Draft Response:**
```
{draft_response}
```

🔗 **[Open in Gmail]({gmail_link})**"""
    
    try:
        notify_script = "/home/gratheon/git/workstation/.opencode/tools/discord-notifications/notify.sh"
        result = subprocess.run(
            ['bash', notify_script, message],
            capture_output=True,
            text=True,
            cwd='/home/gratheon/git/mind'
        )
        
        if result.returncode == 0:
            print(f"✅ Discord notification sent for: {eml['subject'][:50]}...")
            print(f"   📝 Thread created with draft")
            return True
        else:
            print(f"❌ Failed to send Discord notification: {result.stderr}")
            return False
    except Exception as e:
        print(f"❌ Error sending Discord notification: {e}")
        return False

def process_email(mail, eml, notified_ids, dry_run=False):
    """Process a single email - evaluate and notify if important and unread."""
    
    # Skip if already notified
    if eml['id'] in notified_ids:
        print(f"\n📧 {eml['subject'][:60]}...")
        print(f"   → Already notified, skipping")
        return False
    
    # Skip if not unread
    if not eml['is_unread']:
        print(f"\n📧 {eml['subject'][:60]}...")
        print(f"   → Already read, skipping")
        return False
    
    print(f"\n📧 Processing: {eml['subject'][:60]}...")
    
    # Evaluate importance
    is_important, reason = evaluate_importance(eml)
    print(f"   Importance: {'HIGH' if is_important else 'LOW'} - {reason}")
    
    if not is_important:
        print(f"   → Not important enough, skipping")
        # Still mark as processed (save ID) to avoid re-evaluating
        if not dry_run:
            save_notified_email(eml['id'])
        return False
    
    # Get email content (full or summarized)
    content, was_summarized = get_email_content(eml)
    draft_response = suggest_response(eml)
    
    # Generate Gmail link
    from_email = extract_email_address(eml['from'])
    gmail_link = generate_gmail_link(eml['subject'], from_email)
    
    print(f"   → Creating Discord notification...")
    
    if dry_run:
        print(f"   [DRY RUN] Would send to Discord:")
        content_type = "summarized" if was_summarized else "full"
        print(f"   Content ({content_type}): {content[:100]}...")
        print(f"   Draft: {draft_response[:100]}...")
        print(f"   Link: {gmail_link}")
        return True
    
    # Send Discord notification
    success = send_discord_notification(eml, is_important, reason, content, was_summarized, draft_response, gmail_link)
    
    if success:
        # Mark as notified
        save_notified_email(eml['id'])
        print(f"   ✅ Marked as notified")
    
    return success

def main():
    import argparse
    parser = argparse.ArgumentParser(description='Process emails with AI evaluation')
    parser.add_argument('--limit', '-l', type=int, default=10, help='Number of emails to fetch')
    parser.add_argument('--unread', '-u', action='store_true', help='Show only unread emails')
    parser.add_argument('--json', '-j', action='store_true', help='Output as JSON')
    parser.add_argument('--mark-read', '-m', action='store_true', help='Mark emails as read')
    parser.add_argument('--dry-run', '-d', action='store_true', help='Dry run - do not send notifications')
    parser.add_argument('--reset-tracking', action='store_true', help='Reset tracking file (notify about all emails again)')
    
    args = parser.parse_args()
    
    # Reset tracking if requested
    if args.reset_tracking and os.path.exists(TRACKING_FILE):
        os.remove(TRACKING_FILE)
        print("🗑️  Tracking file reset. Will notify about all emails.")
    
    # Load already notified emails
    notified_ids = load_notified_emails()
    print(f"📊 Loaded {len(notified_ids)} previously notified emails")
    
    try:
        mail = connect()
        print("📧 Fetching emails...")
        emails = fetch_emails_json(mail, limit=args.limit, unread_only=args.unread)
        
        if not emails:
            print("No emails found.")
            return
        
        print(f"\nFound {len(emails)} email(s)\n")
        
        processed_count = 0
        notified_count = 0
        
        for eml in emails:
            success = process_email(mail, eml, notified_ids, dry_run=args.dry_run)
            if success:
                notified_count += 1
            processed_count += 1
            
            # Mark as read if requested
            if args.mark_read and not args.dry_run and eml['is_unread']:
                mail.store(eml['id'].encode(), '+FLAGS', '\\Seen')
                print(f"   ✅ Marked as read in Gmail")
        
        print(f"\n{'='*60}")
        print(f"Processed: {processed_count} emails")
        print(f"New notifications: {notified_count}")
        print(f"Previously notified: {len(notified_ids)}")
        
        mail.close()
        mail.logout()
        
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
