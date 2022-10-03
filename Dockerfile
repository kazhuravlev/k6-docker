FROM golang:1.19 as builder

ENV XK6_VERSION=latest

RUN go install go.k6.io/xk6/cmd/xk6@${XK6_VERSION}

ENV K6_VERSION=v0.40.0

RUN xk6 build \
    --with github.com/grafana/xk6-output-prometheus-remote \
    && mv ./k6 /bin/k6

FROM alpine:3.16

COPY --from=builder /bin/k6 /bin/k6

