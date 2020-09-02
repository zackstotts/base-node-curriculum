const express = require('express');
const router = express.Router();

// define the home page route
router.get('/public/', (req, res) => {
  res.send('index.html');
});

// define the contact route
router.get('/public/contact', (req, res) => {
  res.send('contact.html');
});
// define the registration route
router.get('/public/registration', (req, res) => {
  res.send('registration.html');
});

module.exports = router;
