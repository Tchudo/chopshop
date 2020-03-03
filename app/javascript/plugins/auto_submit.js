import Rails from 'rails-ujs'

const autoSubmit = () => {
  const searchForm = document.getElementById('search');
  const inputForm = document.getElementById('query');

  inputForm.addEventListener("keyup", (event) => {
    // console.log(event.currentTarget.value);
    Rails.fire(searchForm, 'submit');
  });

};
