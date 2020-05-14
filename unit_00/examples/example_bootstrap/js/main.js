// https://api.jquery.com/submit/
// https://developer.mozilla.org/en-US/docs/Web/API/FormData

$('#Contact-form').submit((e) => {
  e.preventDefault();
  const formData = new FormData(e.target);
  const email = formData.get('email');
  const subject = formData.get('subject');
  const message = formData.get('message');

  console.log('Message Received!');
  console.log(`\temail: ${email}`);
  console.log(`\tsubject: ${subject}`);
  console.log(`\tmessage: ${message}`);

  if (email && subject && message) {
    $(e.target).replaceWith('<h4>Message has been sent.</h4>');
  } else {
    $('#Contact-output').html('<h4 class="text-danger">Please complete all fields.</h4>');
  }
});
