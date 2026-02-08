#!/usr/bin/env python3
"""Check and list emails from Gmail inbox."""

import imaplib
import email
import os
import sys
import argparse
from datetime import datetime, timedelta

def connect():
    """Connect to Gmail IMAP."""
    email_addr = os.getenv('GMAIL_EMAIL')
    password = os.getenv('GMAIL_APP_PASSWORD', '').replace(' ', '')
    
    if not email_addr or not password:
        print("❌ Error: Set GMAIL_EMAIL and GMAIL_APP_PASSWORD in .env")
        sys.exit(1)
    
    mail = imaplib.IMAP4_SSL('imap.gmail.com')
    mail.login(email_addr, password)
    return mail

def fetch_emails(mail, folder='INBOX', limit=10, unread_only=False, from_filter=None):
    """Fetch emails from specified folder."""
    mail.select(folder)
    
    # First, get list of unread email IDs
    status, unseen_messages = mail.search(None, '(UNSEEN)')
    unread_ids = set()
    if status == 'OK':
        unread_ids = set(unseen_messages[0].split())
    
    # Build search criteria for fetching emails
    search_criteria = []
    if unread_only:
        search_criteria.append('(UNSEEN)')
    else:
        search_criteria.append('(ALL)')
    
    if from_filter:
        search_criteria.append(f'(FROM "{from_filter}")')
    
    # Join criteria
    if len(search_criteria) > 1:
        search_query = '(' + ' '.join(search_criteria) + ')'
    else:
        search_query = search_criteria[0] if search_criteria else '(ALL)'
    
    status, messages = mail.search(None, search_query)
    
    if status != 'OK':
        print(f"❌ Failed to search emails: {messages}")
        return []
    
    email_ids = messages[0].split()
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
            'subject': subject,
            'from': from_addr,
            'date': date,
            'body': body[:500] + '...' if len(body) > 500 else body,
            'unread': is_unread
        })
    
    return emails

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

def main():
    parser = argparse.ArgumentParser(description='Check Gmail emails')
    parser.add_argument('--limit', '-l', type=int, default=10, help='Number of emails to fetch')
    parser.add_argument('--unread', '-u', action='store_true', help='Show only unread emails')
    parser.add_argument('--from', dest='from_filter', help='Filter by sender email')
    parser.add_argument('--folder', '-f', default='INBOX', help='Folder to check (default: INBOX)')
    parser.add_argument('--mark-read', '-m', action='store_true', help='Mark emails as read after fetching')
    
    args = parser.parse_args()
    
    try:
        mail = connect()
        print(f"📧 Fetching emails from {args.folder}...\n")
        
        emails = fetch_emails(
            mail, 
            folder=args.folder, 
            limit=args.limit, 
            unread_only=args.unread,
            from_filter=args.from_filter
        )
        
        if not emails:
            print("No emails found.")
            return
        
        print(f"Found {len(emails)} email(s):\n")
        print("=" * 80)
        
        for i, eml in enumerate(emails, 1):
            status_icon = "🔴" if eml['unread'] else "🟢"
            print(f"\n{status_icon} Email #{i}")
            print(f"From: {eml['from']}")
            print(f"Subject: {eml['subject']}")
            print(f"Date: {eml['date']}")
            print(f"ID: {eml['id']}")
            print("-" * 80)
            print(f"Body preview:\n{eml['body'][:300]}")
            print("=" * 80)
            
            if args.mark_read and eml['unread']:
                mail.store(eml['id'].encode(), '+FLAGS', '\\Seen')
                print(f"✅ Marked as read")
        
        mail.close()
        mail.logout()
        
    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
