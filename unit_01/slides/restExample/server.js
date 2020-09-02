const express = require('express');
const fs = require('fs');
const path = require('path');
const app = express();

const readUsers = (callback) => {
  fs.readFile(path.join(__dirname, 'users.json'), 'utf8', (err, data) => {
    if (!err) {
      data = JSON.parse(data);
    } else {
      data = null;
    }
    callback(err, data);
  });
};

app.get('/user', (req, res, next) => {
  readUsers((err, users) => {
    if (!err) {
      console.log(users);
      res.json(users);
    } else {
      next(err);
    }
  });
});

app.get('/user/:id', (req, res, next) => {
  readUsers((err, users) => {
    if (!err) {
      const id = req.params.id;
      const user = users['user' + id];
      console.log(user);
      res.json(user);
    } else {
      next(err);
    }
  });
});

app.post('/user', (req, res, next) => {
  readUsers((err, users) => {
    if (!err) {
      const user4 = {
        id: 4,
        name: 'mohit',
        password: 'password4',
        profession: 'teacher',
      };
      users['user4'] = user4;
      console.log(users);
      res.json(users);
    } else {
      next(err);
    }
  });
});

app.delete('/user/:id', (req, res, next) => {
  readUsers((err, users) => {
    if (!err) {
      const id = req.params.id;
      delete users['user' + id];
      console.log(users);
      res.json(users);
    } else {
      next(err);
    }
  });
});

const HOST = 'localhost';
const PORT = process.env.PORT || 8081;
app.listen(PORT, () => {
  console.log('Example app listening at http://%s:%s', HOST, PORT);
});
