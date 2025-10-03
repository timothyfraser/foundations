# README `/query_ai`

## ✅ Goal

Run a free, local LLM (e.g., Gemma) and query it from R or Python using the LM Studio REST API exposed on your machine.


## 🔧 1. Install LM Studio (takes 1 minute)

Go to: https://lmstudio.ai/download

Install the app (it runs in the background and exposes a local API)


## 2. Set LM Studio to PATH

This repository provides a project-specific `.bashrc` to make the `lms` command available in your terminal. You must run it once every session. To activate it:

```bash
source .bashrc
lms --help # now this will work!
```

The `.bashrc` includes:
**Important Note:** Edit the bashrc file lines to have your username.
```bash
export PATH="$PATH:/c/Users/<username>/.lmstudio/bin"
alias lms='/c/Users/<username>/.lmstudio/bin/lms.exe'
```

You can also include local paths to Python and/or R to make sure your project is correctly configured. (But remember to install them first!) Wondering what the correct path is for your system? Run the `which <program>` command. For example:

```bash
which python
```

```bash
which R
```

## 💾 3. Start the LM Studio Server

Start the server on port 1234. This kicks off a local REST API service that you can send API queries

```bash
lms server start --port 1234
```

Check server status:

```bash
lms server status
```

Check available models on your local machine. (Open LM Studio to download more manually.)

```bash
curl http://localhost:1234/api/v0/models
```
Get the model (e.g., Gemma):

```bash
lms get gemma-3-1b
```

Load a model (e.g., Gemma):

```bash
lms load gemma-3-1b
```


## 🚀 4. Query the Model from R or Python

Next, open `01_startup.sh` to run all these steps and then run an R or Python script from the terminal.
Either of these will send a POST API query to the LM Studio REST API service, using R or Python. 
Here's a brief example of the basic syntax.

### R Example (using httr2)

```r
library(httr2)
library(jsonlite)

body <- list(
  model = "google/gemma-3-1b",
  messages = list(
    list(role = "system", content = "Always answer in rhymes."),
    list(role = "user", content = "Introduce yourself.")
  ),
  temperature = 0.7,
  max_tokens = -1,
  stream = FALSE
)

res <- request("http://localhost:1234/api/v0/chat/completions") %>%
  req_body_json(body) %>%
  req_method("POST") %>%
  req_perform()

output <- resp_body_json(res)
cat(output$choices[[1]]$message$content)
```

### Python Example (using requests)

```python
import requests

url = "http://localhost:1234/api/v0/chat/completions"
payload = {
    "model": "google/gemma-3-1b",
    "messages": [
        {"role": "system", "content": "Always answer in rhymes."},
        {"role": "user", "content": "Introduce yourself."}
    ],
    "temperature": 0.7,
    "max_tokens": -1,
    "stream": False
}
headers = {"Content-Type": "application/json"}

response = requests.post(url, json=payload, headers=headers)
print(response.json()["choices"][0]["message"]["content"])
```

---

# Further Learning

- LM Studio CLI: https://lmstudio.ai/docs/cli
- REST API: https://lmstudio.ai/docs/app/api/endpoints/rest
- Headless mode: https://lmstudio.ai/docs/app/api/headless

