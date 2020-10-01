// initialize environment variables
require('dotenv').config();

// import libraries
const debug = require('debug')('app:server');
const express = require('express');
const hbs = require('express-handlebars');
const mysql = require('mysql');
const config = require('config');

const databaseConfig = config.get('db');
const knex = require('knex')({
  client: 'mysql',
  connection: databaseConfig,
});
//const pool = mysql.createPool(databaseConfig);

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
  knex('products')
    .select('*')
    .orderBy('name')
    .then((results) => {
      res.render('home', { title: 'Home Page', products: results });
    })
    .catch((err) => {
      next(err);
    });

  // pool.query('SELECT * FROM products', (err, results) => {
  //   if (err) {
  //     next(err);
  //   } else {
  //     res.render('home', { title: 'Home Page', products: results });
  //   }
  // });
});
app.get('/product/:id', (req, res, next) => {
  const id = req.params.id;

  knex('products')
    .select('*')
    .where('id', id)
    .then((results) => {
      if (results && results.length == 1) {
        const product = results[0];
        res.render('product-view', { title: product.name, product });
      } else {
        res.status(404).type('text/plain').send('product not found');
      }
    })
    .catch((err) => next(err));

  // pool.query(`SELECT * FROM products WHERE id = '${id}'`, (err, results) => {
  //   if (err) {
  //     next(err);
  //   } else if (results.length == 1) {
  //     const product = results[0];
  //     res.render('product-view', { title: product.name, product });
  //   } else {
  //     res.status(404).send('Product Not Found');
  //   }
  // });
});

// static files
app.use('/', express.static('public'));

// start app
const hostname = config.get('http.hostname');
const port = config.get('http.port');
app.listen(port, () => {
  debug(`Server running at http://${hostname}:${port}/`);
});
