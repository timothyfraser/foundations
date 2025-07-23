#!/bin/bash

# 00_killport.sh - Kill ALL processes on specified port
# Usage: ./helpers/00_killport.sh -11435
# Usage: ./helpers/00_killport.sh 11435

# Load environment from project root
if [ -f "../../.bashrc" ]; then
    source ../../.bashrc
elif [ -f "../.bashrc" ]; then
    source ../.bashrc
elif [ -f ".bashrc" ]; then
    source .bashrc
fi

# Function to show usage
show_usage() {
    echo "Usage: $0 <port>"
    echo "   or: $0 -<port>"
    echo ""
    echo "Examples:"
    echo "   $0 11435"
    echo "   $0 -11435"
    echo "   $0 3000"
    echo ""
    echo "This script will:"
    echo "   1. Find ALL processes using the specified port"
    echo "   2. Kill them gracefully if possible"
    echo "   3. Force kill if necessary"
}

# Function to kill ALL processes on port
kill_all_processes_on_port() {
    local port=$1
    echo "🔍 Checking for ALL processes on port $port..."
    
    # Get all PIDs using the port
    local pids=$(netstat -ano | grep ":$port " | grep LISTENING | awk '{print $5}' | sort -u | grep -v "0")
    
    if [ -n "$pids" ]; then
        echo "⚠️  Found processes using port $port:"
        echo "$pids"
        echo ""
        
        local killed_count=0
        local failed_count=0
        
        # Kill each PID
        for pid in $pids; do
            if [ -n "$pid" ] && [ "$pid" != "0" ]; then
                echo "🔄 Killing PID: $pid"
                
                # Get process name
                local process_name=$(tasklist /FI "PID eq $pid" /FO CSV 2>/dev/null | tail -1 | cut -d',' -f1 | tr -d '"')
                echo "📋 Process name: $process_name"
                
                # Try graceful shutdown first for Ollama
                if [[ "$process_name" == *"ollama"* ]]; then
                    echo "🔄 Found Ollama process. Stopping it gracefully..."
                    ollama stop gemma3 2>/dev/null || ollama stop 2>/dev/null
                    sleep 2
                fi
                
                # Check if process is still running
                if tasklist | grep -q "$pid"; then
                    echo "🔄 Force killing process $pid..."
                    # Use PowerShell to kill process silently
                    powershell.exe -Command "Stop-Process -Id $pid -Force" 2>/dev/null
                    
                    if [ $? -eq 0 ]; then
                        echo "✅ Successfully killed process $pid"
                        ((killed_count++))
                    else
                        echo "❌ Failed to kill process $pid"
                        ((failed_count++))
                    fi
                else
                    echo "✅ Process $pid was stopped gracefully"
                    ((killed_count++))
                fi
                
                echo ""
            fi
        done
        
        # Wait a moment for ports to be released
        sleep 3
        
        # Verify all processes are gone
        local remaining_pids=$(netstat -ano | grep ":$port " | grep LISTENING | awk '{print $5}' | sort -u | grep -v "0")
        
        if [ -z "$remaining_pids" ]; then
            echo "✅ All processes on port $port have been killed"
            echo "📊 Summary: $killed_count killed, $failed_count failed"
            return 0
        else
            echo "❌ Some processes are still using port $port:"
            echo "$remaining_pids"
            echo "📊 Summary: $killed_count killed, $failed_count failed"
            return 1
        fi
        
    else
        echo "✅ No processes found using port $port"
        return 0
    fi
}

# Check if port argument is provided
if [ $# -eq 0 ]; then
    echo "❌ Error: No port specified"
    show_usage
    exit 1
fi

# Get port from argument (handle both -11435 and 11435 formats)
port=${1#-}  # Remove leading dash if present

# Validate port is a number
if ! [[ "$port" =~ ^[0-9]+$ ]]; then
    echo "❌ Error: Invalid port number '$port'"
    show_usage
    exit 1
fi

echo "🔄 Killing ALL processes on port $port..."
echo ""

# Kill all processes on the port
if kill_all_processes_on_port $port; then
    echo ""
    echo "✅ Successfully freed port $port"
    exit 0
else
    echo ""
    echo "❌ Failed to free port $port completely"
    echo "💡 You can check manually with:"
    echo "   netstat -ano | grep :$port"
    echo "   tasklist | grep <PID>"
    exit 1
fi 