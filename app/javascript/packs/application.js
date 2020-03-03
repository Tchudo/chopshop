import Rails from 'rails-ujs'
import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions.css'
import { initMapbox, initMapbox2 } from '../plugins/init_mapbox';
// import { autoSubmit } from '../plugins/auto_submit';

Rails.start();

initMapbox();
initMapbox2();
// autoSubmit();

const searchForm = document.getElementById('search');
const inputForm = document.getElementById('query');

inputForm.addEventListener("keyup", (event) => {
// console.log(event.currentTarget.value);
Rails.fire(searchForm, 'submit');
});


const toggle = (anId) => {
  node = document.getElementById(anId);
  if (node.style.visibility=="hidden")
  {
    // Contenu caché, le montrer
    node.style.visibility = "visible";
    node.style.height = "auto";     // Optionnel rétablir la hauteur
  }
  else
  {
    // Contenu visible, le cacher
    node.style.visibility = "hidden";
    node.style.height = "0";      // Optionnel libérer l'espace
  }
};
