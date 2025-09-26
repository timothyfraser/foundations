#!/bin/bash

# 01_example_curl.sh

# =============================
# Example: Making API Requests with curl
# =============================
# This script demonstrates how to use curl to interact with a sample API (https://reqres.in)
# Each section shows a different type of API call: GET, POST, PUT, PATCH, DELETE
# Headers and data are included as needed for each request

# ---
# 1. GET request (simplest version, only works when no headers required)
#    Fetches user whose id is 2, using specific endpoint /api/users/2
echo "=== GET Request (Simple) ==="
curl -X GET "https://reqres.in/api/users/2" -w "\nStatus Code: %{http_code}\n\n"


# ---
# 2. GET request with custom header
#    Fetches user with id=2, using an API key in the header
echo "=== GET Request (with Header) ==="
curl -X GET "https://reqres.in/api/users/2" \
     -H "x-api-key: reqres-free-v1" \
     -w "\nStatus Code: %{http_code}\n\n"

# 3. GET request with query parameters
#    Fetches users on page 1, with id=5 (note: this API ignores id in query string)
echo "=== GET Request (with Query Parameters) ==="
curl -X GET "https://reqres.in/api/users?page=1&id=5" \
     -H "x-api-key: reqres-free-v1" \
     -w "\nStatus Code: %{http_code}\n\n"


# ---
# 4. POST request to create a new user
#    Sends JSON data with name and job fields
echo "=== POST Request (Create User) ==="
curl -X POST "https://reqres.in/api/users" \
     -H "Content-Type: application/json" \
     -H "x-api-key: reqres-free-v1" \
     -d '{"name": "Ada Lovelace", "job": "engineer"}' \
     -w "\nStatus Code: %{http_code}\n\n"

# ---
# 5. More API Call Method Examples
#    (Uncomment any line to try it)

# GET: Fetch a user by ID
# echo "=== GET Request (Alternative) ==="
# curl -X GET "https://reqres.in/api/users/2" \
#      -H "x-api-key: reqres-free-v1" \
#      -w "\nStatus Code: %{http_code}\n\n"

# POST: Create a new user
# echo "=== POST Request (Alternative) ==="
# curl -X POST "https://reqres.in/api/users" \
#      -H "Content-Type: application/json" \
#      -H "x-api-key: reqres-free-v1" \
#      -d '{"name": "Ada Lovelace", "job": "engineer"}' \
#      -w "\nStatus Code: %{http_code}\n\n"

# PUT: Update an existing user (replace all fields)
# echo "=== PUT Request (Update User) ==="
# curl -X PUT "https://reqres.in/api/users/2" \
#      -H "Content-Type: application/json" \
#      -H "x-api-key: reqres-free-v1" \
#      -d '{"name": "Ada Lovelace", "job": "scientist"}' \
#      -w "\nStatus Code: %{http_code}\n\n"

# PATCH: Update part of a user (partial update)
# echo "=== PATCH Request (Partial Update) ==="
# curl -X PATCH "https://reqres.in/api/users/2" \
#      -H "Content-Type: application/json" \
#      -H "x-api-key: reqres-free-v1" \
#      -d '{"job": "mathematician"}' \
#      -w "\nStatus Code: %{http_code}\n\n"

# DELETE: Remove a user by ID
# echo "=== DELETE Request (Remove User) ==="
# curl -X DELETE "https://reqres.in/api/users/2" \
#      -H "x-api-key: reqres-free-v1" \
#      -w "\nStatus Code: %{http_code}\n\n"
