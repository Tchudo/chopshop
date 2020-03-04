import Rails from 'rails-ujs'
// import Turbolinks from 'turbolinks'

import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions.css'
import Quagga from 'quagga';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import { changeTime } from '../plugins/animation';
import { autoSubmit } from '../plugins/auto_submit';
import { load_quagga } from '../plugins/barcode_reader';


import { initMapbox, initMapbox2, initMapbox3 } from '../plugins/init_mapbox';
// import { autoSubmit } from '../plugins/auto_submit';

//config

Rails.start();
// Turbolinks.start()


// import { changeTime } from '../shared/animation';
// changeTime();

// animation clin oeil
changeTime();

// recherche auto on keyup
autoSubmit();

// affichage de la carte
initMapbox();
initMapbox2();
initMapbox3();


// initialisation du barcode reader
// $(document).on('turbolinks:load', load_quagga);
load_quagga();

import {eventDisplay} from '../components/eventcard';
eventDisplay();

console.log("all JS read");

