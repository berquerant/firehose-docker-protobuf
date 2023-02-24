.PHONY: docker
docker: docker-server docker-gateway

.PHONY: pb
pb: # compile hello.proto
	./pb.sh

.PHONY: docker-server
docker-server: pb # build grpc server container
	docker build . -f Dockerfile.server --tag firehose-docker-protobuf-test-server

.PHONY: docker-gateway
docker-gateway: pb # build grpc gateway container
	docker build . -f Dockerfile.gateway --tag firehose-docker-protobuf-test-gateway
