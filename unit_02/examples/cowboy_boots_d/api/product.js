const db = require('../db');
const express = require('express');
const debug = require('debug')('app:api:product');

const router = express.Router();
router.use(express.urlencoded());
router.use(express.json());

router.get('/', async (req, res, next) => {
  debug('get all');
  try {
    const products = await db.getAllProducts();
    res.json(products);
  } catch (err) {
    next(err);
  }
});
router.get('/id/:id', async (req, res, next) => {
  debug('find by id');
  try {
    const id = req.params.id;
    const product = await db.findProductById(id);
    res.json(product);
  } catch (err) {
    next(err);
  }
});
router.get('/name/:name', async (req, res, next) => {
  debug('find by name');
  try {
    const name = req.params.name;
    const products = await db.findProductByName(name);
    res.json(products);
  } catch (err) {
    next(err);
  }
});
router.get('/category/:category', async (req, res, next) => {
  debug('find by category');
  try {
    const category = req.params.category;
    const products = await db.findProductByCategory(category);
    res.json(products);
  } catch (err) {
    next(err);
  }
});
router.post('/', async (req, res, next) => {
  debug('insert product');
  try {
    const product = req.body;
    const result = await db.insertProduct(product);
    res.json(result);
  } catch (err) {
    //next(err);
    res.status(500).json({ error: err });
  }
});
router.put('/:id', async (req, res, next) => {
  debug('update product');
  try {
    const product = req.body;
    product.id = req.params.id;
    const result = await db.updateProduct(product);
    res.json(result);
  } catch (err) {
    next(err);
  }
});
router.delete('/:id', async (req, res, next) => {
  debug('delete product');
  try {
    const id = req.params.id;
    const result = await db.deleteProduct(id);
    res.json(result);
  } catch (err) {
    next(err);
  }
});

module.exports = router;
