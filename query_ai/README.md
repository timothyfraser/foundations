
✅ Goal

Run a free, local LLM (e.g., LLaMA, Mistral, or Gemma) and query it from R using httr or curl via an API exposed on their machine.


---

🔧 Tech Stack

LLM Backend (Python): llama-cpp-python or text-generation-webui

API Server: llama-cpp-python exposes a FastAPI-compatible REST server

R Client: Any HTTP client (httr2, curl, or plumber if reverse)



---

🪜 Step-by-Step for Students


---

⚙️ 1. Install LLaMA backend (Python, one-time setup)

Install llama-cpp-python and download a model like LLaMA 2, Mistral, or Gemma in GGUF format.

# Create Python environment
python -m venv llama_env
source llama_env/bin/activate  # On Windows: llama_env\Scripts\activate

# Install llama-cpp-server
pip install llama-cpp-python[server]


---

💾 2. Download a LLaMA/Mistral model (GGUF format)

Go to https://huggingface.co/TheBloke and choose a Q4_0.gguf model (lightweight, runs on CPU).

For example:

wget https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF/resolve/main/mistral-7b-instruct-v0.2.Q4_0.gguf


---

🚀 3. Run LLaMA server locally

python3 -m llama_cpp.server \
  --model ./mistral-7b-instruct-v0.2.Q4_0.gguf \
  --port 8000 \
  --n_ctx 512

You now have a REST API at: http://localhost:8000/v1/chat/completions


---

📦 4. Query LLaMA from R

Install httr2:

install.packages("httr2")

Create query_llama.R:

library(httr2)
library(jsonlite)

# Construct chat request
req <- request("http://localhost:8000/v1/chat/completions") %>%
  req_body_json(list(
    model = "local-model",
    messages = list(
      list(role = "system", content = "You are a helpful assistant."),
      list(role = "user", content = "Explain what systems engineering is in 2 sentences.")
    ),
    temperature = 0.7
  )) %>%
  req_method("POST")

# Send request and get response
resp <- req %>% req_perform()
result <- resp_body_json(resp)

# Print the assistant's reply
cat(result$choices[[1]]$message$content)


---

🧠 Student Notes

The R script just hits localhost:8000 — they need the Python LLM running in parallel

Model files can be big (2–5GB), but CPU models like Q4_0 are feasible on modern laptops

This is completely free, no tokens, no cloud



---

Optional Enhancements

Wrap the R script into a function: query_llama(prompt)

Write a Shiny app to explore model outputs

Include prompt templating and logging
