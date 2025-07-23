# workflow.py
# A script to query the lightweight LLM gemma-3-1b!

# Starting message
print("\n🚀 Sending LLM query in Python...\n")

# Install this requirement in the terminal...
# pip install requests

# Import library
import requests  # For making HTTP requests

# API endpoint for chat completions
url = "http://localhost:1234/api/v0/chat/completions"

# JSON payload for the request
payload = {
    "model": "google/gemma-3-1b",  # Model name
    "messages": [
        {"role": "system", "content": "Always answer in rhymes."},  # System prompt
        {"role": "user", "content": "Introduce yourself."}          # User prompt
    ],
    "temperature": 0.7,   # Sampling temperature
    "max_tokens": -1,     # No token limit
    "stream": False       # Non-streaming response
}
headers = {"Content-Type": "application/json"}  # Set content type to JSON

# Send the POST request to the API
response = requests.post(url, json=payload, headers=headers)

# Note: Did you get the 'no models loaded' error? Go exit() and load a model using 01_startup.sh, then try again

# Read the raw message with response.json(), or get a specific part of the message by specifying the indices after it, eg. ["choices"][0]
# response.json()

# Extract the model's reply from the response JSON as a character string
output = response.json()["choices"][0]["message"]["content"]

# Print the character string
print(output)

# Closing message
print("\n✅ LLM query complete. Exiting Python...\n")

# exit out of your python terminal with exit()
exit()