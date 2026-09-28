#!/bin/bash

# Load settings from .env (project root)
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
[ -f "$ROOT_DIR/.env" ] && set -a && . "$ROOT_DIR/.env" && set +a
for var in DOCKER_REPO FPM_IMAGE OPENSWOOLE_IMAGE; do
    if [ -z "${!var}" ]; then
        echo "Error: $var is not set. Define it in .env (see .env.example)." >&2
        exit 1
    fi
done
cd "$ROOT_DIR" || exit 1

### FPM versions
docker buildx build -f dockerFiles/fpm/fpm-8.4.Dockerfile --platform linux/amd64,linux/arm64/v8 --tag ${DOCKER_REPO}/${FPM_IMAGE}:8.4 --push . && \
docker buildx build -f dockerFiles/fpm/fpm-8.4-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 --tag ${DOCKER_REPO}/${FPM_IMAGE}-dev:8.4 --push .

docker buildx build -f dockerFiles/fpm/fpm-8.5.Dockerfile --platform linux/amd64,linux/arm64/v8 --tag ${DOCKER_REPO}/${FPM_IMAGE}:8.5 --tag ${DOCKER_REPO}/${FPM_IMAGE}:stable --tag ${DOCKER_REPO}/${FPM_IMAGE}:latest --push . && \
docker buildx build -f dockerFiles/fpm/fpm-8.5-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 --tag ${DOCKER_REPO}/${FPM_IMAGE}-dev:8.5 --tag ${DOCKER_REPO}/${FPM_IMAGE}-dev:stable --tag ${DOCKER_REPO}/${FPM_IMAGE}-dev:latest --push .


### Open Swoole versions
docker buildx build -f dockerFiles/openswoole/openswoole-83.Dockerfile --platform linux/amd64,linux/arm64/v8 -t ${DOCKER_REPO}/${OPENSWOOLE_IMAGE}:8.3 --push . && \
docker buildx build -f dockerFiles/openswoole/openswoole-83-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 -t ${DOCKER_REPO}/${OPENSWOOLE_IMAGE}-dev:8.3 --push .

docker buildx build -f dockerFiles/openswoole/openswoole-84.Dockerfile --platform linux/amd64,linux/arm64/v8 -t ${DOCKER_REPO}/${OPENSWOOLE_IMAGE}:8.4 --push . && \
docker buildx build -f dockerFiles/openswoole/openswoole-84-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 -t ${DOCKER_REPO}/${OPENSWOOLE_IMAGE}-dev:8.4 --push .

docker buildx build -f dockerFiles/openswoole/openswoole-85.Dockerfile --platform linux/amd64,linux/arm64/v8 -t ${DOCKER_REPO}/${OPENSWOOLE_IMAGE}:stable -t ${DOCKER_REPO}/${OPENSWOOLE_IMAGE}:8.5 -t ${DOCKER_REPO}/${OPENSWOOLE_IMAGE}:latest --push . && \
docker buildx build -f dockerFiles/openswoole/openswoole-85-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 -t ${DOCKER_REPO}/${OPENSWOOLE_IMAGE}-dev:stable -t ${DOCKER_REPO}/${OPENSWOOLE_IMAGE}-dev:8.5 -t ${DOCKER_REPO}/${OPENSWOOLE_IMAGE}-dev:latest --push .


echo "Done!"
