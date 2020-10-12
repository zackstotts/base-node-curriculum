const express = require('express');
const db = require('../db');
//const debug = require('debug')('app:routes:product');

// create and configure router
const router = express.Router();

// eslint-disable-next-line no-unused-vars
router.get('/', (req, res, next) => {
  db.getAllProducts()
    .then((results) => {
      res.render('product/list', { title: 'Product List', products: results });
    })
    .catch((err) => {
      next(err);
    });
});

// eslint-disable-next-line no-unused-vars
router.get('/add', (req, res, next) => {
  res.render('product/add', { title: 'Add Product' });
});

router.get('/edit/:id', (req, res, next) => {
  const id = req.params.id;
  db.findProductById(id)
    .then((product) => {
      if (product) {
        res.render('product/edit', { title: 'Edit Product', product });
      } else {
        res.status(404).render('error/basic', { title: 'Product Not Found' });
      }
    })
    .catch((err) => next(err));
});

router.get('/:id', (req, res, next) => {
  const id = req.params.id;

  db.findProductById(id)
    .then((product) => {
      if (product) {
        res.render('product/view', { title: product.name, product });
      } else {
        res.status(404).render('error/basic', { title: 'Product Not Found' });
      }
    })
    .catch((err) => next(err));
});

// export router
module.exports = router;
