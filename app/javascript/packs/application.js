import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions.css'

import { initMapbox, initMapbox2 } from '../plugins/init_mapbox';

initMapbox();
initMapbox2();


import { changeTime } from '../shared/animation';
changeTime();

import {eventDisplay} from '../components/eventcard';
eventDisplay();
