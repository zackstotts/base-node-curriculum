var express = require('express');
var router = express.Router();

// define the home page route
router.get('/public/', function (req, res) {
  res.send('index.html');
})

// define the contact route
router.get('/public/contact', function (req, res) {
    res.send('contact.html')
});
// define the registration route
router.get('/public/registration', function (req, res) {
  res.send('registration.html')
});
  
module.exports = router;
  
