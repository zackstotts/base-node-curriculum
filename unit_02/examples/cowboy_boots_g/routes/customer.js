const express = require('express');
const db = require('../db');
//const debug = require('debug')('app:routes:customer');

// create and configure router
const router = express.Router();

router.get('/', async (req, res, next) => {
  try {
    const customers = await db.getAllCustomersWithOrderCount();
    res.render('customer/list', { title: 'Customer List', customers });
  } catch (err) {
    next(err);
  }
});

router.get('/:id', async (req, res, next) => {
  try {
    const customerId = req.params.id;
    const customer = await db.getCustomerById(customerId);
    if (customer) {
      const orders = await db.getCustomerOrders(customerId);
      const title = `${customer.given_name} ${customer.family_name}`;
      res.render('customer/view', { title, customer, orders });
    } else {
      res.status(404).render('error/basic', { title: 'Customer Not Found' });
    }
  } catch (err) {
    next(err);
  }
});

// export router
module.exports = router;
