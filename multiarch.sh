#!/bin/sh
TAG="mancioman2/simplepage:latest"
PLATFORMS="linux/amd64,linux/arm64,linux/arm/v6,linux/arm/v7"

echo "--- BUILD THE CONTAINER BUILDER --"
docker buildx create --name mbuilder
echo "-- USE THE BUILDER --"
docker buildx use mbuilder
echo "-- BUILD ON PLATFORMS: $PLATFORMS AND PUSH TO: $TAG"
docker buildx build --platform $PLATFORMS -t $TAG --push .
