#!/bin/bash

docker buildx build -f openswoole.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole:latest . && \
docker buildx build -f openswoole-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole-dev:latest . && \
docker push sichev/octane-openswoole && \
docker push sichev/octane-openswoole-dev && \
echo "Done!"
