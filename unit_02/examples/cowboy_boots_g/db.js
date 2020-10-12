const _ = require('lodash');

// get connection config
const config = require('config');
const databaseConfig = config.get('db');

// connect to the database
const knex = require('knex')({
  client: 'mysql',
  connection: databaseConfig,
});

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
    .select('customers.*')
    .count('orders.id as order_count')
    .groupBy('customers.id')
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

const getCustomerOrders = (customerId) => {
  return knex('orders')
    .select('*')
    .where('customer_id', customerId)
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
  getCustomerOrders,
  getOrderById,
  getOrderItems,
};
