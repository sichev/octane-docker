#!/bin/bash

### FPM versions
docker buildx build -f dockerFiles/fpm/fpm-8.4.Dockerfile --platform linux/amd64,linux/arm64/v8 --tag sichev/fpm:8.4 --tag sichev/fpm:stable --push . && \
docker buildx build -f dockerFiles/fpm/fpm-8.4-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 --tag sichev/fpm-dev:8.4 --tag sichev/fpm-dev:stable --push . && \
docker buildx build -f dockerFiles/fpm/fpm-8.5.Dockerfile --platform linux/amd64,linux/arm64/v8 --tag sichev/fpm:8.5 --tag sichev/fpm:latest --push . && \
docker buildx build -f dockerFiles/fpm/fpm-8.5-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 --tag sichev/fpm-dev:8.5 --tag sichev/fpm-dev:latest --push .


### Open Swoole versions
docker buildx build -f dockerFiles/openswoole/openswoole-83.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole:stable -t sichev/octane-openswoole:8.3 --push . && \
docker buildx build -f dockerFiles/openswoole/openswoole-83-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole-dev:stable -t sichev/octane-openswoole-dev:8.3 --push .

docker buildx build -f dockerFiles/openswoole/openswoole-84.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole:8.4 -t sichev/octane-openswoole:latest --push . && \
docker buildx build -f dockerFiles/openswoole/openswoole-84-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole-dev:8.4 -t sichev/octane-openswoole-dev:latest --push .

docker buildx build -f dockerFiles/openswoole/openswoole-85.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole:8.5 --push . && \
docker buildx build -f dockerFiles/openswoole/openswoole-85-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole-dev:8.5 --push .


echo "Done!"
