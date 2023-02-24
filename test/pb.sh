#!/bin/bash -xe

thisd="$(cd $(dirname $0);pwd)"

export PROTO_ROOT="$thisd"
export PROTO_PATH="hello.proto"
export GO_OUT=pb
export GRPC_OUT=pb
export GRPC_GATEWAY_OUT=pb
export OPENAPI_OUT=pb

"$thisd/../bin/firehose-docker-protobuf.sh"
