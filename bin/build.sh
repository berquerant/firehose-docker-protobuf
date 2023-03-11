#!/bin/bash

image_version="0.2.0"
image_name="firehose-docker-protobuf"
image_tag="${image_name}:${image_version}"
latest_image_tag="${image_name}:latest"

docker build . --tag "$image_tag"
docker tag "$image_tag" "$latest_image_tag"
