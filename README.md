# Deploying the operator

```bash
curl https://raw.githubusercontent.com/grafana/k6-operator/main/bundle.yaml | kubectl apply -f -
```

## Adding test scripts

#### ConfigMap

Run the following command to configure through `ConfigMap` our jobs and serve test scripts to the jobs.

```bash
kubectl create configmap read-senario  --from-file ./test/read-senario.js
kubectl create configmap write-senario --from-file ./test/write-senario.js
```

### Using extensions
By default, the operator will use `grafana/k6:latest` as the container image for the test jobs.
If we want to use [extensions](https://k6.io/docs/extensions/get-started/explore/) built with [xk6](https://github.com/grafana/xk6) we'll need to create our own image and override the `image` property on the `TestRun` kubernetes resource.

For example, In this `Dockerfile` we use loki extension.

