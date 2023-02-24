#!/bin/bash

set -xe

thisd="$(cd $(dirname $0);pwd)"
cd "${thisd}/../test"
make
docker compose up -d
got=$(curl -X POST "http://127.0.0.1:10002/echo" -d '{"name":"Alice"}')
[ "$got" = '{"value":"I got Alice"}' ]
docker compose stop
