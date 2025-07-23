#!/usr/bin/env python3
"""
test_api.py - Test Ollama API with served model
"""

import requests
import json
import sys

def test_ollama_api(model_name="gemma3", prompt="Hello, how are you?"):
    """Test the Ollama API with a simple prompt"""
    
    url = "http://127.0.0.1:11435/api/generate"
    
    payload = {
        "model": model_name,
        "prompt": prompt,
        "stream": False
    }
    
    try:
        print(f"🤖 Testing Ollama API with model: {model_name}")
        print(f"📝 Prompt: {prompt}")
        print("-" * 50)
        
        response = requests.post(url, json=payload, timeout=30)
        
        if response.status_code == 200:
            result = response.json()
            print("✅ Response received:")
            print(result.get('response', 'No response'))
        else:
            print(f"❌ Error: {response.status_code}")
            print(response.text)
            
    except requests.exceptions.ConnectionError:
        print("❌ Could not connect to Ollama server")
        print("   Make sure Ollama is running with: ollama serve")
    except Exception as e:
        print(f"❌ Error: {e}")

if __name__ == "__main__":
    # Get model name from command line or use default
    model = sys.argv[1] if len(sys.argv) > 1 else "gemma3"
    prompt = sys.argv[2] if len(sys.argv) > 2 else "What is the capital of France?"
    
    test_ollama_api(model, prompt) 