# 02_example_python.py

# This script can be run in Python to demonstrate 
# how to make an API request

# !pip install requests # install library if haven’t yet

# Load requests library
import requests

# Execute query and save response as object
response = requests.get(
    "https://reqres.in/api/users/2",
    headers={"x-api-key": "reqres-free-v1"}
)

# View response
print(response.status_code) # 200 = success!
# Extract the response as a JSON
print(response.json())

# Clear environment
globals.clear()

# Exit
# exit()