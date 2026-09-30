#!/bin/bash

set -e

IMAGE_NAME="deploymate:1.0"
CONTAINER_NAME="deploymate-app"
PORT="5000"

echo "========================================"
echo "       DeployMate Automated Deployment"
echo "========================================"

echo ""
echo "[1/5] Building Docker image..."

docker build -f docker/Dockerfile -t "$IMAGE_NAME" .

echo ""
echo "[2/5] Removing previous DeployMate container..."

docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo ""
echo "[3/5] Starting new DeployMate container..."

docker run -d \
    --name "$CONTAINER_NAME" \
    -p "$PORT:5000" \
    --restart unless-stopped \
    "$IMAGE_NAME"

echo ""
echo "[4/5] Waiting for application..."

sleep 3

echo ""
echo "[5/5] Checking application health..."

if curl -sf "http://localhost:$PORT/health" > /dev/null
then
    echo ""
    echo "========================================"
    echo "       DEPLOYMENT SUCCESSFUL"
    echo "========================================"
    echo "Application : DeployMate"
    echo "Container   : $CONTAINER_NAME"
    echo "Port        : $PORT"
    echo "Health      : HEALTHY"
    echo "========================================"
else
    echo ""
    echo "========================================"
    echo "       DEPLOYMENT FAILED"
    echo "========================================"

    echo ""
    echo "Container logs:"
    docker logs "$CONTAINER_NAME"

    exit 1
fi
