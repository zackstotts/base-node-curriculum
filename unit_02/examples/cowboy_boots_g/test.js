const db = require('./db');

db.getProductCount()
  .then((results) => console.log(results))
  .catch((err) => console.error(err));

// db.knex('products')
//   .groupBy('category')
//   .having(db.knex.raw('count(*) > 1'))
//   .select('category')
//   .count('* as count')
//   .then((results) => console.log(results))
//   .catch((err) => console.error(err));

// db.knex
//   .union([
//     db.knex('products').select('id', 'name').where('id', '<=', '4'),
//     db.knex('customers').select('id', 'given_name').where('id', '<=', '4'),
//   ])
//   .then((results) => console.log(results))
//   .catch((err) => console.error(err));
