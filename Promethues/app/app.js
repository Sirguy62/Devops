const express = require('express');
const client = require('prom-client');

const app = express();
const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics({ timeout: 5000 });

const httpRequestDurationMicroseconds = new client.Histogram({
  name: 'http_request_duration_ms',
  help: 'Duration of HTTP requests in ms',
  labelNames: ['method', 'route', 'code'],
  buckets: [50, 100, 200, 300, 400, 500, 1000]
});

app.get('/', (req, res) => {
  const start = Date.now();
  res.send('Hello from Node app!');
  const duration = Date.now() - start;
  httpRequestDurationMicroseconds
    .labels(req.method, req.route.path, res.statusCode)
    .observe(duration);
});

app.get('/metrics', async (req, res) => {
  res.set('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
});

app.listen(8080, () => console.log('✅ App running on port 8080'));
