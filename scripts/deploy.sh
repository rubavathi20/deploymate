#!/bin/bash

set -e

IMAGE_NAME="deploymate:1.0"
CONTAINER_NAME="deploymate-app"

echo "================================"
echo "      DeployMate Deployment"
echo "================================"

echo "[1/4] Building Docker image..."

docker build -f docker/Dockerfile -t "$IMAGE_NAME" .

echo "[2/4] Removing old container..."

docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "[3/4] Starting new container..."

docker run -d \
    --name "$CONTAINER_NAME" \
    -p 5000:5000 \
    "$IMAGE_NAME"

echo "[4/4] Checking application health..."

sleep 3

if curl -sf http://localhost:5000/health > /dev/null
then
    echo "================================"
    echo "Deployment successful!"
    echo "DeployMate is healthy."
    echo "================================"
else
    echo "Deployment failed!"
    docker logs "$CONTAINER_NAME"
    exit 1
fi
