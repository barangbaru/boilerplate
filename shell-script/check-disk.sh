#!/bin/sh
# set -x
# Shell script to monitor or watch the disk space
# It will send an email to $ADMIN, if the (free available) percentage of space is >= 90%.
# --------------------------------------------------------------------------------------------------------
# Set admin email so that you can get email.
ADMIN="root"
# set alert level 90% is default
ALERT=90
# Exclude list of unwanted monitoring, if several partions then use "|" to separate the partitions.
# An example: EXCLUDE_LIST="/dev/hdd1|/dev/hdc5"
EXCLUDE_LIST="/auto/ripper|loop"
topicurl=https://ntfy.mmi-pt.com/resources
#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
main_prog() {
while read -r output;
do
  #echo "Working on $output ..."
  usep=$(echo "$output" | awk '{ print $1}' | cut -d'%' -f1)
  partition=$(echo "$output" | awk '{print $2}')
  if [ $usep -ge $ALERT ] ; then
      curl \
    -d "Running out of space \"$partition ($usep%)\" on server $(hostname), $(date)" \
    -H "Title: Low disk space alert on $(hostname)" \
    -H "Priority: max" \
    -H "Tags: warning,cd" \
    $topicurl
  fi
done
}

if [ "$EXCLUDE_LIST" != "" ] ; then
  df -H | grep -vE "^Filesystem|tmpfs|cdrom|${EXCLUDE_LIST}" | awk '{print $5 " " $6}' | main_prog
else
  df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}' | main_prog
fi
