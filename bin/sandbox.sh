#!/bin/bash

docker buildx build -f dockerFiles/fpm/fpm-8.5.Dockerfile --platform linux/amd64,linux/arm64/v8 --tag sichev/fpm:8.5 --push . && \

docker buildx build -f dockerFiles/openswoole/openswoole-85.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole:8.5 --push . && \
docker buildx build -f dockerFiles/openswoole/openswoole-85-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole-dev:8.5 --push . && \

echo "Done!"
