#!/bin/bash

URL="http://localhost:5000/health"

if curl -sf "$URL" > /dev/null
then
    echo "DeployMate application is healthy"
    exit 0
else
    echo "DeployMate application is DOWN"
    exit 1
fi
