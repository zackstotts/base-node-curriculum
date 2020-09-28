/**
 * Database Module
 * using config and knex query builder
 * @see https://www.npmjs.com/package/config
 * @see https://www.npmjs.com/package/knex
 * @module db
 */

// imports
const config = require('config');
const { result } = require('lodash');
const _ = require('lodash');

// create database connection
const dbConfig = config.get('db');
const knex = require('knex')({ client: 'mysql', connection: dbConfig });

async function getAllProducts() {
  const results = await knex('products').select('*').orderBy('name');
  return results;
}

async function findProductById(id) {
  const results = await knex('products').where('id', id).select('*');
  return _.first(results);
}

// exports
module.exports.getAllProducts = getAllProducts;
module.exports.findProductById = findProductById;
