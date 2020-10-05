// initialize environment variables
require('dotenv').config();

// import libraries
const debug = require('debug')('app:server');
const express = require('express');
const hbs = require('express-handlebars');
const config = require('config');
const db = require('./db');

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
app.use(express.urlencoded({ extended: false }));

// routes
app.get('/', (req, res, next) => {
  db.getAllProducts()
    .then((results) => {
      res.render('home', { title: 'Home Page', products: results });
    })
    .catch((err) => {
      next(err);
    });
});
app.get('/product/:id', (req, res, next) => {
  const id = req.params.id;

  db.findProductById(id)
    .then(product => {
      if (product) {
        res.render('product-view', { title: product.name, product });
      } else {
        res.status(404).type('text/plain').send('product not found');
      }
    })
    .catch((err) => next(err));
});

app.use('/api/product', require('./api/product'));

// static files
app.use('/', express.static('public'));

// start app
const hostname = config.get('http.hostname');
const port = config.get('http.port');
app.listen(port, () => {
  debug(`Server running at http://${hostname}:${port}/`);
});
