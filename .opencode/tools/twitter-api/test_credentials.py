#!/usr/bin/env python3
"""
Test Twitter/X API credentials.
Requires: pip3 install requests-oauthlib
"""
import os
import requests
from requests_oauthlib import OAuth1

# Load credentials from environment
API_KEY = os.getenv('API_KEY')
API_SECRET = os.getenv('API_SECRET_KEY')
ACCESS_TOKEN = os.getenv('ACCESS_TOKEN')
ACCESS_TOKEN_SECRET = os.getenv('ACCESS_TOKEN_SECRET')

if not all([API_KEY, API_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET]):
    print("Error: Missing Twitter API credentials in environment variables")
    print("Required: API_KEY, API_SECRET_KEY, ACCESS_TOKEN, ACCESS_TOKEN_SECRET")
    exit(1)

auth = OAuth1(API_KEY, API_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
response = requests.get("https://api.twitter.com/2/users/me", auth=auth)

print(f"Status: {response.status_code}")
if response.status_code == 200:
    data = response.json()
    print(f"Authenticated as: @{data['data']['username']} (ID: {data['data']['id']})")
    print("Credentials are valid!")
else:
    print(f"Error: {response.text}")
    exit(1)
