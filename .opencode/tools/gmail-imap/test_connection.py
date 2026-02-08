#!/usr/bin/env python3
"""Test Gmail IMAP connection."""

import imaplib
import os
import sys

def test_connection():
    email = os.getenv('GMAIL_EMAIL')
    password = os.getenv('GMAIL_APP_PASSWORD', '').replace(' ', '')
    
    if not email or not password:
        print("❌ Error: Set GMAIL_EMAIL and GMAIL_APP_PASSWORD in .env")
        sys.exit(1)
    
    try:
        mail = imaplib.IMAP4_SSL('imap.gmail.com')
        mail.login(email, password)
        print(f"✅ Connected to Gmail as {email}")
        
        status, folders = mail.list()
        if status == 'OK':
            print(f"✅ Found {len(folders)} folders")
        
        mail.logout()
        print("✅ Connection test passed!")
        
    except Exception as e:
        print(f"❌ Connection failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    test_connection()
