#!/bin/bash

#docker buildx build -f fpm-8.4.Dockerfile --platform linux/amd64,linux/arm64/v8 --tag sichev/fpm:8.4 --tag sichev/fpm:latest --push . && \
#
#docker buildx build -f openswoole-83.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole:stable -t sichev/octane-openswoole:8.3 --push . && \
#docker buildx build -f openswoole-83-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole-dev:stable -t sichev/octane-openswoole-dev:8.3 --push . && \

docker buildx build -f openswoole-84.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole:8.4 -t sichev/octane-openswoole:latest --push . && \

echo "Done!"
