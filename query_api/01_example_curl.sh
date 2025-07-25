#!/bin/bash

# 01_example_curl.sh

# =============================
# Example: Making API Requests with curl
# =============================
# This script demonstrates how to use curl to interact with a sample API (https://reqres.in)
# Each section shows a different type of API call: GET, POST, PUT, PATCH, DELETE
# Headers and data are included as needed for each request

# ---
# 1. GET request with query parameters
#    Fetches users on page 1, with id=5 (note: this API ignores id in query string)
curl -X GET "https://reqres.in/api/users?page=1&id=5"

# ---
# 2. GET request with custom header
#    Fetches user with id=2, using an API key in the header
curl -X GET "https://reqres.in/api/users/2" \
     -H "x-api-key: reqres-free-v1"

# ---
# 3. POST request to create a new user
#    Sends JSON data with name and job fields
curl -X POST "https://reqres.in/api/users" \
     -H "Content-Type: application/json" \
     -H "x-api-key: reqres-free-v1" \
     -d '{"name": "Ada Lovelace", "job": "engineer"}'

# ---
# 4. More API Call Method Examples
#    (Uncomment any line to try it)

# GET: Fetch a user by ID
# curl -X GET "https://reqres.in/api/users/2" \
#      -H "x-api-key: reqres-free-v1"

# POST: Create a new user
# curl -X POST "https://reqres.in/api/users" \
#      -H "Content-Type: application/json" \
#      -H "x-api-key: reqres-free-v1" \
#      -d '{"name": "Ada Lovelace", "job": "engineer"}'

# PUT: Update an existing user (replace all fields)
# curl -X PUT "https://reqres.in/api/users/2" \
#      -H "Content-Type: application/json" \
#      -H "x-api-key: reqres-free-v1" \
#      -d '{"name": "Ada Lovelace", "job": "scientist"}'

# PATCH: Update part of a user (partial update)
# curl -X PATCH "https://reqres.in/api/users/2" \
#      -H "Content-Type: application/json" \
#      -H "x-api-key: reqres-free-v1" \
#      -d '{"job": "mathematician"}'

# DELETE: Remove a user by ID
# curl -X DELETE "https://reqres.in/api/users/2" \
#      -H "x-api-key: reqres-free-v1"
