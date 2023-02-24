package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"os"
	"strconv"

	"github.com/berquerant/firehose-docker-protobuf/test/pb"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	ls, err := net.Listen("tcp", fmt.Sprintf(":%d", getPort()))
	fail(err)
	s := grpc.NewServer()
	pb.RegisterHelloServiceServer(s, &server{})
	reflection.Register(s)
	log.Printf("listening on %v", ls.Addr())
	fail(s.Serve(ls))
}

type server struct {
	pb.UnimplementedHelloServiceServer
}

func (s *server) Echo(ctx context.Context, in *pb.HelloRequest) (*pb.HelloResponse, error) {
	log.Printf("Received: %s", in.GetName())
	return &pb.HelloResponse{
		Value: fmt.Sprintf("I got %s", in.GetName()),
	}, nil
}

func getPort() int {
	if port := os.Getenv("PORT"); port != "" {
		p, err := strconv.Atoi(port)
		fail(err)
		return p
	}
	return 40100
}

func fail(err error) {
	if err != nil {
		panic(err)
	}
}
