# README `/query_api`

## Getting Started: Your First API Calls

Welcome to the world of APIs! This folder contains beginner-friendly examples to help you make your first API calls using three different tools:

- **`curl`** - A command-line tool for making HTTP requests (great for beginners)
- **Python** - Using the `requests` library (popular for data science)
- **R** - Using the `httr2` and `jsonlite` packages (common in statistics)

### What is an API?

An **API (Application Programming Interface)** is like a waiter in a restaurant. You (the customer) don't need to know how the kitchen works, but you can order food by speaking to the waiter. Similarly, APIs let your programs request data or services from other applications without needing to understand their internal workings.

**Key concepts you'll learn:**
- **HTTP Methods**: GET (retrieve data), POST (create data), PUT (update data), DELETE (remove data)
- **Headers**: Additional information sent with requests (like authentication keys)
- **JSON**: A common format for exchanging data between applications
- **Status Codes**: Numbers that tell you if your request succeeded (200 = success, 404 = not found, etc.)

You may consult [**this Google Slides presentation for a introduction to making API calls**](https://docs.google.com/presentation/d/1BYC2KujLtMvbIBffU0aUg-vlMYpa__XOj_9Z13XBpUg/edit?usp=sharing).

![Slides Overview](../images/slides1.PNG)

## Prerequisites: Install the Tools

Before running the examples, make sure you have the following installed. **Don't worry if you're new to programming** - we'll walk through each step!

### 1. Git & Git Bash
**What it is:** Git is a version control system, and Git Bash gives you a command-line interface on Windows.

- **Download:** [https://git-scm.com/downloads](https://git-scm.com/downloads)
- **Installation:** Git Bash is included with the standard Git for Windows installer. After installation, you can open "Git Bash" from your Start menu.
- **Why you need it:** Git Bash provides a Unix-like command line on Windows, which is essential for running the `curl` examples.

**Troubleshooting:**
- If you can't find Git Bash after installation, search for "Git Bash" in your Start menu
- On macOS/Linux, you can use the regular Terminal instead of Git Bash

### 2. curl
**What it is:** curl is a command-line tool for making HTTP requests to APIs.

- **Windows:** curl is included by default in recent versions of Windows 10/11. You can also use the version bundled with Git Bash.
- **macOS/Linux:** curl is usually pre-installed. If not, install via your package manager:
  - macOS: `brew install curl` (if you have Homebrew)
  - Ubuntu/Debian: `sudo apt install curl`
  - CentOS/RHEL: `sudo yum install curl`
- **More info:** [https://curl.se/download.html](https://curl.se/download.html)

**How to test if curl is installed:**
Open your terminal/Git Bash and type: `curl --version`
If you see version information, curl is installed!

### 3. Python
**What it is:** Python is a programming language that's great for data analysis and API calls.

- **Download:** [https://www.python.org/downloads/](https://www.python.org/downloads/)
- **Important:** During installation, make sure to check "Add Python to PATH" - this allows you to run Python from the command line.
- **Configuration:** Make sure to update the `PATH` for Python in this repository's [`.bashrc` file](https://github.com/timothyfraser/foundations/tree/main/.bashrc), and then run `source .bashrc` to load them for your session.

**How to test if Python is installed:**
Open your terminal/Git Bash and type: `python --version` or `python3 --version`
You should see something like "Python 3.x.x"

**Common issues:**
- If `python` doesn't work, try `python3`
- If you get "command not found", Python isn't in your PATH - reinstall and make sure to check "Add Python to PATH"

### 4. R
**What it is:** R is a programming language popular in statistics and data analysis.

- **Download:** [https://cran.r-project.org/mirrors.html](https://cran.r-project.org/mirrors.html)
- **Configuration:** Make sure to update the `PATH` and `R_LIBS_USER` for R in this repository's [`.bashrc` file](https://github.com/timothyfraser/foundations/tree/main/.bashrc), and then run `source .bashrc` to load them for your session.

**How to test if R is installed:**
Open your terminal/Git Bash and type: `R --version`
You should see R version information.

**Alternative:** You can also use RStudio (a user-friendly interface for R) instead of the command line.

---

## Example 1: Using curl in Git Bash

**What you'll learn:** How to make API calls using the command line with `curl`.

See [`01_example_curl.sh`](01_example_curl.sh) for example API calls using `curl`.

### Understanding the curl Examples

The script demonstrates different types of API requests:

1. **GET request (simple)** - Retrieves data from the API
2. **GET request with headers** - Includes authentication information
3. **GET request with query parameters** - Adds filters to your request
4. **POST request** - Creates new data on the server
5. **Additional examples** - PUT, PATCH, and DELETE requests (commented out)

### How to Run the Examples

**Option 1: Run the entire script**
```bash
bash 01_example_curl.sh
```

**Option 2: Run individual commands**
Copy and paste individual `curl` commands from the script into your Git Bash window.

### What to Expect

When you run the script, you'll see JSON responses like this:
```json
{
  "data": {
    "id": 2,
    "email": "janet.weaver@reqres.in",
    "first_name": "Janet",
    "last_name": "Weaver",
    "avatar": "https://reqres.in/img/faces/2-image.jpg"
  }
}
```

### Understanding the Output

- **Status codes**: Look for HTTP status codes (200 = success, 404 = not found, etc.)
- **JSON data**: The response is in JSON format, which is easy to read and parse
- **Error messages**: If something goes wrong, you'll see error messages that help you troubleshoot

### Troubleshooting curl

**Common issues:**
- **"curl: command not found"**: curl isn't installed or not in your PATH
- **"bash: 01_example_curl.sh: No such file or directory"**: Make sure you're in the correct directory
- **Connection errors**: Check your internet connection
- **Permission denied**: Make sure the script is executable (`chmod +x 01_example_curl.sh`)

---

## Example 2: Using Python

**What you'll learn:** How to make API calls using Python with the `requests` library.

See [`02_example_python.py`](02_example_python.py) for a simple Python script using the `requests` library.

### Understanding the Python Example

The script demonstrates:
- **Importing libraries**: How to load the `requests` library
- **Making GET requests**: How to fetch data from an API
- **Handling responses**: How to check status codes and extract JSON data
- **Error handling**: Basic response validation

### Step-by-Step Instructions

**Step 1: Install the requests library**
```bash
pip install requests
```
or
```bash
pip3 install requests
```

**Step 2: Run the script**
```bash
python 02_example_python.py
```
or
```bash
python3 02_example_python.py
```

### What the Script Does

1. **Imports the requests library** - This gives us the tools to make HTTP requests
2. **Makes a GET request** - Fetches user data from the API
3. **Checks the status code** - Verifies the request was successful (200 = success)
4. **Extracts JSON data** - Converts the response to a Python dictionary
5. **Cleans up** - Removes variables from memory

### Expected Output

You should see something like:
```
200
{'data': {'id': 2, 'email': 'janet.weaver@reqres.in', 'first_name': 'Janet', 'last_name': 'Weaver', 'avatar': 'https://reqres.in/img/faces/2-image.jpg'}, 'support': {'url': 'https://reqres.in/#support-heading', 'text': 'To keep ReqRes free, contributions towards server costs are appreciated!'}}
```

### Understanding the Code

```python
# This line makes the HTTP request
response = requests.get(
    "https://reqres.in/api/users/2",
    headers={"x-api-key": "reqres-free-v1"}
)

# This checks if the request was successful
print(response.status_code)  # 200 = success!

# This converts the response to a Python dictionary
print(response.json())
```

### Troubleshooting Python

**Common issues:**
- **"ModuleNotFoundError: No module named 'requests'"**: Run `pip install requests`
- **"python: command not found"**: Python isn't installed or not in your PATH
- **"pip: command not found"**: Try `pip3` instead of `pip`
- **Permission errors**: Try `pip install --user requests` or use a virtual environment

**Virtual Environment (Advanced):**
If you want to keep your Python packages organized:
```bash
python -m venv myenv
source myenv/bin/activate  # On Windows: myenv\Scripts\activate
pip install requests
python 02_example_python.py
```

---

## Example 3: Using R

**What you'll learn:** How to make API calls using R with the `httr2` and `jsonlite` packages.

See [`02_example_r.R`](02_example_r.R) for an R script using the `httr2` and `jsonlite` packages.

### Understanding the R Example

The script demonstrates:
- **Loading libraries**: How to load the `httr2` and `jsonlite` packages
- **Creating requests**: How to build HTTP requests with headers
- **Executing requests**: How to send requests and handle responses
- **Processing JSON**: How to work with JSON data in R

### Step-by-Step Instructions

**Step 1: Install the required packages**
Open R or RStudio and run:
```R
install.packages(c("httr2", "jsonlite"))
```

**Step 2: Run the script**

**Option A: In RStudio or R Console**
```R
source("02_example_r.R")
```

**Option B: From Git Bash/Command Line**
```bash
R -q -e "source('02_example_r.R')"
```

### What the Script Does

1. **Loads libraries** - Imports the necessary packages for HTTP requests and JSON processing
2. **Creates a request object** - Builds the HTTP request with URL, headers, and method
3. **Executes the request** - Sends the request to the API
4. **Checks status** - Verifies the request was successful (200 = success)
5. **Extracts JSON data** - Converts the response to R data structures
6. **Cleans up** - Removes variables from the environment

### Understanding the Code

```R
# Create request object with URL and headers
req = request("https://reqres.in/api/users/2") |>
  req_headers(`x-api-key` = "reqres-free-v1") |>
  req_method("GET")

# Execute the request
resp = req_perform(req)

# Check if successful
resp$status_code  # 200 = success

# Get the JSON data
resp_body_json(resp)
```

### Expected Output

You should see something like:
```
$data
$data$id
[1] 2

$data$email
[1] "janet.weaver@reqres.in"

$data$first_name
[1] "Janet"

$data$last_name
[1] "Weaver"

$data$avatar
[1] "https://reqres.in/img/faces/2-image.jpg"
```

### Troubleshooting R

**Common issues:**
- **"there is no package called 'httr2'"**: Run `install.packages(c("httr2", "jsonlite"))`
- **"R: command not found"**: R isn't installed or not in your PATH
- **Package installation fails**: Make sure you have internet connection and try again
- **Script doesn't run**: Make sure you're in the correct directory

**RStudio Tips:**
- Use RStudio for a more user-friendly experience
- You can run code line by line by selecting it and pressing Ctrl+Enter
- The Environment panel shows your variables and their values

**Alternative R packages:**
If `httr2` doesn't work, you can try the older `httr` package:
```R
install.packages("httr")
library(httr)
response <- GET("https://reqres.in/api/users/2", 
                add_headers(`x-api-key` = "reqres-free-v1"))
content(response)
```


---

## Next Steps: What to Try Next

Now that you've made your first API calls, here are some ideas to explore:

### 1. Experiment with Different APIs
- **JSONPlaceholder**: `https://jsonplaceholder.typicode.com/` (fake data for testing)
- **OpenWeatherMap**: `https://openweathermap.org/api` (weather data - requires free API key)
- **GitHub API**: `https://api.github.com/` (GitHub data - no key required for public repos)

### 2. Try Different HTTP Methods
- **GET**: Retrieve data (what you've done so far)
- **POST**: Create new data
- **PUT**: Update existing data
- **DELETE**: Remove data

### 3. Add Error Handling
Learn how to handle errors gracefully:
```python
import requests

try:
    response = requests.get("https://api.example.com/data")
    response.raise_for_status()  # Raises an exception for bad status codes
    data = response.json()
except requests.exceptions.RequestException as e:
    print(f"Error: {e}")
```

### 4. Work with Real Data
- Parse the JSON responses and extract specific information
- Save data to files (CSV, JSON, etc.)
- Create visualizations with the data

## Common HTTP Status Codes

Understanding status codes helps you debug API issues:

- **200 OK**: Request successful
- **201 Created**: Resource created successfully
- **400 Bad Request**: Invalid request (check your parameters)
- **401 Unauthorized**: Authentication required
- **403 Forbidden**: Access denied
- **404 Not Found**: Resource doesn't exist
- **429 Too Many Requests**: Rate limit exceeded
- **500 Internal Server Error**: Server problem

## Tips for Success

### For Beginners
1. **Start simple**: Begin with GET requests before trying POST/PUT/DELETE
2. **Read the documentation**: Most APIs have documentation explaining how to use them
3. **Test in small steps**: Try one command at a time rather than running entire scripts
4. **Use a REST client**: Tools like Postman or Insomnia can help you test APIs visually

### For More Advanced Users
1. **Use environment variables**: Store API keys securely
2. **Implement rate limiting**: Respect API limits to avoid getting blocked
3. **Cache responses**: Store data locally to avoid repeated requests
4. **Use async requests**: For better performance with multiple API calls

## Getting Help

If you run into issues:

1. **Check the error message**: Most errors tell you exactly what's wrong
2. **Verify your setup**: Make sure all tools are installed and working
3. **Test your internet connection**: API calls require internet access
4. **Check API documentation**: The API might have changed or require different parameters
5. **Ask for help**: Don't hesitate to ask instructors or classmates

## More Information

### Learning Resources
- [What is an API? (MDN)](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Introduction)
- [HTTP Methods Explained](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods)
- [JSON Tutorial](https://www.w3schools.com/js/js_json_intro.asp)

### Documentation
- [curl Documentation](https://curl.se/docs/)
- [Python requests Documentation](https://docs.python-requests.org/en/latest/)
- [R httr2 Documentation](https://httr2.r-lib.org/)

### Practice APIs
- [ReqRes](https://reqres.in/) - The API used in these examples
- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) - Fake REST API for testing
- [HTTPBin](https://httpbin.org/) - HTTP testing service
- [Cat Facts API](https://catfact.ninja/) - Fun API for practice

---

**Happy coding! 🚀**
