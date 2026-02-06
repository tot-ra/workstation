# Twitter/X API Integration

Interacting with Twitter/X API using OAuth 1.0a User Context for reading timelines and posting tweets.

## Prerequisites

Create a `.env` file in your project root with these credentials:

```bash
# Twitter/X API OAuth 1.0a credentials
# Get these from https://developer.twitter.com/en/portal/dashboard
API_KEY="your_api_key"
API_SECRET_KEY="your_api_secret"
ACCESS_TOKEN="your_access_token"
ACCESS_TOKEN_SECRET="your_access_token_secret"
```

**Note**: The Bearer Token (X_BEARER_TOKEN) is for app-only access and cannot access user-specific endpoints like timelines.

## Setup

Install required Python package:

```bash
pip3 install requests-oauthlib
```

## Available Tools

Tools located in `.opencode/tools/twitter-api/`:

| Tool | Description |
|------|-------------|
| `fetch_timeline.py` | Fetch home timeline (subscriptions) |
| `post_tweet.py` | Post a tweet |
| `post_with_media.py` | Post a tweet with media attachment |
| `test_credentials.py` | Test API credentials |

### Usage

```bash
# Fetch timeline
cd .opencode/tools/twitter-api
python3 fetch_timeline.py

# Post a tweet
python3 post_tweet.py "Hello from API!"

# Post with media
python3 post_with_media.py /path/to/image.png "Check out this image!"

# Test credentials
python3 test_credentials.py
```

## API Endpoints Reference

| Endpoint | Description | Auth |
|----------|-------------|------|
| `GET /2/users/me` | Get current user | OAuth 1.0a |
| `GET /2/users/{id}/timelines/reverse_chronological` | Home timeline | OAuth 1.0a |
| `GET /2/users/{id}/tweets` | User's tweets | OAuth 2.0 Bearer |
| `POST /2/tweets` | Create tweet | OAuth 1.0a |
| `DELETE /2/tweets/{id}` | Delete tweet | OAuth 1.0a |
| `GET /2/tweets/search/recent` | Search recent tweets | OAuth 2.0 Bearer |

## Rate Limits

- **Home timeline**: 150 requests per 15 minutes (per user)
- **Post tweet**: 50 requests per 24 hours (per user, Basic tier)
- **Search**: 450 requests per 15 minutes (app auth)

## Error Handling

Common error codes:

- `403` - Authentication failed or insufficient permissions
- `429` - Rate limit exceeded (wait and retry)
- `400` - Bad request (check tweet length, max 280 chars)

## Testing

Test your credentials:

```bash
cd .opencode/tools/twitter-api
python3 test_credentials.py
```

## Links

- [Twitter API Documentation](https://developer.twitter.com/en/docs/twitter-api)
- [OAuth 1.0a Guide](https://developer.twitter.com/en/docs/authentication/oauth-1-0a)
- [API Rate Limits](https://developer.twitter.com/en/docs/twitter-api/rate-limits)
