$(() => {
  $('#contact-form').submit((evt) => {
    evt.preventDefault();

    const formData = $('#contact-form').serialize();
    $.ajax({
      method: 'POST',
      url: '/contact',
      dataType: 'json',
      data: formData,
      headers: {
        accept: 'application/json',
      },
    })
      .done((res) => {
        $('#name + .text-danger').html(res.nameError || '');
        $('#message + .text-danger').html(res.messageError || '');
        if (res.isValid) {
          $('#contact-form output')
            .removeClass('text-danger')
            .addClass('text-success')
            .html(res.result || 'success');
        } else {
          $('#contact-form output')
            .removeClass('text-success')
            .addClass('text-danger')
            .html(res.result || 'error');
        }
      })
      .fail((xhr, textStatus, errorThrown) => {
        $('#name + .text-danger').html('');
        $('#message + .text-danger').html('');
        $('#contact-form output')
          .removeClass('text-success')
          .addClass('text-danger')
          .html(errorThrown ? errorThrown.toString() : textStatus);
      });
  });
});
