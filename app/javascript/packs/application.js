import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions.css'
import { refresh} from '../plugins/search';
import { initMapbox, initMapbox2 } from '../plugins/init_mapbox';

refresh;
initMapbox();
initMapbox2();

