#!/bin/bash

# Experimental builds. Just testing.
# It's OK that some images from this list can't build properly

docker buildx build -f dockerFiles/swoole/swoole-84.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/php-swoole:8.4 . && \

echo "Done!"
