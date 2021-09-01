import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const fitMapToMarkers = (map, locations) => {
    const bounds = new mapboxgl.LngLatBounds();
    locations.forEach(location => bounds.extend([ location.long, location.lat ]));
    map.fitBounds(bounds, { padding: 60, maxZoom: 4, duration: 0 });
  };



  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/fabrizio-onorio/ckt1kj48413kk17mcgi7a4zhp'
    });

    let locations = []

    const homeInput = document.getElementById('home_input');
    homeInput.addEventListener("change", (event) => {
      console.log(event.target.value)
      const country = event.target.value
      const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${country}.json?types=country&access_token=${mapElement.dataset.mapboxApiKey}`
      fetch(url)
        .then((response) => response.json())
        .then(data => {
          const long = data.features[0].geometry.coordinates[0]
          const lat = data.features[0].geometry.coordinates[1]
          locations.push({lat: lat, long: long})
          new mapboxgl.Marker()
            .setLngLat([ long, lat ])
            .addTo(map);
          fitMapToMarkers(map, locations);

        });
    });

    const destinationInput = document.getElementById('destination_input');
    destinationInput.addEventListener("change", (event) => {
      console.log(event.target.value)
      const country = event.target.value
      const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${country}.json?types=country&access_token=${mapElement.dataset.mapboxApiKey}`
      fetch(url)
        .then((response) => response.json())
        .then(data => {
          const long = data.features[0].geometry.coordinates[0]
          const lat = data.features[0].geometry.coordinates[1]
          locations.push({lat: lat, long: long})
          new mapboxgl.Marker()
            .setLngLat([ long, lat ])
            .addTo(map);
          fitMapToMarkers(map, locations);

        });
    });
  }
};

// object.addEventListener("change", countryInfoMark(country));
// console.log(`https://api.mapbox.com/geocoding/v5/mapbox.places/${country}.json?types=country&access_token=${ENV['MAPBOX_API_KEY']}`)

export { initMapbox };
