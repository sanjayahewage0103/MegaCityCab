<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Book a Ride - MegaCab</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f8f9fa;
      padding: 20px;
    }
    .container {
      max-width: 600px;
      margin: auto;
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .error {
      color: red;
      font-size: 0.9em;
    }
    .success {
      color: green;
      font-size: 0.9em;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Book a Ride</h2>

  <%-- Display error or success messages --%>
  <% if (request.getAttribute("error") != null) { %>
  <div class="error"><%= request.getAttribute("error") %></div>
  <% } %>
  <% if (request.getAttribute("success") != null) { %>
  <div class="success"><%= request.getAttribute("success") %></div>
  <% } %>

  <form method="post" action="booking-servlet">
    <input type="hidden" name="action" value="book">

    <%-- Step 2: Customer selects vehicle type, locations, date, time, passengers, and promo code --%>
    <div class="mb-3">
      <label for="vehicleType" class="form-label">Vehicle Type</label>
      <select name="vehicleType" id="vehicleType" class="form-select" required>
        <option value="Sedan">Sedan</option>
        <option value="SUV">SUV</option>
        <option value="Van">Van</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="pickupLocation" class="form-label">Pickup Location</label>
      <select name="pickupLocation" id="pickupLocation" class="form-select" required>
        <option value="Colombo 1">Colombo 1</option>
        <option value="Colombo 2">Colombo 2</option>
        <option value="Colombo 3">Colombo 3</option>
        <option value="Colombo 4">Colombo 4</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="dropLocation" class="form-label">Drop-off Location</label>
      <select name="dropLocation" id="dropLocation" class="form-select" required>
        <option value="Colombo 1">Colombo 1</option>
        <option value="Colombo 2">Colombo 2</option>
        <option value="Colombo 3">Colombo 3</option>
        <option value="Colombo 4">Colombo 4</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="date" class="form-label">Date</label>
      <input type="date" name="date" id="date" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="time" class="form-label">Time</label>
      <input type="time" name="time" id="time" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="numPassengers" class="form-label">Number of Passengers</label>
      <input type="number" name="numPassengers" id="numPassengers" class="form-control" min="1" required>
    </div>

    <div class="mb-3">
      <label for="promoCode" class="form-label">Promo Code (Optional)</label>
      <input type="text" name="promoCode" id="promoCode" class="form-control">
    </div>

    <button type="submit" class="btn btn-primary w-100">Confirm Booking</button>
  </form>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>