#!/bin/bash

docker buildx build -f openswoole.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole:latest . && \
docker buildx build -f openswoole-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole-dev:latest . && \
docker buildx build -f fpm.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/fpm:latest . && \
docker push sichev/octane-openswoole && \
docker push sichev/octane-openswoole-dev && \
docker push sichev/fpm && \
echo "Done!"
