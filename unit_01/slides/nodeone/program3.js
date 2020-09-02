const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello from node.js and express!');
});
app.get('/puppy', (req, res) => {
  res.sendFile(path.join(__dirname, '/public/images/puppy.jpg'));
});
app.use(express.static('public'));

app.listen(PORT, () => {
  console.log(`Server is listening on port ${PORT}`);
});
