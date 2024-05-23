#!/bin/bash

docker buildx build -f openswoole.Dockerfile --platform linux/amd64,linux/arm64/v8 -t sichev/octane-openswoole:latest .
