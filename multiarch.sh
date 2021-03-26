#!/bin/sh
TAG="mancioman2/simplepage:latest"
PLATFORMS="linux/amd64,linux/arm64,linux/arm/v6,linux/arm/v7"

docker buildx create --name mbuilder
docker buildx use mbuilder
docker buildx build --platform $PLATFORMS -t $TAG --push .