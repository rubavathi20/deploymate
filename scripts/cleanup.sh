#!/bin/bash

set -e

echo "================================"
echo "      DeployMate Cleanup"
echo "================================"

echo "[1/3] Removing stopped DeployMate containers..."

docker container prune -f

echo "[2/3] Removing unused DeployMate images..."

docker image prune -f

echo "[3/3] Checking Docker resources..."

docker system df

echo "================================"
echo "Cleanup completed successfully!"
echo "================================"
