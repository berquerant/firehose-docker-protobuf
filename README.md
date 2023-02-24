# firehose-docker-protobuf

Compile proto files.

# Usage

``` bash
# build image
bin/build.sh
# compile proto
export PROTO_ROOT="/path/to/proto/dir"
export PROTO_PATH=example.proto
export GO_OUT=examplepb
bin/firehose-docker-protobuf.sh
```

# Test

``` bash
# build image
bin/build.sh
# exec test
bin/test.sh
```

c.f. [README.md](test/README.md)
