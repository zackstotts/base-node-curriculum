const express = require('express');
const db = require('../db');
const _ = require('lodash');
//const debug = require('debug')('app:routes:order');

// create and configure router
const router = express.Router();

router.get('/', async (req, res, next) => {
  try {
    const orders = await db.getAllOrdersWithItemCount();
    res.render('order/list', { title: 'Order List', orders });
  } catch (err) {
    next(err);
  }
});

router.get('/:id', async (req, res, next) => {
  try {
    const orderId = req.params.id;
    const order = await db.getOrderById(orderId);
    if (order) {
      const customer = await db.getCustomerById(order.customer_id);
      const items = await db.getOrderItems(orderId);
      const totalCost = _.sum(items.map(x => x.quantity * (x.price_paid || x.list_price)));
      const title = `Order ${order.id}`;
      res.render('order/view', { title, customer, order, items, totalCost });
    } else {
      res.status(404).render('error/basic', { title: 'Order Not Found' });
    }
  } catch (err) {
    next(err);
  }
});


// export router
module.exports = router;
