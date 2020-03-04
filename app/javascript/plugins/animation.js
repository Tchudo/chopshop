const change = () => {
    document.getElementById('lily').classList.toggle("lilyb");
  };


const changeTime = () => {

  console.log("start changeTime");
  const logo = document.getElementById('lily');

  if (logo) {

    setInterval(
    () => {
      change();
    },
    3000
  );
  }
};

export { changeTime }


