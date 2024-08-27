#!/bin/bash

MODEL="lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF/Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf"
SYSTEM_MESSAGE="Think step by step and provide clear instructions to the user."

# Take input as an argument
if [ $# -ne 1 ]; then
    echo "Error: Please provide a single argument, the prompt"
    exit 1
fi

PROMPT="$1"

curl_command="curl -X POST \
  http://localhost:1234/v1/chat/completions \
  -H 'Content-Type: application/json' \
  -d '{
    \"model\": \"$MODEL\",
    \"messages\": [
      { \"role\": \"system\", \"content\": \"$SYSTEM_MESSAGE\" },
      { \"role\": \"user\", \"content\": \"$PROMPT\" }
    ],
    \"temperature\": 0.7,
    \"max_tokens\": -1,
    \"stream\": false
}'"

response=$(eval "$curl_command --silent")
if [ $? -ne 0 ]; then
    echo "Error: Failed to execute curl command"
    exit 1
fi

# Parse JSON response and print the content of the first choice's message
response=$(echo "$response" | jq '.choices[0].message.content' | sed 's/\"//g')
printf '%s\n' "${response}"
