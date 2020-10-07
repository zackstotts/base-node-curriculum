const express = require('express');
const debug = require('debug')('app:routes:product');
const db = require('../db');

const router = express.Router();

router.get('/', (req, res, next) => {
  db.getAllProducts()
    .then((results) => {
      res.render('product-list', { title: 'Product List', products: results });
    })
    .catch((err) => {
      next(err);
    });
});
router.get('/add', (req, res, next) => {
  res.render('product-add', { title: 'Add Product' });
});
router.get('/edit/:id', (req, res, next) => {
  const id = req.params.id;
  db.findProductById(id)
    .then((product) => {
      if (product) {
        res.render('product-edit', { title: 'Edit Product', product });
      } else {
        res.status(404).type('text/plain').send('product not found');
      }
    })
    .catch((err) => next(err));
});
router.get('/:id', (req, res, next) => {
  const id = req.params.id;

  db.findProductById(id)
    .then((product) => {
      if (product) {
        res.render('product-view', { title: product.name, product });
      } else {
        res.status(404).type('text/plain').send('product not found');
      }
    })
    .catch((err) => next(err));
});

module.exports = router;