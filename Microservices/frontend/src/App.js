import React, { useEffect, useState } from 'react';

function App() {
  const [users, setUsers] = useState([]);
  const [products, setProducts] = useState([]);

  useEffect(() => {
    fetch('/api/users').then(res => res.json()).then(setUsers);
    fetch('/api/products').then(res => res.json()).then(setProducts);
  }, []);

  return (
    <div style={{ padding: 20 }}>
      <h1>Microservices Demo</h1>
      <h2>Users:</h2>
      <ul>{users.map(u => <li key={u.id}>{u.name}</li>)}</ul>
      <h2>Products:</h2>
      <ul>{products.map(p => <li key={p.id}>{p.name}</li>)}</ul>
    </div>
  );
}

export default App;
