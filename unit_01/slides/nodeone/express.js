const port = 3000;
const express = require('express');
const app = express();

app.use(express.static('public'));

var myRouter = require('./myRouter')
app.use('/myRouter', myRouter);

app.listen(port, () => {
    console.log(`The Express.js server is listening on port ${port}`);
});
