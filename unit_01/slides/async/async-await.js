const wait = (delay) => new Promise((resolve, reject) => setTimeout(() => resolve(), delay));

const getTodo = async () => {
  await wait(2000);
  return 'Complete Code Example';
}

(async () => {
  try {
    const todo = await getTodo();
    console.log(todo);
  } catch (err) {
    console.error(err)
  } 
})();
