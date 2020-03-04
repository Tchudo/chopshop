import mapboxgl from 'mapbox-gl';
import * as turf from '@turf/turf';
import helpers from '@turf/helpers';
import buffer from '@turf/buffer';
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const fitMapToMarkers = (map, markers) => {
    console.log(markers);
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
      const element = document.createElement('div');
        element.className = 'marker';
        element.style.backgroundImage = `url('${marker.image_url}')`;
        element.style.backgroundSize = 'contain';
        element.style.backgroundPosition = 'center center';
        element.style.width = '50px';
        element.style.height = '50px';
      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup) // add this
        .addTo(map);
    });

    fitMapToMarkers(map, markers);


    map.addControl(
      new mapboxgl.GeolocateControl({
      positionOptions: {
          enableHighAccuracy: true
        },
      trackUserLocation: true
      }), 'bottom-right'
    );

    const geocoder = new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl,
      marker: false,
      language: 'fr',
      placeholder: "Entrer votre adresse"
    });

    map.addControl(geocoder);


    map.on('load', function() {
      map.addSource('single-point', {
        type: 'geojson',
        data: {
          type: 'FeatureCollection',
          features: []
        }
      });

      map.addLayer({
        id: 'point',
        source: 'single-point',
        type: 'circle',
        paint: {
          'circle-radius': 10,
          'circle-color': '#448ee4'
        }
      });

      // Listen for the `result` event from the Geocoder
      // `result` event is triggered when a user makes a selection
      // Add a marker at the result's coordinates
      geocoder.on('result', function(ev) {
        map.getSource('single-point').setData(ev.result.geometry);
      });
    });

    document.getElementById('geocoder').appendChild(geocoder.onAdd(map));

  };
};



/////////////////////////////////////////////////
/////////////////// 2ème map ///////////////////
////////////////////////////////////////////////



const initMapbox2 = () => {

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
  const mapElement = document.getElementById('map-iti');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    ///map
    const map = new mapboxgl.Map({
      container: 'map-iti',
      style: 'mapbox://styles/mapbox/streets-v10',
      center: [-0.5654924, 44.8592094],
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
        language: 'fr',
        interactive: false,
        steps: true,
        styles: style,
          controls: {
          inputs: false,
          instructions: false,
          profileSwitcher: false
        }
      });

    const geocoder = new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl,
      marker: false,
      language: 'fr',
      placeholder: "Entrer votre adresse"
    });

    map.addControl(geocoder);


    map.on('load', function() {
      map.addSource('single-point', {
        type: 'geojson',
        data: {
          type: 'FeatureCollection',
          features: []
        }
      });

      map.addLayer({
        id: 'point',
        source: 'single-point',
        type: 'circle',
        paint: {
          'circle-radius': 10,
          'circle-color': '#448ee4'
        }
      });

      geocoder.on('result', function(ev) {
        map.getSource('single-point').setData(ev.result.geometry);
        const newCoord = ev.result.geometry.coordinates;
        itineraire(newCoord[1],newCoord[0]);
      });
    });

    document.getElementById('geocoder-2').appendChild(geocoder.onAdd(map));

    //Création itinéraire
      const itineraire = (lt, lg) => {

          let lat = lt;
          let long = lg;
          // let lat = 44.8592094;
          // let long = -0.5654924;

          const latDest = markers[0].lat ;
          const longDest = markers[0].lng ;

          directions.setOrigin([long, lat]);
          directions.setDestination([longDest, latDest]);
          let bound = new mapboxgl.LngLatBounds();
          bound.extend([long, lat]);
          bound.extend([longDest, latDest]);
          map.fitBounds(bound, { padding: 90, maxZoom: 15, duration: 500 });
      };

    map.on('load', function () {

      itineraire(44.859221, -0.5657);

    });
    // fitMapToMarkers(map, markers);

    map.addControl(directions, 'bottom-left');

    directions.on("route", e => {
      // routes is an array of route objects as documented here:
      // https://docs.mapbox.com/api/navigation/#route-object
      let routes = e.route

        const metric = (m) => {
          if (m >= 100000) return (m / 1000).toFixed(0) + 'km';
          if (m >= 10000) return (m / 1000).toFixed(1) + 'km';
          if (m >= 100) return (m / 1000).toFixed(2) + 'km';
          return m.toFixed(0) + 'm';
        };

        const duration = (s) => {
          var m = Math.floor(s / 60),
            h = Math.floor(m / 60);
          s %= 60;
          m %= 60;
          if (h === 0 && m === 0) return s + 's';
          if (h === 0) return m + 'min';
          return h + 'h ' + m + 'min';
        };


      // Each route object has a distance property
      const dist = routes.map(r => metric(r.distance));
      const durationS = routes.map(r => duration(r.duration));

      const instructions = document.getElementById('instructions-iti');
      instructions.innerHTML = durationS + ' - ' + dist;

      const instructionsSteps = document.getElementById('instructions-steps');
      const stepsArray = routes.map(r => r.legs[0].steps);
      // const stepsArray = routes.map(r => r.legs[0].steps[0].maneuver.instruction);

      let tripInstructions = [];
      // for (let i = 0; i < stepsArray.length; i++) {
      //   tripInstructions.push('<br><li>' + stepsArray[i].maneuver.instruction) + '</li>';
      //   instructionsSteps.innerHTML = tripInstructions;
      // };

      stepsArray[0].forEach( element => {
        tripInstructions.push('<li>' + element.maneuver.instruction) + '</li>';
        instructionsSteps.innerHTML = tripInstructions;
      });

    });

  };

};



/////////////////
////////// Map itinary waypoints
///////////////////////


// const initMapbox3 = () => {

//   const mapElement = document.getElementById('map-iti-opti');

//   if (mapElement) {
//     mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

//     ///map
//     const map = new mapboxgl.Map({
//       container: 'map-iti-opti',
//       style: 'mapbox://styles/mapbox/streets-v10',
//       center: [-0.5654924, 44.8592094],
//       zoom: 9
//     });

//     //markers
//     const markers = JSON.parse(mapElement.dataset.markers);
//     markers.forEach((marker) => {
//       new mapboxgl.Marker()
//         .setLngLat([ marker.lng, marker.lat ])
//         .addTo(map);
//     });

//     //MapboxDirection
//     const directions = new MapboxDirections({
//         accessToken: mapboxgl.accessToken,
//         unit: 'metric',
//         profile: 'mapbox/walking',
//         language: 'fr',
//         interactive: false,
//         steps: true,
//         controls: {
//           inputs: false,
//           instructions: false,
//           profileSwitcher: false
//         }
//       });

//     map.on('load', function () {

//       //Création itinéraire
//       const itineraire = () => {

//         navigator.geolocation.getCurrentPosition((data) => {

//           // let lat = 44.8592094;
//           // let long = -0.5654924;

//           let lat = data.coords.latitude;
//           let long = data.coords.longitude;

//           const latDest = lat ;
//           const longDest = long ;


//           let i = 0;
//           markers.forEach((marker) => {
//             directions.addWaypoint(i + 1, [marker.lng, marker.lat]);
//            });

//           directions.setOrigin([long, lat]);
//           directions.setDestination([longDest, latDest]);
//           let bound = new mapboxgl.LngLatBounds();
//           bound.extend([long, lat]);
//           bound.extend([longDest, latDest]);
//           map.fitBounds(bound, { padding: 90, maxZoom: 15, duration: 500 });
//         });
//       };
//       itineraire();

//     });
//     map.addControl(directions, 'bottom-left');

//     directions.on("route", e => {
//       // routes is an array of route objects as documented here:
//       // https://docs.mapbox.com/api/navigation/#route-object
//       let routes = e.route

//         const metric = (m) => {
//           if (m >= 100000) return (m / 1000).toFixed(0) + 'km';
//           if (m >= 10000) return (m / 1000).toFixed(1) + 'km';
//           if (m >= 100) return (m / 1000).toFixed(2) + 'km';
//           return m.toFixed(0) + 'm';
//         };

//         const duration = (s) => {
//           var m = Math.floor(s / 60),
//             h = Math.floor(m / 60);
//           s %= 60;
//           m %= 60;
//           if (h === 0 && m === 0) return s + 's';
//           if (h === 0) return m + 'min';
//           return h + 'h ' + m + 'min';
//         };


//       // Each route object has a distance property
//       const dist = routes.map(r => metric(r.distance));
//       const durationS = routes.map(r => duration(r.duration));

//       const instructions = document.getElementById('instructions-iti');
//       instructions.innerHTML = durationS + ' - ' + dist;

//       const instructionsSteps = document.getElementById('instructions-steps');
//       const stepsArray = routes.map(r => r.legs[0].steps);
//       // const stepsArray = routes.map(r => r.legs[0].steps[0].maneuver.instruction);

//       let tripInstructions = [];
//       // for (let i = 0; i < stepsArray.length; i++) {
//       //   tripInstructions.push('<br><li>' + stepsArray[i].maneuver.instruction) + '</li>';
//       //   instructionsSteps.innerHTML = tripInstructions;
//       // };

//       stepsArray[0].forEach( element => {
//         tripInstructions.push('<li>' + element.maneuver.instruction) + '</li>';
//         instructionsSteps.innerHTML = tripInstructions;
//       });

//     });

//     // const geocoder = new MapboxGeocoder({
//     //   accessToken: mapboxgl.accessToken,
//     //   mapboxgl: mapboxgl,
//     //   marker: false,
//     //   language: 'fr',
//     //   placeholder: "Entrer votre adresse"
//     // });

//     // map.addControl(geocoder);


//     // map.on('load', function() {
//     //   map.addSource('single-point', {
//     //     type: 'geojson',
//     //     data: {
//     //       type: 'FeatureCollection',
//     //       features: []
//     //     }
//     //   });

//     //   map.addLayer({
//     //     id: 'point',
//     //     source: 'single-point',
//     //     type: 'circle',
//     //     paint: {
//     //       'circle-radius': 10,
//     //       'circle-color': '#448ee4'
//     //     }
//     //   });

//     //   geocoder.on('result', function(ev) {
//     //     map.getSource('single-point').setData(ev.result.geometry);
//     //     console.log(ev.result.geometry.coordinates);
//     //   });
//     // });

//     // document.getElementById('geocoder-2').appendChild(geocoder.onAdd(map));
//   };

// };


/////////////////
////////// TEST
///////////////////////

const initMapbox3 = () => {

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 100, maxZoom: 15, duration: 0 });
  };
      let truckLocation = [-0.5654924, 44.8592094];
      var warehouseLocation = [-0.5654924, 44.8592094];
      var lastQueryTime = 0;
      var lastAtRestaurant = 0;
      var keepTrack = [];
      var currentSchedule = [];
      var currentRoute = null;
      var pointHopper = {};
      var pause = true;
      var speedFactor = 50;



      const mapElement = document.getElementById('map-iti-opti');

   if (mapElement) {
     mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
     const markers = JSON.parse(mapElement.dataset.markers);


      // Initialize a map
      const map = new mapboxgl.Map({
       container: 'map-iti-opti',
       style: 'mapbox://styles/mapbox/streets-v10',
       center: [-0.5654924, 44.8592094],
       zoom: 9
     });

      var warehouse = turf.featureCollection([turf.point(warehouseLocation)]);

      // Create an empty GeoJSON feature collection for drop off locations
      var dropoffs = turf.featureCollection([]);

      // Create an empty GeoJSON feature collection, which will be used as the data source for the route before users add any new data
      var nothing = turf.featureCollection([]);

      map.on('load', function() {
        var marker = document.createElement('div');
        marker.classList = 'truck';

        // Create a new marker
        const truckMarker = new mapboxgl.Marker(marker)
          .setLngLat(truckLocation)
          .addTo(map);

        // Create a new marker
        markers.forEach((marker) => {
          const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
          const element = document.createElement('div');
            element.className = 'marker';
            element.style.backgroundImage = `url('${marker.image_url}')`;
            element.style.backgroundSize = 'contain';
            element.style.backgroundPosition = 'center top';
            element.style.width = '50px';
            element.style.height = '50px';
          new mapboxgl.Marker(element)
            .setLngLat([ marker.lng, marker.lat ])
            .setPopup(popup)
            .addTo(map);
        });

        // Create a circle layer
        map.addLayer({
          id: 'warehouse',
          type: 'circle',
          source: {
            data: warehouse,
            type: 'geojson'
          },
          paint: {
            'circle-radius': 5,
            'circle-color': 'white',
            'circle-stroke-color': '#F4AA5B',
            'circle-stroke-width': 3
          }
        });

        // Create a symbol layer on top of circle layer
        map.addLayer({
          id: 'warehouse-symbol',
          type: 'symbol',
          source: {
            data: warehouse,
            type: 'geojson'
          },
          layout: {
            'icon-image': '',
            'icon-size': 1
          },
          paint: {
            'text-color': '#3887be'
          }
        });

        map.addLayer({
          id: 'dropoffs-symbol',
          type: 'symbol',
          source: {
            data: dropoffs,
            type: 'geojson'
          },
          layout: {
            'icon-allow-overlap': true,
            'icon-ignore-placement': true,
            'icon-image': ''
          }
        });

        map.addSource('route', {
          type: 'geojson',
          data: nothing
        });

        map.addLayer(
          {
            id: 'routeline-active',
            type: 'line',
            source: 'route',
            layout: {
              'line-join': 'round',
              'line-cap': 'round'
            },
            paint: {
              'line-color': '#3887be',
              'line-width': ['interpolate', ['linear'], ['zoom'], 12, 3, 22, 12]
            }
          },
          'waterway-label'
        );

         // Listen for a click on the map
        // map.on('load', function() {
          // When the map is clicked, add a new drop off point
          // and update the `dropoffs-symbol` layer

          markers.forEach((marker) => {
            newDropoff(marker);
            updateDropoffs(dropoffs);
            fitMapToMarkers(map, markers);
          });
        // });

        // Listen for a click on the map
        // map.on('click', function(e) {
        //   // When the map is clicked, add a new drop off point
        //   // and update the `dropoffs-symbol` layer
        //   newDropoff(map.unproject(e.point));
        //   console.log(map.unproject(e.point));
        //   updateDropoffs(dropoffs);
        // });


      });

      function newDropoff(coords) {
        // Store the clicked point as a new GeoJSON feature with
        // two properties: `orderTime` and `key`
        var pt = turf.point([coords.lng, coords.lat], {
          orderTime: Date.now(),
          key: Math.random()
        });
        dropoffs.features.push(pt);
        pointHopper[pt.properties.key] = pt;

        // Make a request to the Optimization API
        $.ajax({
          method: 'GET',
          url: assembleQueryURL()
        }).done(function(data) {
          // Create a GeoJSON feature collection
          var routeGeoJSON = turf.featureCollection([
            turf.feature(data.trips[0].geometry)
          ]);

          // If there is no route provided, reset
          if (!data.trips[0]) {
            routeGeoJSON = nothing;
          } else {
            // Update the `route` source by getting the route source
            // and setting the data equal to routeGeoJSON
            map.getSource('route').setData(routeGeoJSON);
          }

          //
          if (data.waypoints.length === 12) {
            window.alert(
              'Maximum number of points reached. '
            );
          }
        });
      }

      function updateDropoffs(geojson) {
        map.getSource('dropoffs-symbol').setData(geojson);
      }

      // Here you'll specify all the parameters necessary for requesting a response from the Optimization API
      function assembleQueryURL() {
        // Store the location of the truck in a variable called coordinates
        var coordinates = [truckLocation];
        var distributions = [];
        keepTrack = [truckLocation];

        // Create an array of GeoJSON feature collections for each point
        var restJobs = objectToArray(pointHopper);

        // If there are actually orders from this restaurant
        if (restJobs.length > 0) {
          // Check to see if the request was made after visiting the restaurant
          var needToPickUp =
            restJobs.filter(function(d, i) {
              return d.properties.orderTime > lastAtRestaurant;
            }).length > 0;

          // If the request was made after picking up from the restaurant,
          // Add the restaurant as an additional stop
          if (needToPickUp) {
            var restaurantIndex = coordinates.length;
            // Add the restaurant as a coordinate
            coordinates.push(warehouseLocation);
            // push the restaurant itself into the array
            keepTrack.push(pointHopper.warehouse);
          }

          restJobs.forEach(function(d, i) {
            // Add dropoff to list
            keepTrack.push(d);
            coordinates.push(d.geometry.coordinates);
            // if order not yet picked up, add a reroute
            if (needToPickUp && d.properties.orderTime > lastAtRestaurant) {
              distributions.push(
                restaurantIndex + ',' + (coordinates.length - 1)
              );
            }
          });
        }

        // Set the profile to `driving`
        // Coordinates will include the current location of the truck,
        return (
          'https://api.mapbox.com/optimized-trips/v1/mapbox/walking/' +
          coordinates.join(';') +
          '?distributions=' +
          distributions.join(';') +
          '&overview=full&steps=true&geometries=geojson&source=first&access_token=' +
          mapboxgl.accessToken
        );
      }

      function objectToArray(obj) {
        var keys = Object.keys(obj);
        var routeGeoJSON = keys.map(function(key) {
          return obj[key];
        });
        return routeGeoJSON;
      }
  };
};
export { initMapbox, initMapbox2, initMapbox3 };
