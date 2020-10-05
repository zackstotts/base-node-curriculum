const _ = require('lodash');

// get connection config
const config = require('config');
const databaseConfig = config.get('db');

// connect to the database
const knex = require('knex')({
  client: 'mysql',
  connection: databaseConfig,
});

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
    price: product.price
  });
}

const updateProduct = (product) => {
  return knex('products').where('id', product.id).update({
    name: product.name,
    category: product.category,
    price: product.price
  });
}

const deleteProduct = (id) => {
  return knex('products').where('id', id).delete();
}

module.exports.getAllProducts = getAllProducts;
module.exports.findProductById = findProductById;
module.exports.findProductByName = findProductByName;
module.exports.findProductByCategory = findProductByCategory;
module.exports.insertProduct = insertProduct;
module.exports.updateProduct = updateProduct;
module.exports.deleteProduct = deleteProduct;
