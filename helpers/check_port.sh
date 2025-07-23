#!/bin/bash

# check_port.sh - Check what processes are using a specific port
# Usage: ./helpers/check_port.sh 11435

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
    echo ""
    echo "Examples:"
    echo "   $0 11435"
    echo "   $0 3000"
    echo "   $0 8080"
}

# Check if port argument is provided
if [ $# -eq 0 ]; then
    echo "❌ Error: No port specified"
    show_usage
    exit 1
fi

port=$1

# Validate port is a number
if ! [[ "$port" =~ ^[0-9]+$ ]]; then
    echo "❌ Error: Invalid port number '$port'"
    show_usage
    exit 1
fi

echo "🔍 Checking processes on port $port..."
echo ""

# Find processes using the port
pids=$(netstat -ano | grep ":$port " | grep LISTENING | awk '{print $5}' | sort -u)

if [ -n "$pids" ]; then
    echo "⚠️  Found processes using port $port:"
    echo ""
    
    # Count processes
    process_count=$(echo "$pids" | wc -l)
    echo "📊 Total processes found: $process_count"
    echo ""
    
    # Show details for each process
    while IFS= read -r pid; do
        if [ -n "$pid" ] && [ "$pid" != "0" ]; then
            echo "🔄 PID: $pid"
            
            # Get process name
            process_name=$(tasklist /FI "PID eq $pid" /FO CSV 2>/dev/null | tail -1 | cut -d',' -f1 | tr -d '"')
            echo "📋 Process name: $process_name"
            
            # Get memory usage
            memory=$(tasklist /FI "PID eq $pid" /FO CSV 2>/dev/null | tail -1 | cut -d',' -f5 | tr -d '"')
            echo "💾 Memory: $memory"
            echo ""
        fi
    done <<< "$pids"
    
    echo "💡 To kill these processes, run:"
    echo "   ./helpers/00_killport.sh $port"
    
else
    echo "✅ No processes found using port $port"
fi 