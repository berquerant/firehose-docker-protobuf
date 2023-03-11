FROM --platform=linux/amd64 golang:1.20.2-bullseye

WORKDIR /protoc

RUN apt-get update && apt-get install -y \
    zip \
    unzip \
 && rm -rf /var/lib/apt/lists/* && \
    wget --version && \
    unzip -v

# https://github.com/protocolbuffers/protobuf/releases
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v22.2/protoc-22.2-linux-x86_64.zip -O protoc.zip && \
    unzip protoc.zip && \
    ln -snvf /protoc/bin/protoc /usr/bin/protoc && \
    protoc --version

RUN git clone https://github.com/googleapis/googleapis.git

COPY ./go.mod .
COPY ./go.sum .
COPY ./tools.go .
RUN go install \
    google.golang.org/protobuf/cmd/protoc-gen-go \
    google.golang.org/grpc/cmd/protoc-gen-go-grpc \
    github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
    github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
