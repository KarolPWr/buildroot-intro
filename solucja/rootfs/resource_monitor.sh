# cat /usr/sbin/resource_monitor.sh
#!/bin/sh
while true; do
    echo "Uptime: $(busybox uptime), Memory: $(free -m | grep Mem: | awk '{print $3}') MB used" >> /var/log/resource_monitor.log
    sleep 60
done