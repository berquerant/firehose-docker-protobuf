#!/bin/bash -xe

thisd="$(cd $(dirname $0);pwd)"

OUT=pb
rm -rf "${thisd}/${OUT}"
export PROTO_ROOT="$thisd"
export PROTO_PATH="hello.proto"
export GO_OUT="$OUT"
export GRPC_OUT="$OUT"
export GRPC_GATEWAY_OUT="$OUT"
export OPENAPI_OUT="$OUT"

"$thisd/../bin/firehose-docker-protobuf.sh"
ls -al "$OUT"
