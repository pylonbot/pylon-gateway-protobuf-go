#!/bin/bash

echo "> installing protoc"
export GO111MODULE=on
go get google.golang.org/protobuf/cmd/protoc-gen-go \
    google.golang.org/grpc/cmd/protoc-gen-go-grpc

echo "> removing old directories"
rm -rf discord
rm -rf gateway

echo "> cloning fresh protos..."
rm -rf proto
git clone git@github.com:pylonbot/pylon-gateway-protobuf proto

echo "> generating code"
protoc -Iproto --go_out=. --go_opt=paths=source_relative \
    --go-grpc_out=. --go-grpc_opt=paths=source_relative \
    $(find ./ -type f -name "*.proto" | grep -v google)

echo "> go mod tidy"
go mod tidy
