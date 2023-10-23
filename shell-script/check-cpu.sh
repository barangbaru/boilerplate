#!/bin/bash
cpuuse=$(cat /proc/loadavg | awk '{print $3}'|cut -f 1 -d ".")
if [ "$cpuuse" -ge 90 ]; then
SUBJECT="ATTENTION: CPU load is high on $(hostname) at $(date)"
topicurl=https://ntfy.mmi-pt.com/resources
MESSAGE="/tmp/Mail.out"
   curl \
    -d "ATTENTION: CPU load is high. CPU current usage is: (${cpuuse}%) on server $(hostname), $(date)" \
    -H "Title: Low CPU alert on $(hostname)" \
    -H "Priority: max" \
    -H "Tags: warning,exclamation " \
    $topicurl
else
echo "Server CPU usage is in under threshold"
  fi