// initialize environment variables
require('dotenv').config();

// import libraries
const debug = require('debug')('app:server');
const config = require('config');
const express = require('express');
const hbs = require('express-handlebars');
const db = require('./db');

// create and configure application
const app = express();
app.engine('handlebars', hbs({
  helpers: {
    formatPrice: (price) => '$' + price.toFixed(2)
  }
}));
app.set('view engine', 'handlebars');
app.use(express.urlencoded({ extended: false }));

// routes
app.get('/', async (req, res, next) => {
  try {
    const products = await db.getAllProducts();
    res.render('home', { title: 'Home Page', products });
  } catch (err) {
    next(err);
  }
});
app.get('/product/:id', async (req, res, next) => {
  try {
    const id = req.params.id;
    const product = await db.findProductById(id);
    res.render('product-view', { title: 'Product View', product });
  } catch (err) {
    next(err);
  }
});

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
