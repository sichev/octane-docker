#!/bin/bash

docker buildx build -f fpm.Dockerfile --platform linux/arm64/v8 -t sichev/php-fpm:latest . && \
echo "Done!"
