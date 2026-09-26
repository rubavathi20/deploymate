#!/bin/bash

set -e

CONTAINER_NAME="deploymate-app"
PORT="5000"

echo "================================"
echo "      DeployMate Rollback"
echo "================================"

echo "[1/4] Stopping current container..."

docker stop "$CONTAINER_NAME" 2>/dev/null || true

echo "[2/4] Removing current container..."

docker rm "$CONTAINER_NAME" 2>/dev/null || true

echo "[3/4] Starting previous DeployMate image..."

docker run -d \
    --name "$CONTAINER_NAME" \
    -p "$PORT:5000" \
    deploymate:1.0

echo "[4/4] Checking application health..."

sleep 3

if curl -sf http://localhost:5000/health > /dev/null
then
    echo "================================"
    echo "Rollback successful!"
    echo "DeployMate is healthy."
    echo "================================"
else
    echo "Rollback failed!"
    docker logs "$CONTAINER_NAME"
    exit 1
fi
