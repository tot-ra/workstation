#!/usr/bin/env python3
"""
Post a tweet with media to Twitter/X.
Requires: pip3 install requests-oauthlib
Usage: python post_with_media.py "/path/to/image.png" "Tweet text"
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

auth = OAuth1(API_KEY, API_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

# Get arguments
if len(sys.argv) < 2:
    print("Usage: python post_with_media.py <image_path> [tweet_text]")
    sys.exit(1)

media_path = sys.argv[1]
tweet_text = sys.argv[2] if len(sys.argv) > 2 else "Check out this image!"

if not os.path.exists(media_path):
    print(f"Error: File not found: {media_path}")
    sys.exit(1)

# Step 1: Upload media
with open(media_path, 'rb') as f:
    media_response = requests.post(
        "https://upload.twitter.com/1.1/media/upload.json",
        auth=auth,
        files={"media": f}
    )

if media_response.status_code != 200:
    print(f"Error uploading media: {media_response.status_code} - {media_response.text}")
    sys.exit(1)

media_id = media_response.json()['media_id_string']
print(f"Media uploaded: {media_id}")

# Step 2: Post tweet with media
tweet_response = requests.post(
    "https://api.twitter.com/2/tweets",
    auth=auth,
    json={
        "text": tweet_text,
        "media": {"media_ids": [media_id]}
    }
)

if tweet_response.status_code == 201:
    print(f"Tweet posted! ID: {tweet_response.json()['data']['id']}")
else:
    print(f"Error posting tweet: {tweet_response.status_code} - {tweet_response.text}")
    sys.exit(1)
