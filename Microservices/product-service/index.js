const express = require('express');
const app = express();

app.get('/api/products', (req, res) => {
  res.json([{ id: 1, name: "Laptop" }, { id: 2, name: "Phone" }]);
});

app.listen(5000, () => console.log('Product service running on port 5000'));
