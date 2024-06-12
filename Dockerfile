FROM golang:1.22.2 as builder

RUN go install go.k6.io/xk6/cmd/xk6@latest
RUN CGO_ENABLED=0 xk6 build \
    --with github.com/grafana/xk6-loki@latest \
    --output /k6

FROM grafana/k6:latest
COPY --from=builder /k6 /usr/bin/k6

COPY --from=kvij/scuttle:latest scuttle /bin/scuttle
ENTRYPOINT ["scuttle", "k6"]
