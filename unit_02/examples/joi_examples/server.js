require('dotenv').config();

// import libraries
const express = require('express');
const debug = require('debug')('app:server');
const Joi = require('joi');

// create express app
const app = express();
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

// routes
app.post('/login', (req, res, next) => {
  const schema = Joi.object({
    username: Joi.string().alphanum().min(4).max(20).required(),
    password: Joi.string().min(8).required(),
  });
  const data = req.body;
  const val = schema.validate(data);

  // debugging...
  debug(data);
  debug(val);
  res.send(val);
});
app.post('/login2', (req, res, next) => {
  const schema = Joi.object({
    username: Joi.string().alphanum().min(4).max(20).required(),
    password: Joi.string().min(8).required(),
  });
  const data = req.body;
  const val = schema.validate(data);
  if (val.error) {
    debug(val.error.details.map((x) => x.message).join('\n'));
    res.json(val);
  } else {
    if (data.username == 'admin' && data.password == 'password') {
      debug('Welcome admin!');
      res.json({ msg: 'Welcome admin!' });
    } else {
      debug('Bad username or password!');
      res.json({ msg: 'Bad username or password!' });
    }
  }
});
app.post('/login3', async (req, res, next) => {
  try {
    const schema = Joi.object({
      username: Joi.string().alphanum().min(4).max(20).required(),
      password: Joi.string().min(8).required(),
    });
    const data = req.body;
    await schema.validateAsync(data);
    if (data.username == 'admin' && data.password == 'password') {
      debug('Welcome admin!');
      res.json({ msg: 'Welcome admin!' });
    } else {
      debug('Bad username or password!');
      res.json({ msg: 'Bad username or password!' });
    }
  } catch (err) {
    debug(err);
    res.json({ error: err });
  }
});
app.post('/login4', async (req, res, next) => {
  try {
    const schema = Joi.object({
      username: Joi.string().alphanum().min(4).max(20).required().trim(),
      password: Joi.string().min(8).required().trim(),
    });
    let data = req.body;
    data = await schema.validateAsync(data);
    if (data.username == 'admin' && data.password == 'password') {
      debug('Welcome admin!');
      res.json({ msg: 'Welcome admin!' });
    } else {
      debug('Bad username or password!');
      res.json({ msg: 'Bad username or password!' });
    }
  } catch (err) {
    debug(err);
    res.json({ error: err });
  }
});
app.post('/register', async (req, res, next) => {
  try {
    const schema = Joi.object({
      username: Joi.string().required().trim().alphanum().min(4).max(20),
      new_password: Joi.string().required().trim().min(8),
      confirm_password: Joi.string()
        .required()
        .trim()
        .valid(Joi.ref('new_password')),
      email: Joi.string().required().email().lowercase().trim(),
      given_name: Joi.string().min(2).trim(),
      family_name: Joi.string().min(2).trim(),
    });
    let data = req.body;
    data = await schema.validateAsync(data);
    debug('Account Registered!');
    res.json({ msg: 'Account Registered!', data });
  } catch (err) {
    debug(err);
    res.json({ error: err });
  }
});

// bind the server to an http port
const hostname = process.env.HOSTNAME || 'localhost';
const port = process.env.PORT || 3000;
app.listen(port, () => {
  debug(`Server running at http://${hostname}:${port}/`);
});
