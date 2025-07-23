#!/bin/bash

# test_kill.sh - Test script to verify kill logic

# Load environment from project root
if [ -f "../../.bashrc" ]; then
    source ../../.bashrc
elif [ -f "../.bashrc" ]; then
    source ../.bashrc
elif [ -f ".bashrc" ]; then
    source .bashrc
fi

port=${1:-11435}

echo "🧪 Testing kill logic for port $port"
echo ""

# Show what we find
echo "📋 Processes found:"
pids=$(netstat -ano | grep ":$port " | grep LISTENING | awk '{print $5}' | sort -u | grep -v "0")
echo "$pids"
echo ""

# Count them
count=$(echo "$pids" | wc -w)
echo "📊 Found $count process(es)"
echo ""

# Show each one
if [ -n "$pids" ]; then
    echo "📋 Individual processes:"
    for pid in $pids; do
        echo "  PID: $pid"
        process_name=$(tasklist /FI "PID eq $pid" /FO CSV 2>/dev/null | tail -1 | cut -d',' -f1 | tr -d '"')
        echo "  Name: $process_name"
        echo ""
    done
else
    echo "✅ No processes found"
fi

echo "✅ Test complete" 