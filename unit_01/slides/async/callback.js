const getTodo = (callback) => setTimeout(() => callback('Complete Code Example'), 2000);

getTodo((todo) => console.log(todo.text));
