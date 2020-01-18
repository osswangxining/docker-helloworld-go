FROM registry.cn-beijing.aliyuncs.com/istio-samples/golang:1.12.10 AS builder
RUN mkdir -p /go/src/go-helloworld
COPY ./main.go /go/src/go-helloworld/
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o /go/bin/go-helloworld ./src/go-helloworld

FROM alpine:latest
COPY --from=builder /go/bin/go-helloworld /go-helloworld
WORKDIR /
ENTRYPOINT ["/go-helloworld"]
