// Check if Stripe was initialized correctly
if (!stripe) {
  console.error("Stripe failed to initialize.");
} else {
  console.log("Stripe initialized successfully.");
}

// Create an instance of Elements
const elements = stripe.elements();

// Create a card element and mount it to the DOM
const card = elements.create("card", { hidePostalCode: true });
card.mount("#card-element");

// Handle real-time validation errors from the card element
card.addEventListener("change", (event) => {
  const displayError = document.getElementById("card-errors");
  if (event.error) {
    displayError.textContent = event.error.message;
  } else {
    displayError.textContent = "";
  }
});

// Handle form submission
const form = document.querySelector("form");
form.addEventListener("submit", (event) => {
  event.preventDefault();

  stripe.createToken(card).then((result) => {
    if (result.error) {
      const errorElement = document.getElementById("card-errors");
      errorElement.textContent = result.error.message;
    } else {
      stripeTokenHandler(result.token);
    }
  });
});

// Function to handle the Stripe token and submit the form
function stripeTokenHandler(token) {
  const hiddenInput = document.createElement("input");
  hiddenInput.setAttribute("type", "hidden");
  hiddenInput.setAttribute("name", "stripeToken");
  hiddenInput.setAttribute("value", token.id);

  form.appendChild(hiddenInput);
  form.submit();
}
