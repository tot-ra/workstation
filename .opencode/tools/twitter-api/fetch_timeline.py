#!/usr/bin/env python3
"""
Fetch Twitter/X home timeline (subscriptions).
Requires: pip3 install requests-oauthlib python-dotenv
"""
import os
import requests
from requests_oauthlib import OAuth1
from dotenv import load_dotenv

load_dotenv()

# Load credentials
API_KEY = os.getenv('API_KEY')
API_SECRET = os.getenv('API_SECRET_KEY')
ACCESS_TOKEN = os.getenv('ACCESS_TOKEN')
ACCESS_TOKEN_SECRET = os.getenv('ACCESS_TOKEN_SECRET')

# Create OAuth1 auth
auth = OAuth1(API_KEY, API_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

# Get authenticated user
user_response = requests.get(
    "https://api.twitter.com/2/users/me",
    auth=auth
)
user_id = user_response.json()['data']['id']

# Fetch home timeline
params = {
    "tweet.fields": "created_at,author_id,public_metrics",
    "expansions": "author_id",
    "user.fields": "username,name",
    "max_results": 20
}

timeline_response = requests.get(
    f"https://api.twitter.com/2/users/{user_id}/timelines/reverse_chronological",
    auth=auth,
    params=params
)

tweets = timeline_response.json()

# Process tweets
for tweet in tweets.get('data', []):
    author = next(
        (u for u in tweets.get('includes', {}).get('users', []) 
         if u['id'] == tweet['author_id']),
        None
    )
    print(f"@{author['username']}: {tweet['text'][:100]}...")
