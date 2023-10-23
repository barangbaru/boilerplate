#!/bin/bash

# Define the threshold for low memory in MB
THRESHOLD=500
topicurl=https://ntfy.mmi-pt.com/resources
BODY="Memory is low. Free memory: ${MEM}MB"
# Check available memory using the free command
# The '-m' option makes it return values in MB
MEM=$(free -m | awk '/Mem/ {print $7}')

if [ "$MEM" -lt "$THRESHOLD" ]; then
    curl \
    -d "Memory is low. Free memory:(${MEM}MB) on server $(hostname), $(date)" \
    -H "Title: Low Memory alert on $(hostname)" \
    -H "Priority: max" \
    -H "Tags: warning,exclamation " \
    $topicurl
#    echo "$BODY" | mail -s "$SUBJECT" "$TO"
else
    echo "Memory is OK. Free memory: ${MEM}MB"
fi