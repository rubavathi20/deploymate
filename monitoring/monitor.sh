#!/bin/bash

# DeployMate Monitoring Script

CONTAINER_NAME="deploymate-app"
REPORT_DIR="reports"
REPORT_FILE="$REPORT_DIR/system_metrics.txt"

mkdir -p "$REPORT_DIR"

echo "======================================"
echo "       DeployMate Monitoring"
echo "======================================"
echo "Date: $(date)"
echo

# -------------------------------
# Container Status
# -------------------------------

echo "Container Status:"
docker ps --filter "name=$CONTAINER_NAME" --format "Status: {{.Status}}"
echo

# -------------------------------
# CPU Usage
# -------------------------------

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: ${CPU}%"

# -------------------------------
# Memory Usage
# -------------------------------

MEMORY=$(free | awk '/Mem:/ {printf "%.1f", $3/$2 * 100}')
echo "Memory Usage: ${MEMORY}%"

# -------------------------------
# Disk Usage
# -------------------------------

DISK=$(df / | awk 'NR==2 {print $5}')
echo "Disk Usage: $DISK"

# -------------------------------
# Uptime
# -------------------------------

UPTIME=$(uptime -p)
echo "Uptime: $UPTIME"

# -------------------------------
# Application Health
# -------------------------------

HEALTH=$(curl -s http://localhost:5000/health)

echo "Application Health: $HEALTH"

# -------------------------------
# Save Report
# -------------------------------

{
    echo "Date: $(date)"
    echo "CPU Usage: ${CPU}%"
    echo "Memory Usage: ${MEMORY}%"
    echo "Disk Usage: $DISK"
    echo "Uptime: $UPTIME"
    echo "Application Health: $HEALTH"
    echo "--------------------------------------"
} > "$REPORT_FILE"

echo
echo "Monitoring report saved to: $REPORT_FILE"
echo "======================================"
