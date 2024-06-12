# Deploying the operator

```bash
curl https://raw.githubusercontent.com/grafana/k6-operator/main/bundle.yaml | kubectl apply -f -
```

## Adding test scripts

#### LocalFile

We configure to run a test script inside the docker image. you can pass it to the test like this:

```yaml
spec:
  parallelism: 4
  script:
    localFile: /test/read-senario.js
```

```yaml
spec:
  parallelism: 4
  script:
    localFile: /test/write-senario.js
```

The test configuration is applied using

```bash
kubectl apply -f test-run.yaml
```

### Using extensions
By default, the operator will use `grafana/k6:latest` as the container image for the test jobs.
If we want to use [extensions](https://k6.io/docs/extensions/get-started/explore/) built with [xk6](https://github.com/grafana/xk6) we'll need to create our own image and override the `image` property on the `TestRun` kubernetes resource.

For example, In this `Dockerfile` we use loki extension.

