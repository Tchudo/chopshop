import Rails from 'rails-ujs'
// import Turbolinks from 'turbolinks'
import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions.css'
import Quagga from 'quagga';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import { changeTime } from '../plugins/animation';
import { autoSubmit } from '../plugins/auto_submit';
import { load_quagga } from '../plugins/barcode_reader'
import {eventDisplay} from '../components/eventcard';
import { initMapbox, initMapbox2, initMapbox3 } from '../plugins/init_mapbox';

//config

Rails.start();
// Turbolinks.start()


// animation clin oeil
changeTime();

// event page
eventDisplay();

// recherche auto on keyup
autoSubmit();

// affichage de la carte
initMapbox();
initMapbox2();
initMapbox3();


// initialisation du barcode reader
// $(document).on('turbolinks:load', load_quagga);
load_quagga();



console.log("all JS read");

