const express = require('express');
const db = require('../db');
//const debug = require('debug')('app:routes:product');

// create and configure router
const router = express.Router();

// eslint-disable-next-line no-unused-vars
router.get('/', async (req, res, next) => {
  try {
    const products = await db.getAllProducts();
    res.render('product/list', { title: 'Product List', products });
  } catch (err) {
    next(err);
  }
});

// eslint-disable-next-line no-unused-vars
router.get('/add', (req, res, next) => {
  res.render('product/add', { title: 'Add Product' });
});

router.get('/edit/:id', async (req, res, next) => {
  try {
    const id = req.params.id;
    const product = await db.findProductById(id);
    if (product) {
      res.render('product/edit', { title: 'Edit Product', product });
    } else {
      res.status(404).render('error/basic', { title: 'Product Not Found' });
    }
  } catch (err) {
    next(err);
  }
});

router.get('/:id', async (req, res, next) => {
  try {
    const id = req.params.id;
    const product = await db.findProductById(id);
    if (product) {
      res.render('product/view', { title: product.name, product });
    } else {
      res.status(404).render('error/basic', { title: 'Product Not Found' });
    }
  } catch (err) {
    next(err);
  }
});

// export router
module.exports = router;
