// initialize environment variables
require('dotenv').config();

// import libraries
const debug = require('debug')('app:server');
const express = require('express');
const hbs = require('express-handlebars');

// create and configure application
const app = express();
app.engine('handlebars', hbs());
app.set('view engine', 'handlebars');
app.use(express.urlencoded({ extended: false }));

// routes
app.get('/', async (req, res, next) => {
  res.render('home', { title: 'Home Page', products });
});

// static files
app.use('/', express.static('public'));

// start app
const hostname = process.env.HOSTNAME || 'localhost';
const port = process.env.PORT || 3000;
app.listen(port, () => {
  debug(`Server running at http://${hostname}:${port}/`);
});
