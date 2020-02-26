import mapboxgl from 'mapbox-gl';
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions';
// var MapboxDirections = require('@mapbox/mapbox-gl-directions');

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup) // add this
        .addTo(map);
    });

    fitMapToMarkers(map, markers);
  }
};



/////////////////////////////////////////////////
/////////////////// 2ème map ///////////////////
////////////////////////////////////////////////




const initMapbox2 = () => {
  const mapElement = document.getElementById('map-iti');
  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    ///map
    const map = new mapboxgl.Map({
      container: 'map-iti',
      style: 'mapbox://styles/mapbox/streets-v10',
      zoom: 9
    });

    //markers
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        // .addTo(map);
    });

    //MapboxDirection
    const directions = new MapboxDirections({
        accessToken: mapboxgl.accessToken,
        unit: 'metric',
        profile: 'mapbox/walking',
        interactive: false,
        controls: {
          inputs: false,
          instructions: false,
          profileSwitcher: false
        }
      });

    map.on('load', function () {

      //Création itinéraire
      const itineraire = () => {

        navigator.geolocation.getCurrentPosition((data) => {

          const lat = data.coords.latitude;
          const long = data.coords.longitude;
          const latDest = markers[0].lat ;
          const longDest = markers[0].lng ;

          // const createMarker = new mapboxgl.Marker()
          //   .setLngLat([long, lat])
          //   .addTo(map);

          directions.setOrigin([long, lat]);
          directions.setDestination([longDest, latDest]);
          let bound = new mapboxgl.LngLatBounds();
          bound.extend([long, lat]);
          bound.extend([longDest, latDest]);
          map.fitBounds(bound, {padding: 70, maxZoom: 15, duration: 100});
        });
      };
      itineraire();

    });
    // fitMapToMarkers(map, markers);

    map.addControl(directions, 'bottom-left');
  }



};

export { initMapbox, initMapbox2 };
