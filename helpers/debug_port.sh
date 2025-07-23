#!/bin/bash

# debug_port.sh - Debug script to see what processes are found on a port

# Load environment from project root
if [ -f "../../.bashrc" ]; then
    source ../../.bashrc
elif [ -f "../.bashrc" ]; then
    source ../.bashrc
elif [ -f ".bashrc" ]; then
    source .bashrc
fi

port=${1:-11435}

echo "🔍 DEBUG: Checking processes on port $port"
echo ""

# Show raw netstat output
echo "📋 Raw netstat output:"
netstat -ano | grep ":$port " | grep LISTENING
echo ""

# Show parsed PIDs
echo "📋 Parsed PIDs:"
pids=$(netstat -ano | grep ":$port " | grep LISTENING | awk '{print $5}' | sort -u)
echo "$pids"
echo ""

# Count PIDs
pid_count=$(echo "$pids" | wc -l)
echo "📊 PID count: $pid_count"
echo ""

# Show each PID individually
echo "📋 Individual PIDs:"
while IFS= read -r pid; do
    if [ -n "$pid" ] && [ "$pid" != "0" ]; then
        echo "  PID: '$pid'"
        
        # Get process name
        process_name=$(tasklist /FI "PID eq $pid" /FO CSV 2>/dev/null | tail -1 | cut -d',' -f1 | tr -d '"')
        echo "  Process: '$process_name'"
        echo ""
    fi
done <<< "$pids"

echo "✅ Debug complete" 