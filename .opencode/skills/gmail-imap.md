# Gmail IMAP Integration

Direct IMAP access to Gmail - no OAuth, no MCP servers, just simple app password authentication.

## Setup

### 1. Create Gmail App Password

1. Go to [Google Account → Security](https://myaccount.google.com/security)
2. Enable **2-Step Verification** (required for app passwords)
3. Go to **App passwords**
4. Select **Mail** → **Other (Custom name)**
5. Name it "OpenCode" → **Generate**
6. **Copy the 16-character password** (e.g., `xxxx xxxx xxxx xxxx`)

### 2. Add to Environment

Add to your `.env` file:

```bash
GMAIL_EMAIL="your.email@gmail.com"
GMAIL_APP_PASSWORD="xxxx xxxx xxxx xxxx"  # spaces will be removed automatically
```

### 3. Test Connection

```bash
cd .opencode/tools/gmail-imap
python3 test_connection.py
```

## Usage

### Check New Emails

```bash
python3 check_emails.py --limit 10
```

### Check Specific Sender

```bash
python3 check_emails.py --from "boss@company.com" --unread
```

### Mark as Read After Processing

```bash
python3 check_emails.py --mark-read --label "Processed"
```

## Available Tools

| Script | Description |
|--------|-------------|
| `test_connection.py` | Test IMAP connection |
| `check_emails.py` | List and filter emails |
| `process_emails.py` | Evaluate emails with AI logic |

## Periodic Job Setup

Check every 15 minutes:

```bash
opencode schedule-job \
  --name "gmail-checker" \
  --schedule "*/15 * * * *" \
  --prompt "Check Gmail for new emails and evaluate what action is needed"
```

Or use the script directly:

```bash
cd .opencode/tools/gmail-imap && python3 process_emails.py
```

## Security Notes

- **Never commit** `.env` file with credentials
- **App Password** has limited access (only email, no account changes)
- **Revoke anytime** in Google Account settings
- **No OAuth tokens** to manage or refresh

## Gmail IMAP Settings

Server: `imap.gmail.com`  
Port: `993` (SSL)  
Username: Full email address  
Password: App Password (16 chars, no spaces)
