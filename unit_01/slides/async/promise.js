const wait = (delay) => new Promise((resolve, reject) => setTimeout(() => resolve(), delay));

const getTodo = () =>
  wait(2000).then(() => 'Complete Code Example');

getTodo()
  .then((todo) => console.log(todo))
  .catch((err) => console.error(err));
