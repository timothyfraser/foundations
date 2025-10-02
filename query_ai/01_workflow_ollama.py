# workflow.py
# A script to query the lightweight LLM gemma3:1b via Ollama!

print("\n🚀 Sending LLM query in Python (Ollama)...\n")

# pip install requests
import requests
import sys

# --- CONFIG ---
# Ollama's OpenAI-compatible Chat Completions endpoint + default port
url = "http://localhost:11434/v1/chat/completions"
model = "gemma3:1b"  # Ollama model tag

payload = {
    "model": model,
    "messages": [
        {"role": "system", "content": "Always answer in rhymes."},
        {"role": "user",   "content": "Introduce yourself."}
    ],
    "temperature": 0.7,
    # You can omit max_tokens to let Ollama decide, or specify a positive int
    "stream": False
}
headers = {"Content-Type": "application/json"}

try:
    response = requests.post(url, json=payload, headers=headers, timeout=120)
    response.raise_for_status()
except requests.exceptions.RequestException as e:
    print(f"❌ Request failed: {e}")
    print("• Is `ollama serve` running on localhost:11434?")
    print("• Did you pull the model? Try:  `ollama pull gemma3:1b`")
    sys.exit(1)

data = response.json()

# For OpenAI-compatible responses:
# data["choices"][0]["message"]["content"]
try:
    output = data["choices"][0]["message"]["content"]
except (KeyError, IndexError) as e:
    print("❌ Unexpected response format from Ollama:")
    print(data)
    sys.exit(1)

print(output)
print("\n✅ LLM query complete. Exiting Python...\n")
sys.exit(0)