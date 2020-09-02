const express = require('express');
const path = require('path');
const router = express.Router();

// define the home page route
router.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/index.html'));
});

// define the contact route
router.get('/contact', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/contact.html'));
});
// define the register route
router.get('/register', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/register.html'));
});

module.exports = router;
