const db = require('../db');
const express = require('express');
const debug = require('debug')('app:api:product');
const Joi = require('joi');

const router = express.Router();
router.use(express.urlencoded({ extended: false }));
router.use(express.json());

const sendError = (err, res) => {
  debug(err);
  if (err.isJoi) {
    res.json({ error: err.details.map((x) => x.message).join('\n') });
  } else {
    res.json({ error: err.message });
  }
};

// eslint-disable-next-line no-unused-vars
router.get('/', async (req, res, next) => {
  debug('get all');
  try {
    const orders = await db.getAllOrdersWithItemCount();
    res.json(orders);
  } catch (err) {
    sendError(err, res);
  }
});

// eslint-disable-next-line no-unused-vars
router.get('/:id', async (req, res, next) => {
  debug('get by id');
  try {
    const schema = Joi.number().min(1).required().label('id');
    const id = await schema.validateAsync(req.params.id);
    const order = await db.getOrderById(id);
    res.json(order);
  } catch (err) {
    sendError(err, res);
  }
});

// eslint-disable-next-line no-unused-vars
router.post('/', async (req, res, next) => {
  debug('insert');
  try {
    const schema = Joi.object({
      customer_id: Joi.number().min(1).required(),
      paid: Joi.bool(),
      shipped: Joi.bool(),
    });
    const data = await schema.validateAsync(req.body, { abortEarly: false });
    const result = await db.insertOrder({
      customer_id: data.customer_id,
      payment_date: data.paid ? Date.now() : null,
      ship_date: data.shipped ? Date.now() : null,
    });
    res.json(result);
  } catch (err) {
    sendError(err, res);
  }
});

// eslint-disable-next-line no-unused-vars
router.put('/:id/paid', async (req, res, next) => {
  debug('order paid');
  try {
    const schema = Joi.number().min(1).required().label('id');
    const id = await schema.validateAsync(req.params.id);
    const result = await db.updateOrder({ id: id, payment_date: Date.now() });
    res.json(result);
  } catch (err) {
    sendError(err, res);
  }
});

// eslint-disable-next-line no-unused-vars
router.put('/:id/shipped', async (req, res, next) => {
  debug('order shipped');
  try {
    const schema = Joi.number().min(1).required().label('id');
    const id = await schema.validateAsync(req.params.id);
    const result = await db.updateOrder({ id: id, ship_date: Date.now() });
    res.json(result);
  } catch (err) {
    sendError(err, res);
  }
});

// eslint-disable-next-line no-unused-vars
router.delete('/:id', async (req, res, next) => {
  debug('delete');
  try {
    const schema = Joi.number().min(1).required().label('id');
    const id = await schema.validateAsync(req.params.id);
    const result = await db.deleteOrder(id);
    res.json(result);
  } catch (err) {
    sendError(err, res);
  }
});

module.exports = router;
