const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello from node.js and express!');
});
app.get('/images', (req, res) => {
  res.sendFile(__dirname + '/public/images/puppy.jpg');
});
app.use(express.static('public'));

app.listen(PORT, () => {
  console.log(`Server is listening on port ${PORT}`);
});
