const express = require('express');
const app = express();

app.get('/api/users', (req, res) => {
  res.json([{ id: 1, name: "John Doe" }, { id: 2, name: "Jane Doe" }]);
});

app.listen(4000, () => console.log('User service running on port 4000'));
