//const _ = require('lodash');
const moment = require('moment');
const debug = require('debug')('app:db');

// get connection config
const config = require('config');
const databaseConfig = config.get('db');

// connect to the database
const knex = require('knex')({
  client: 'mysql',
  connection: databaseConfig,
});

// utilities

// eslint-disable-next-line no-unused-vars
const formatDatetime = (date) =>
  date ? moment(date).format('YYYY-MM-DD HH:mm:ss') : date;

// eslint-disable-next-line no-unused-vars
const formatDate = (date) => (date ? moment(date).format('YYYY-MM-DD') : date);

// products

const getProductCount = () => {
  return knex('products').count('* as count');
};

const getAllProducts = () => {
  return knex('products').select('*');
};

const findProductById = (id) => {
  return knex('products').where('id', id).select('*').first();
};

const findProductByName = (name) => {
  return knex('products').where('name', name).select('*').first();
};

const findProductByCategory = (category) => {
  return knex('products').select('*').where('category', category);
};

const insertProduct = (product) => {
  return knex('products').insert({
    name: product.name,
    category: product.category,
    price: product.price,
  });
};

const updateProduct = (product) => {
  return knex('products').where('id', product.id).update({
    name: product.name,
    category: product.category,
    price: product.price,
  });
};

const deleteProduct = (productId) => {
  return knex('products').where('id', productId).delete();
};

// customers

const getAllCustomers = () => {
  return knex('customers')
    .select(
      'customers.id',
      'customers.given_name',
      'customers.family_name',
      'customers.email',
      'customers.register_date'
    )
    .orderBy('family_name')
    .orderBy('given_name');
};

const getAllCustomersWithOrderCount = () => {
  return knex('customers')
    .leftJoin('orders', 'customers.id', 'orders.customer_id')
    .groupBy('customers.id')
    .select(
      'customers.id',
      'customers.given_name',
      'customers.family_name',
      'customers.email',
      'customers.register_date'
    )
    .count('orders.id as order_count')
    .orderBy('family_name')
    .orderBy('given_name');
};

const getCustomerById = (customerId) => {
  return knex('customers').where('id', customerId).select('*').first();
};

const insertCustomer = (customer) => {
  return knex('customers').insert({
    given_name: customer.given_name,
    family_name: customer.family_name,
    email: customer.email,
    password: customer.password,
  });
};

const updateCustomer = (customer) => {
  return knex('customers').where('id', customer.id).update({
    given_name: customer.given_name,
    family_name: customer.family_name,
    email: customer.email,
    password: customer.password,
  });
};

const deleteCustomer = (customerId) => {
  return knex('customers').where('id', customerId).delete();
};

// orders

const getAllOrders = () => {
  return knex('orders').select('*').orderBy('id');
};

const getAllOrdersWithItemCount = () => {
  return knex('orders')
    .leftJoin('order_items', 'orders.id', 'order_items.order_id')
    .groupBy('orders.id')
    .select('orders.*')
    .count('order_items.product_id as item_count')
    .orderBy('id');
};

const getCustomerOrders = (customerId) => {
  return knex('orders')
    .where('customer_id', customerId)
    .leftJoin('order_items', 'orders.id', 'order_items.order_id')
    .groupBy('orders.id')
    .select('orders.*')
    .count('order_items.product_id as item_count')
    .orderBy('id');
};

const getOrderById = (orderId) => {
  return knex('orders').where('id', orderId).select('*').first();
};

const getOrderItems = (orderId) => {
  return knex('order_items')
    .leftJoin('products', 'products.id', 'order_items.product_id')
    .select(
      'order_items.product_id',
      'order_items.quantity',
      'order_items.price as price_paid',
      'products.name as product_name',
      'products.price as list_price'
    )
    .where('order_id', orderId);
};

const insertOrder = (order) => {
  return knex('orders').insert({
    customer_id: order.customer_id,
    payment_date: formatDatetime(order.payment_date),
    ship_date: formatDatetime(order.ship_date),
  });
};

const updateOrder = (order) => {
  return knex('orders')
    .where('id', order.id)
    .update({
      customer_id: order.customer_id,
      payment_date: formatDatetime(order.payment_date),
      ship_date: formatDatetime(order.ship_date),
    });
};

const deleteOrder = (orderId) => {
  return knex('orders').where('id', orderId).delete();
};

const addOrderItem = async (data) => {
  const item = await knex('order_items')
    .where('order_id', data.order_id)
    .where('product_id', data.product_id)
    .select('*')
    .first();
  if (item) {
    //debug('item found ' + JSON.stringify(item));
    const newQuantity =
      (parseInt(item.quantity) || 0) + (parseInt(data.quantity) || 0);
    //debug(newQuantity);
    const result = await knex('order_items')
      .where('order_id', data.order_id)
      .where('product_id', data.product_id)
      .update({
        quantity: newQuantity,
      });
    debug('updated ' + result);
  } else {
    const product = await knex('products')
      .where('id', data.product_id)
      .select('price')
      .first();
    //debug('product found ' + JSON.stringify(product));
    if (product) {
      const result = await knex('order_items').insert({
        order_id: data.order_id,
        product_id: data.product_id,
        quantity: data.quantity,
        price: product.price,
      });
      debug('inserted ' + result);
    }
  }
  return item;
};

module.exports = {
  knex,
  getProductCount,
  getAllProducts,
  findProductById,
  findProductByName,
  findProductByCategory,
  insertProduct,
  updateProduct,
  deleteProduct,
  getAllCustomers,
  getAllCustomersWithOrderCount,
  getCustomerById,
  insertCustomer,
  updateCustomer,
  deleteCustomer,
  getAllOrders,
  getAllOrdersWithItemCount,
  getCustomerOrders,
  getOrderById,
  getOrderItems,
  insertOrder,
  updateOrder,
  deleteOrder,
  addOrderItem,
};
