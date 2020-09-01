window.onload = (evt) => {
  const form = document.getElementById('ContactUsForm');
  form.onsubmit = (evt) => {
    //evt.preventDefault();

    const results = document.getElementById('results');
    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const subject = document.getElementById('subject').value;
    const message = document.getElementById('message').value;

    results.innerHTML = '';
    let isValid = true;

    if (!name) {
      isValid = false;
      results.innerHTML += '<div>Name is invalid</div>';
    }

    if (!email) {
      isValid = false;
      results.innerHTML += '<div>Email is invalid</div>';
    }

    if (!isValid) {
      evt.preventDefault();
    }
  };
};

/*
//const $ = 3;
//window.$ = $;
//$ = null;
//$.click = null;
//$('#ContactUsForm').submit((evt) => {});
//const print = (msg) => console.log(msg);

const numbers = [7, 50, 28, 1000000, 10, 19];
//numbers[10] = 15;
//numbers[-2] = 3;

for (let i = 0; i < numbers.length; ++i) {
  console.log(numbers[i]);
}

for (const num of numbers) {
  console.log(num);
}

// for (const i in numbers) {
//   console.log(numbers[i]);
// }
*/
