// initialize environment variables
require('dotenv').config();

// import libraries
const debug = require('debug')('app:server');
const express = require('express');
const hbs = require('express-handlebars');
const config = require('config');
//const db = require('./db');

// create and configure application
const app = express();
app.engine(
  'handlebars',
  hbs({
    helpers: {
      formatPrice: (price) => '$' + price.toFixed(2),
    },
  })
);
app.set('view engine', 'handlebars');
//app.use(express.urlencoded({ extended: false }));

// routes
app.get('/', (req, res) => res.redirect('/product')); // placeholder for home page
app.use('/product', require('./routes/product'));
app.use('/api/product', require('./api/product'));

// static files
app.use('/', express.static('public'));

// 404 error page
app.use((request, response) => {
  response.status(404).type('text/plain').send('Page Not Found');
});

// start app
const hostname = config.get('http.hostname');
const port = config.get('http.port');
app.listen(port, () => {
  debug(`Server running at http://${hostname}:${port}/`);
});
