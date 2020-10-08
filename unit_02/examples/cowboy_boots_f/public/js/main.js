$(() => {
  // $('#add-product').click((evt) => {
  //   const name = prompt('what is the name?');
  //   const category = prompt('what is category?');
  //   const price = prompt('what is price?');

  //   $.ajax({
  //     method: 'POST',
  //     url: '/api/product',
  //     dataType: 'json',
  //     data: { name, category, price }
  //   }).done((res) => {
  //     //alert(res[0]);
  //     window.location = new URL(`/product/${res[0]}`, window.location);
  //   }).fail((xhr, textStatus, err) => {
  //     alert(`${textStatus}\n${err}`);
  //   });
  // });
  $('#add-product-form').on('submit', (evt) => {
    evt.preventDefault();

    // const name = $('#name').val();
    // const category = $('#category').val();
    // const price = $('#price').val();
    const formData = $('#add-product-form').serialize();
    console.log(formData);

    $.ajax({
      method: 'POST',
      url: '/api/product',
      dataType: 'json',
      data: formData,
    })
      .done((res) => {
        if (res.error) {
          $('#add-product-form output').html(res.error);
        } else {
          window.location = new URL(`/product/${res[0]}`, window.location);
        }
      })
      .fail((xhr, textStatus, err) => {
        $('#add-product-form output').html(`${textStatus}\n${err}`);
      });
  });
  $('#edit-product-form').on('submit', (evt) => {
    evt.preventDefault();

    const id = $('#id').val();
    const formData = $(evt.target).serialize();
    console.log(formData);

    $.ajax({
      method: 'PUT',
      url: `/api/product/${id}`,
      dataType: 'json',
      data: formData,
    })
      .done((res) => {
        if (res.error) {
          $('#edit-product-form output').html(res.error);
        } else {
          window.location = new URL(`/product/${id}`, window.location);
        }
      })
      .fail((xhr, textStatus, err) => {
        $('#edit-product-form output').html(`${textStatus}\n${err}`);
      });
  });
  $('.delete-product-from-list').on('click', (evt) => {
    const id = $(evt.target).data('id');
    const name = $(evt.target).data('name');
    const yes = confirm(`Are you sure that you want to delete "${name}"`);
    if (yes) {
      $.ajax({
        method: 'DELETE',
        url: `/api/product/${id}`,
        dataType: 'json',
      })
        .done((res) => {
          if (res.error) {
            alert(res.error);
          } else {
            window.location.reload();
          }
        })
        .fail((xhr, textStatus, err) => {
          alert(`${textStatus}\n${err}`);
        });
    }
  });
});
