#!/bin/bash
# health_monitor.sh
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100-$8}')
MEM_USAGE=$(free | awk '/Mem/{printf("%.2f"), $3/$2 * 100}')
DISK_USAGE=$(df / | awk 'END{print $5}' | tr -d '%')
PROCESSES=$(ps aux | wc -l)
echo "CPU: $CPU_USAGE%"
echo "Memory: $MEM_USAGE%"
echo "Disk: $DISK_USAGE%"
echo "Processes: $PROCESSES"
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
  echo "$(date) ALERT: High CPU usage: $CPU_USAGE%" >> /var/log/health_monitor.log
fi
if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
  echo "$(date) ALERT: High Memory usage: $MEM_USAGE%" >> /var/log/health_monitor.log
fi
if (( $DISK_USAGE > $DISK_THRESHOLD )); then
  echo "$(date) ALERT: Low Disk Space: $DISK_USAGE%" >> /var/log/health_monitor.log
fi
