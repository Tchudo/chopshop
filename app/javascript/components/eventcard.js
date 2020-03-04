const eventDisplay = () => {
  const cardContainer = document.querySelector('.card-event-container');
  const btnAction = document.querySelector('.fa-walking');
  const logo = document.querySelector('#lily');
  const miniLogo = document.querySelector('.lily-logo');
  const mainTitle = document.querySelector('#main-title');
  const searchbar = document.querySelector('.search-bar');
  const searchbar2 = document.querySelector('.search-new-place');


  btnAction.addEventListener('click', (event) => {
    cardContainer.classList.toggle('display-card');
    logo.classList.toggle('opacity-destroy');
    miniLogo.classList.toggle('lily-go');
    mainTitle.classList.toggle('opacity-destroy');
    searchbar.classList.toggle('opacity-destroy');
    searchbar2.classList.toggle('lily-go');
  });




  searchbar2.addEventListener('click', (event) => {
    cardContainer.classList.toggle('display-card');
    logo.classList.toggle('opacity-destroy');
    miniLogo.classList.toggle('lily-go');
    mainTitle.classList.toggle('opacity-destroy');
    searchbar.classList.toggle('opacity-destroy');
    searchbar2.classList.toggle('lily-go');


  });

  miniLogo.addEventListener('click', (event) => {
    cardContainer.classList.toggle('display-card');
    logo.classList.toggle('opacity-destroy');
    miniLogo.classList.toggle('lily-go');
    mainTitle.classList.toggle('opacity-destroy');
    searchbar.classList.toggle('opacity-destroy');
    searchbar2.classList.toggle('lily-go');

  });


}

export {eventDisplay};