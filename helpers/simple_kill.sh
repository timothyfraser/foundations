#!/bin/bash

# simple_kill.sh - Simple script to kill all processes on a port

# Load environment from project root
if [ -f "../../.bashrc" ]; then
    source ../../.bashrc
elif [ -f "../.bashrc" ]; then
    source ../.bashrc
elif [ -f ".bashrc" ]; then
    source .bashrc
fi

port=${1:-11435}

echo "🔍 Killing all processes on port $port"
echo ""

# Get all PIDs using the port
echo "📋 Finding processes..."
pids=$(netstat -ano | grep ":$port " | grep LISTENING | awk '{print $5}' | sort -u | grep -v "0")

if [ -n "$pids" ]; then
    echo "⚠️  Found processes: $pids"
    echo ""
    
    # Kill each PID
    for pid in $pids; do
        echo "🔄 Killing PID $pid..."
        
        # Get process name
        process_name=$(tasklist /FI "PID eq $pid" /FO CSV 2>/dev/null | tail -1 | cut -d',' -f1 | tr -d '"')
        echo "📋 Process: $process_name"
        
        # Try graceful shutdown for Ollama
        if [[ "$process_name" == *"ollama"* ]]; then
            echo "🔄 Stopping Ollama gracefully..."
            ollama stop gemma3 2>/dev/null || ollama stop 2>/dev/null
            sleep 2
        fi
        
        # Force kill if still running
        if tasklist | grep -q "$pid"; then
            echo "🔄 Force killing..."
            powershell.exe -Command "Stop-Process -Id $pid -Force" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo "✅ Killed PID $pid"
            else
                echo "❌ Failed to kill PID $pid"
            fi
        else
            echo "✅ PID $pid was stopped gracefully"
        fi
        echo ""
    done
    
    # Check if any remain
    sleep 2
    remaining=$(netstat -ano | grep ":$port " | grep LISTENING | awk '{print $5}' | sort -u | grep -v "0")
    
    if [ -z "$remaining" ]; then
        echo "✅ All processes killed successfully"
    else
        echo "❌ Some processes remain: $remaining"
    fi
    
else
    echo "✅ No processes found on port $port"
fi 