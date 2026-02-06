#!/usr/bin/env python3
"""
Post a tweet to Twitter/X.
Requires: pip3 install requests-oauthlib
"""
import os
import sys
import requests
from requests_oauthlib import OAuth1

# Load credentials from environment
API_KEY = os.getenv('API_KEY')
API_SECRET = os.getenv('API_SECRET_KEY')
ACCESS_TOKEN = os.getenv('ACCESS_TOKEN')
ACCESS_TOKEN_SECRET = os.getenv('ACCESS_TOKEN_SECRET')

if not all([API_KEY, API_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET]):
    print("Error: Twitter API credentials not found in environment variables")
    sys.exit(1)

# Setup auth
auth = OAuth1(API_KEY, API_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

# Get tweet text from argument or use default
if len(sys.argv) > 1:
    tweet_text = sys.argv[1]
else:
    tweet_text = "Hello from the API!"

# Post tweet
response = requests.post(
    "https://api.twitter.com/2/tweets",
    auth=auth,
    json={"text": tweet_text}
)

if response.status_code == 201:
    print(f"Tweet posted! ID: {response.json()['data']['id']}")
else:
    print(f"Error: {response.status_code} - {response.text}")
    sys.exit(1)
