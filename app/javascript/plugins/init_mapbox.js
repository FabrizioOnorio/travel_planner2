import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};
  const homeInput = document.getElementById('home_input');
    homeInput.addEventListener("change", (event) => {
      console.log(event.target.value)
      const country = event.target.value
      const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${country}.json?types=country&access_token=${mapElement.dataset.mapboxApiKey}`
      fetch(url)
        .then((response) => response.json())
        .then(data => console.log(data.features))
    });
  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/fabrizio-onorio/ckt19qqby0t1517mm9opkhul4'
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    // markers.forEach((marker) => {
    // new mapboxgl.Marker()
    //   .setLngLat([ marker.lng, marker.lat ])
    //   .addTo(map);
    // });
    // fitMapToMarkers(map, markers);
  }
};

// object.addEventListener("change", countryInfoMark(country));
// console.log(`https://api.mapbox.com/geocoding/v5/mapbox.places/${country}.json?types=country&access_token=${ENV['MAPBOX_API_KEY']}`)

export { initMapbox };
