
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




Here are 3 easier alternatives, ranked from easiest to most flexible, and all still 100% free:


---

🥇 Easiest: Use Ollama

> Zero setup, works on Mac/Windows/Linux, local GPU or CPU, and exposes a REST API.



🔧 1. Install Ollama (takes 1 minute)

Go to: https://ollama.com/download

Install the app (it runs in the background and exposes a local API)


💾 2. Pull a Model

ollama pull mistral

> Other options: llama2, gemma, codellama, phi, etc.



🚀 3. Run the Model

Just type:

ollama run mistral

Or just have it idle in the background — the REST API stays live.


---

🧪 4. Query Ollama from R

Here’s an R script that just works, assuming ollama is running:

library(httr2)
library(jsonlite)

res <- request("http://localhost:11434/api/generate") %>%
  req_body_json(list(
    model = "mistral",
    prompt = "Explain systems engineering in two sentences.",
    stream = FALSE
  )) %>%
  req_method("POST") %>%
  req_perform()

output <- resp_body_json(res)
cat(output$response)

> ✅ Works out of the box
✅ Cross-platform
✅ No API key, no credentials, no Python
✅ You can install it in labs, give students a portable script, or run in class




---

🥈 Runner-Up: LM Studio (GUI) + Localhost API

GUI app to run models locally (e.g., GGUF versions of Mistral, LLaMA2)

Also exposes a local API on port 1234

Slightly more manual but no CLI required


URL: https://lmstudio.ai


---

🥉 Still Viable: HuggingFace Inference Endpoint (Free Tiers)

Use transformers or text-generation pipeline via HuggingFace API

Some small open models are free under the community pool

Still requires API keys and internet



---

✅ Recommendation for Your Class

Go with Ollama + R client:

It's as close to plug-and-play as local LLMs get

No huggingface accounts

No API cost

Easy to include in your foundations repo

