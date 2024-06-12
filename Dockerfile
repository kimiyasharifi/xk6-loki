# Build the k6 binary with the extension
FROM docker.io/library/golang:1.22.2 as builder

RUN go install go.k6.io/xk6/cmd/xk6@latest
# For our example, we'll add support for output of test metrics to InfluxDB v2.
# Feel free to add other extensions using the '--with ...'.
RUN xk6 build \
    --with github.com/grafana/xk6-loki@latest \
    --output /k6

# Use the operator's base image and override the k6 binary
FROM grafana/k6:latest
COPY --from=builder /k6 /usr/bin/k6
WORKDIR /test
COPY ./test /test
