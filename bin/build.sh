#!/bin/bash -xe

docker build . --tag "${IMAGE_NAME}:${IMAGE_TAG}"
