import places from 'places.js';

const initAutocomplete = () => {
  console.log("Hello from Autocomplete");
  const countryInput = document.querySelectorAll('.algolia_search');
  // const destinationInput = document.getElementsByClassName('flight-destination')
  if (countryInput) {
    countryInput.forEach((country) => {
      places({type: "country", container: country})
    })
  }
};

export { initAutocomplete };
