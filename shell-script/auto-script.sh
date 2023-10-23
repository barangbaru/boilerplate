curl  -H "Title: Login alert on $(hostname)" -H prio:max -H tags:warning,exclamation -d "SSH login: $(hostname) from $(who)" https://ntfy.mmi-pt.com/alert
