$(() => {
  $('#ContactUsForm').submit((evt) => {
    //evt.preventDefault();

    const results = $('#results');
    const name = $('#name').val();
    const email = $('#email').val();
    const subject = $('#subject').val();
    const message = $('#message').val();

    results.html('');
    let isValid = true;

    if (!name) {
      isValid = false;
      //results.innerHTML += '<div>Name is invalid</div>';
      //results.html(results.html() + '<div>Name is invalid</div>');
      results.append('<div>Name is invalid</div>');
    }

    if (!email) {
      isValid = false;
      results.append('<div>Email is invalid</div>');
    }

    if (!isValid) {
      evt.preventDefault();
    }
  });
  $('#ContactUsForm').on('reset', (evt) => {
    $('#results').html('');
  });
});
