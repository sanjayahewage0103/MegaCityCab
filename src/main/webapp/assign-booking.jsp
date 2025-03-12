<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.megacitycab.model.Driver" %>
<%@ page import="com.example.megacitycab.model.Vehicle" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Assign Booking - MegaCab</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4">Assign Booking</h2>
  <form method="post" action="assign-booking">
    <input type="hidden" name="bookingId" value="${bookingId}">
    <div class="row mb-3">
      <label class="col-sm-3 col-form-label">Booking ID:</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" value="${bookingId}" readonly>
      </div>
    </div>
    <div class="row mb-3">
      <label class="col-sm-3 col-form-label">Customer ID:</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" value="${customerId}" readonly>
      </div>
    </div>
    <div class="row mb-3">
      <label class="col-sm-3 col-form-label">Pickup Location:</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" value="${pickupLocation}" readonly>
      </div>
    </div>
    <div class="row mb-3">
      <label class="col-sm-3 col-form-label">Drop Location:</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" value="${dropLocation}" readonly>
      </div>
    </div>
    <div class="row mb-3">
      <label class="col-sm-3 col-form-label">Date & Time:</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" value="${date} ${time}" readonly>
      </div>
    </div>
    <div class="row mb-3">
      <label class="col-sm-3 col-form-label">Assign Driver:</label>
      <div class="col-sm-9">
        <select name="driverId" class="form-select" required>
          <option value="">Select Driver</option>
          <%
            List<Driver> availableDriversList = (List<Driver>) request.getAttribute("availableDriversList");
            if (availableDriversList != null) {
              for (Driver driver : availableDriversList) {
          %>
          <option value="<%= driver.getDriverId() %>"><%= driver.getFirstName() %> <%= driver.getLastName() %> (<%= driver.getLicenseNumber() %>)</option>
          <% } } %>
        </select>
      </div>
    </div>
    <div class="row mb-3">
      <label class="col-sm-3 col-form-label">Assign Vehicle:</label>
      <div class="col-sm-9">
        <select name="vehicleId" class="form-select" required>
          <option value="">Select Vehicle</option>
          <%
            List<Vehicle> availableVehiclesList = (List<Vehicle>) request.getAttribute("availableVehiclesList");
            if (availableVehiclesList != null) {
              for (Vehicle vehicle : availableVehiclesList) {
          %>
          <option value="<%= vehicle.getVehicleId() %>"><%= vehicle.getVehicleNumber() %> (<%= vehicle.getType() %>)</option>
          <% } } %>
        </select>
      </div>
    </div>
    <button type="submit" class="btn btn-primary">Assign</button>
  </form>
</div>
<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>