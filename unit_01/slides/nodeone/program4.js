const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.use('/myRouter', require('./myRouter'));
app.use(express.static('public'));

app.listen(PORT, () => {
  console.log(`Server is listening on port ${PORT}`);
});
