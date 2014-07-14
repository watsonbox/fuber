/* Initialize the StripeCloud Module */
var Stripe = require('stripe');
Stripe.initialize('sk_test_3h9cLoZqiN5qEvcYNZcYmZtj'); // FIXME: Don't commit live secret key to repo

Parse.Cloud.define("stripePayment", function(request, response) {
  Stripe.Charges.create({
    amount: request.params.amount,
    currency: "EUR",
    card: request.params.token
  }).then(
    function(param) {
      console.log('Made successful card charge with Stripe!');
      response.success("Stripe charge succeeded.");
    },
    function(error) {
      console.log('Charging with stripe failed. Error: ' + error);
      response.error(error.message);
    }
  )
});
