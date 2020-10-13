const express = require('express');
const db = require('../db');
const moment = require('moment');
//const debug = require('debug')('app:routes:customer');

// create and configure router
const router = express.Router();

router.get('/', async (req, res, next) => {
  try {
    const registered = req.query.registered;
    const search = req.query.search;

    let query = db.getAllCustomersWithOrderCount();
    if (registered) {
      const cutoff = moment().add(registered, 'days').toDate();
      query = query.where('register_date', '>=', cutoff);
    }
    if (search) {
      query = query.whereRaw(
        'MATCH (given_name,family_name,email) AGAINST (? IN NATURAL LANGUAGE MODE)',
        [search]
      );
    } else {
      query = query.orderBy('family_name').orderBy('given_name');
    }
    const customers = await query;

    res.render('customer/list', {
      title: 'Customer List',
      customers,
      registered,
      search,
    });
  } catch (err) {
    next(err);
  }
});

router.get('/:id', async (req, res, next) => {
  try {
    const customerId = req.params.id;
    const customer = await db.getCustomerById(customerId);
    if (customer) {
      const orders = await db
        .getCustomerOrders(customerId)
        .orderBy('id', 'desc');
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
