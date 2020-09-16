// initialize environment variables
require('dotenv').config();

// import libraries
const debug = require('debug')('app:server');
const path = require('path');
const express = require('express');
const hbs = require('express-handlebars');

// create and configure application
const app = express();
app.engine('handlebars', hbs());
app.set('view engine', 'handlebars');
app.use(express.urlencoded({ extended: false }));

// routes
app.get('/', (req, res) => res.render('home', { title: 'Home Page' }));
app.get('/contact', (req, res) =>
  res.render('contact', { title: 'Contact Form' })
);
app.post('/contact', (req, res) => {
  const name = req.body.name;
  const message = req.body.message;

  debug(`name = ${name}`);
  debug(`message = ${message}`);

  const data = {
    title: 'Contact Form',
    isValid: true,
    name,
    message,
  };

  if (!name) {
    data.isValid = false;
    data.nameError = 'name not provided.';
  }
  if (!message) {
    data.isValid = false;
    data.messageError = 'message not provided.';
  }

  data.result = data.isValid ? 'Message Sent!' : 'Please fix the errors above!';
  if (req.accepts('html')) {
    res.render('contact', data);
  } else {
    res.json(data);
  }
});

// static files
app.use('/', express.static('public'));

// start app
const port = process.env.PORT || 3000;
app.listen(port, () => debug(`Server started on port ${port}`));
