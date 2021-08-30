import places from 'places.js';

const initAutocomplete = () => {
  console.log("Hello from Autocomplete");
  const countryInput = document.querySelectorAll('#trip_flight_flight');
  const destinationInput = document.getElementsByClassName('flight-destination')
  if (countryInput) {
    countryInput.forEach((country) => {
      places({type: "country", container: country})
    })
    // places({ type: "country", container: countryInput });
  }
  // if (destinationInput) {
  //   places({ type: "country", container: destinationInput });
  // }

};

export { initAutocomplete };
