✅ Goal

Run a free, local LLM (Gemma 3 1B) and query it from R or Python using the Ollama REST API on your machine.

🔧 1. Install Ollama

Download & install: https://ollama.com/download (macOS / Linux / Windows).  ￼

💾 2. Pull the Gemma 3 (1B) model
```bash
ollama pull gemma3:1b
```

🚀 3. Start the Ollama server
```bash
ollama serve
```
The REST API listens on http://localhost:11434. 

Check models
```bash
ollama list
curl http://localhost:11434/api/tags
```

🔌 4. Query from R or Python

Option A — Ollama native API (POST /api/chat)
```R
library(httr2)
library(jsonlite)

body <- list(
  model = "gemma3:1b",
  messages = list(
    list(role = "system", content = "Always answer in rhymes."),
    list(role = "user",   content = "Introduce yourself.")
  ),
  stream = FALSE
)

res <- request("http://localhost:11434/api/chat") |>
  req_method("POST") |>
  req_body_json(body) |>
  req_perform()

out <- resp_body_json(res)
cat(out$message$content)
```
Python
```Python
import requests, json

url = "http://localhost:11434/api/chat"
payload = {
    "model": "gemma3:1b",
    "messages": [
        {"role": "system", "content": "Always answer in rhymes."},
        {"role": "user",   "content": "Introduce yourself."}
    ],
    "stream": False
}
r = requests.post(url, json=payload, headers={"Content-Type":"application/json"})
print(r.json()["message"]["content"])
```