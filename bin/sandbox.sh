#!/bin/bash

# Experimental builds. Just testing.
# It's OK that some images from this list can't build properly

docker buildx build -f dockerFiles/openswoole/openswoole-85.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole:8.5 --push . && \
docker buildx build -f dockerFiles/openswoole/openswoole-85-dev.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole-dev:8.5 --push .

docker buildx build -f dockerFiles/swoole/swoole-84.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/php-swoole:8.4 . && \

echo "Done!"
