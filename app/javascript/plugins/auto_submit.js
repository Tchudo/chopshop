import Rails from 'rails-ujs'
const autoSubmit = () => {
  console.log("start keyup");
    const searchForm = document.getElementById('search');
    const inputForm = document.getElementById('myForm');
    console.log(inputForm);
    if (inputForm) {
      inputForm.addEventListener("keyup", (event) => {
      // console.log(event.currentTarget.value);
      Rails.fire(searchForm, 'submit');
      });
    } else {
      console.log("pas de inputForm");
    };
  };

export { autoSubmit };

