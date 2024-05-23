#!/bin/bash

echo "Work in progress".
docker buildx build -f openswoole.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/php-openswoole:latest .
