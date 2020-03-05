const mask = () => {

  const screenmask = document.getElementById('mask');

  if (screenmask) {
  const searchform = document.getElementById('myForm');

  searchform.addEventListener('focus', (event) => {
    screenmask.style.display = "block";
  });
  searchform.addEventListener('focusout', (event) => {
    screenmask.style.display = "none";
  });

}

};

export { mask }
