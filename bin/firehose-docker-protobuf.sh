#!/bin/bash

proto_path="$PROTO_PATH"

docker_image="${IMAGE_NAME:-firehose-docker-protobuf}:${IMAGE_TAG:-0.1.1}"
proto_root_path=${PROTO_ROOT:-$PWD}
go_out_relpath=${GO_OUT:-.}
grpc_out_relpath=${GRPC_OUT:-$go_out_relpath}
grpc_gateway_out_relpath=${GRPC_GATEWAY_OUT:-$grpc_out_relpath}
openapi_out_relpath=${OPENAPI_OUT:-$grpc_gateway_out_relpath}

internal_srcd="/usr/src/app"

mkdir -p "$go_out_relpath" "$grpc_out_relpath" "$grpc_gateway_out_relpath" "$openapi_out_relpath"
docker run -v "${proto_root_path}:${internal_srcd}" \
       -w "$internal_srcd" \
       --rm "$docker_image" \
       protoc -I/protoc/include -I/protoc/googleapis -I. \
       --go_out="$go_out_relpath" \
       --go_opt=paths=source_relative \
       --go-grpc_out="$grpc_out_relpath" \
       --go-grpc_opt=paths=source_relative \
       --grpc-gateway_out="$grpc_gateway_out_relpath" \
       --grpc-gateway_opt=logtostderr=true \
       --grpc-gateway_opt=paths=source_relative \
       --openapiv2_out="$openapi_out_relpath" \
       "$proto_path"
