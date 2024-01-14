#!/bin/bash



set -eu
# API Endpoint Configurations
HOST="http://127.0.0.1:5000"
SIGNUP_ENDPOINT="$HOST/api/auth/signup"
SIGNIN_ENDPOINT="$HOST/api/auth/signin"
POSTS_ENDPOINT="$HOST/api/posts"

# User Credentials
USERNAME="testuser"
PASSWORD="testpassword"

# Function to Signup
signup() {
  curl -s -X POST $SIGNUP_ENDPOINT \
    -H "Content-Type: application/json" \
    -d '{"username":"'"$USERNAME"'", "password":"'"$PASSWORD"'"}'
}

# Function to Signin
signin() {
  local response=$(curl -s -X POST $SIGNIN_ENDPOINT \
    -H "Content-Type: application/json" \
    -d '{"username":"'"$USERNAME"'", "password":"'"$PASSWORD"'"}')
  echo $response | jq -r '.token'
}

# Function to Create a Post
create_post() {
  local token=$1
  local content=$2
  curl -s -X POST $POSTS_ENDPOINT \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $token" \
    -d '{"content":"'"$content"'"}'
}

# Main Execution
echo "Attempting to sign up..."
signup

echo "Signing in to get token..."
TOKEN=$(signin)

echo "Creating posts..."
create_post $TOKEN "Hello, this is the first test post."
create_post $TOKEN "Here is another interesting post."
create_post $TOKEN "Testing the API with a third message."

echo "Test posts created."
