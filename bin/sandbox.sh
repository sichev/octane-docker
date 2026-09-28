#!/bin/bash

# Load settings from .env (project root)
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
[ -f "$ROOT_DIR/.env" ] && set -a && . "$ROOT_DIR/.env" && set +a
for var in DOCKER_REPO SWOOLE_IMAGE; do
    if [ -z "${!var}" ]; then
        echo "Error: $var is not set. Define it in .env (see .env.example)." >&2
        exit 1
    fi
done
cd "$ROOT_DIR" || exit 1

# Experimental builds. Just testing.
# It's OK that some images from this list can't build properly

docker buildx build -f dockerFiles/swoole/swoole-84.Dockerfile --platform linux/amd64,linux/arm64/v8 -t ${DOCKER_REPO}/${SWOOLE_IMAGE}:8.4 . && \

echo "Done!"
