FROM golang:1.14-alpine3.12 as builder

ENV GO111MODULE=on
RUN apk add --no-cache curl git
COPY . /cmd
RUN cd /cmd && go build

FROM alpine:3.12
LABEL maintainer="v.zorin@anchorfree.com"

RUN apk add --no-cache ca-certificates curl netcat-openbsd
COPY --from=builder /cmd/docker-s3sync /s3sync
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
