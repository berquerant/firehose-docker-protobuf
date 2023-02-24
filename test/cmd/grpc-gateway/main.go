package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"

	"github.com/berquerant/firehose-docker-protobuf/test/pb"
	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	mux := runtime.NewServeMux()
	opts := []grpc.DialOption{grpc.WithTransportCredentials(insecure.NewCredentials())}
	fail(pb.RegisterHelloServiceHandlerFromEndpoint(ctx, mux, getGRPCEndpoint(), opts))
	log.Printf("gateway listening on %d for %s", getPort(), getGRPCEndpoint())
	fail(http.ListenAndServe(fmt.Sprintf(":%d", getPort()), mux))
}

func getGRPCEndpoint() string {
	x := os.Getenv("GRPC_ENDPOINT")
	if x == "" {
		log.Fatal("missing GRPC_ENDPOINT")
	}
	return x
}

func getPort() int {
	if port := os.Getenv("PORT"); port != "" {
		p, err := strconv.Atoi(port)
		fail(err)
		return p
	}
	return 40200
}

func fail(err error) {
	if err != nil {
		panic(err)
	}
}
