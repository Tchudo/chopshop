const eventDisplay = () => {
  const cardContainer = document.querySelector('.card-event-container');
  const noti = document.querySelector('.notiti');

  const btnAction = document.querySelector('.fa-calendar-alt');


  const logo = document.querySelector('#lily');
  const miniLogo = document.querySelector('.lily-logo');
  const mainTitle = document.querySelector('#main-title');
  const searchbar = document.querySelector('.search-bar');


console.log("eventdisplay");
console.log(btnAction);
if (btnAction) {
  btnAction.addEventListener('click', (event) => {
    cardContainer.classList.toggle('display-card');
    logo.classList.toggle('opacity-destroy');
    miniLogo.classList.toggle('lily-go');
    mainTitle.classList.toggle('opacity-destroy');
    searchbar.classList.toggle('opacity-destroy');
    noti.classList.toggle('opacity-destroy');

  });

};


if (noti) {
  noti.addEventListener('click', (event) => {
    cardContainer.classList.toggle('display-card');
    logo.classList.toggle('opacity-destroy');
    miniLogo.classList.toggle('lily-go');
    mainTitle.classList.toggle('opacity-destroy');
    searchbar.classList.toggle('opacity-destroy');
    noti.classList.toggle('opacity-destroy');

  });


};



if (miniLogo) {
  miniLogo.addEventListener('click', (event) => {
    cardContainer.classList.toggle('display-card');
    logo.classList.toggle('opacity-destroy');
    miniLogo.classList.toggle('lily-go');
    mainTitle.classList.toggle('opacity-destroy');
    searchbar.classList.toggle('opacity-destroy');
    noti.classList.toggle('opacity-destroy');


  });
};

}

export {eventDisplay};
