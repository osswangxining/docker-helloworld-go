FROM registry.cn-hangzhou.aliyuncs.com/wangxining/golang:latest AS builder

RUN mkdir -p /go/src/go-helloworld
COPY ./main.go /go/src/go-helloworld/

RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o /go/bin/go-helloworld ./src/go-helloworld

FROM alpine:latest
RUN apk --no-cache add ca-certificates

COPY --from=builder /go/bin/go-helloworld /go-helloworld

WORKDIR /

ENTRYPOINT ["/go-helloworld"]
