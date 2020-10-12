const _ = require('lodash');
const moment = require('moment');

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

const getAllProducts = () => {
  return knex('products').select('*').orderBy('name');
};

const findProductById = (id) => {
  return knex('products')
    .select('*')
    .where('id', id)
    .then((results) => _.first(results));
};

const findProductByName = (name) => {
  return knex('products')
    .select('*')
    .where('name', name)
    .then((results) => _.first(results));
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
    .select('*')
    .orderBy('family_name')
    .orderBy('given_name');
};

const getAllCustomersWithOrderCount = () => {
  return knex('customers')
    .leftJoin('orders', 'customers.id', 'orders.customer_id')
    .groupBy('customers.id')
    .select('customers.*')
    .count('orders.id as order_count')
    .orderBy('family_name')
    .orderBy('given_name');
};

const getCustomerById = (customerId) => {
  return knex('customers')
    .select('*')
    .where('id', customerId)
    .then((results) => _.first(results));
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
  return knex('orders')
    .select('*')
    .where('id', orderId)
    .then((results) => _.first(results));
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

module.exports = {
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
  getAllOrders,
  getAllOrdersWithItemCount,
  getCustomerOrders,
  getOrderById,
  getOrderItems,
  insertOrder,
  updateOrder,
  deleteOrder,
};
