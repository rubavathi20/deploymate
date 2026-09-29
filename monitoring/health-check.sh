#!/bin/bash

CONTAINER_NAME="deploymate-app"
HEALTH_URL="http://localhost:5000/health"

echo "======================================"
echo "       DeployMate Health Check"
echo "======================================"

# Check Docker container
if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Docker Container : RUNNING"
else
    echo "Docker Container : NOT RUNNING"
    exit 1
fi

# Check application health
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$HEALTH_URL")

if [ "$RESPONSE" = "200" ]; then
    echo "Application      : HEALTHY"
    echo "Health Endpoint  : HTTP $RESPONSE"
else
    echo "Application      : UNHEALTHY"
    echo "Health Endpoint  : HTTP $RESPONSE"
    exit 1
fi

echo "======================================"
echo "Health check completed successfully."
echo "======================================"
