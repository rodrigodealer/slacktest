FROM golang:1.11-alpine as builder
WORKDIR /go/src/brfutebol/slack-ci-bot
COPY . .
ENV GO111MODULE=on

RUN apk -U add git build-base && \
    mkdir -p /build && \
    go build  -ldflags '-extldflags "-static"' -o /build/slack-ci-bot

FROM alpine:3.7
RUN apk -U add ca-certificates curl && rm -rf /var/cache/apk/*
WORKDIR /opt
COPY --from=builder /build/slack-ci-bot .
CMD ["./opt/slack-ci-bot"]
