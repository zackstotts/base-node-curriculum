// initialize environment variables
require('dotenv').config();

// import libraries
const debug = require('debug')('app:server');
const express = require('express');
const hbs = require('express-handlebars');
const mysql = require('mysql');

const databaseConfig = {
  database: 'cowboy_boots_3',
  host: 'localhost',
  port: 3306,
  user: 'admin',
  password: 'password',
  connectionLimit: 10
};
const pool = mysql.createPool(databaseConfig);

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
app.get('/', (req, res, next) => {
  pool.query('SELECT * FROM products', (err, results) => {
    if (err) {
      next(err);
    } else {
      res.render('home', { title: 'Home Page', products: results });
    }
  });
});
app.get('/product/:id', (req, res, next) => {
  const id = req.params.id;
  pool.query(`SELECT * FROM products WHERE id = '${id}'`, (err, results) => {
    if (err) {
      next(err);
    } else if (results.length == 1) {
      const product = results[0];
      res.render('product-view', { title: product.name, product });
    } else {
      res.status(404).send('Product Not Found');
    }
  });
});

// static files
app.use('/', express.static('public'));

// start app
const hostname = process.env.HOSTNAME || 'localhost';
const port = process.env.PORT || 3000;
app.listen(port, () => {
  debug(`Server running at http://${hostname}:${port}/`);
});
