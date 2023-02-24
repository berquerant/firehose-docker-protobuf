#!/bin/bash

docker build . --tag "${IMAGE_NAME:-firehose-docker-protobuf}:${IMAGE_TAG:-1}"
