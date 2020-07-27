const port = 3000;
const express = require('express');
const app = express();

app.use(express.static('public'));

app.get('/images', function (req, res) {
    res.sendFile( __dirname + "/public/images/" + "puppy.jpg" );
 });

app.get("/", (req, res) => {
  res.send("Hello from node.js and express!");
})
.listen(port, () => {
    console.log(`The Express.js server is listening on port ${port}`);
});
