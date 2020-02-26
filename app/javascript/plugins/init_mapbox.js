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


const style = [{
  'id': 'directions-route-line-alt',
  'type': 'line',
  'source': 'directions',
  'layout': {
    'line-cap': 'round',
    'line-join': 'round'
  },
  'paint': {
    'line-color': '#F4AA5B',
    'line-width': 4
  },
  'filter': [
    'all',
    ['in', '$type', 'LineString'],
    ['in', 'route', 'alternate']
  ]
}, {
  'id': 'directions-route-line-casing',
  'type': 'line',
  'source': 'directions',
  'layout': {
    'line-cap': 'round',
    'line-join': 'round'
  },
  'paint': {
    'line-color': '#F4AA5B',
    'line-width': 1
  },
  'filter': [
    'all',
    ['in', '$type', 'LineString'],
    ['in', 'route', 'selected']
  ]
}, {
  'id': 'directions-route-line',
  'type': 'line',
  'source': 'directions',
  'layout': {
    'line-cap': 'butt',
    'line-join': 'round'
  },
  'paint': {
    'line-color': {
      'property': 'congestion',
      'type': 'categorical',
      'default': '#F4AA5B', //ligne centrale
      'stops': [
        ['unknown', '#4882c5'],
        ['low', '#4882c5'],
        ['moderate', '#f09a46'],
        ['heavy', '#e34341'],
        ['severe', '#8b2342']
      ]
    },
    'line-width': 5
  },
  'filter': [
    'all',
    ['in', '$type', 'LineString'],
    ['in', 'route', 'selected']
  ]
}, {
  'id': 'directions-hover-point-casing',
  'type': 'circle',
  'source': 'directions',
  'paint': {
    'circle-radius': 8,
    'circle-color': '#fff'
  },
  'filter': [
    'all',
    ['in', '$type', 'Point'],
    ['in', 'id', 'hover']
  ]
}, {
  'id': 'directions-hover-point',
  'type': 'circle',
  'source': 'directions',
  'paint': {
    'circle-radius': 6,
    'circle-color': '#F4AA5B'
  },
  'filter': [
    'all',
    ['in', '$type', 'Point'],
    ['in', 'id', 'hover']
  ]
}, {
  'id': 'directions-waypoint-point-casing',
  'type': 'circle',
  'source': 'directions',
  'paint': {
    'circle-radius': 8,
    'circle-color': '#fff'
  },
  'filter': [
    'all',
    ['in', '$type', 'Point'],
    ['in', 'id', 'waypoint']
  ]
}, {
  'id': 'directions-waypoint-point',
  'type': 'circle',
  'source': 'directions',
  'paint': {
    'circle-radius': 6,
    'circle-color': '#8a8bc9'
  },
  'filter': [
    'all',
    ['in', '$type', 'Point'],
    ['in', 'id', 'waypoint']
  ]
}, {
  'id': 'directions-origin-point',
  'type': 'circle',
  'source': 'directions',
  'paint': {
    'circle-radius': 18,
    'circle-color': '#FCCB8F' //Fond du A
  },
  'filter': [
    'all',
    ['in', '$type', 'Point'],
    ['in', 'marker-symbol', 'A']
  ]
}, {
  'id': 'directions-origin-label',
  'type': 'symbol',
  'source': 'directions',
  'layout': {
    'text-field': 'A',
    'text-font': ['Open Sans Bold', 'Arial Unicode MS Bold'],
    'text-size': 12
  },
  'paint': {
    'text-color': '#fff'
  },
  'filter': [
    'all',
    ['in', '$type', 'Point'],
    ['in', 'marker-symbol', 'A']
  ]
}, {
  'id': 'directions-destination-point',
  'type': 'circle',
  'source': 'directions',
  'paint': {
    'circle-radius': 18,
    'circle-color': '#A8D384' //Fond du B
  },
  'filter': [
    'all',
    ['in', '$type', 'Point'],
    ['in', 'marker-symbol', 'B']
  ]
}, {
  'id': 'directions-destination-label',
  'type': 'symbol',
  'source': 'directions',
  'layout': {
    'text-field': 'B',
    'text-font': ['Open Sans Bold', 'Arial Unicode MS Bold'],
    'text-size': 12
  },
  'paint': {
    'text-color': '#fff'
  },
  'filter': [
    'all',
    ['in', '$type', 'Point'],
    ['in', 'marker-symbol', 'B']
  ]
}];

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
        styles: style,
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
