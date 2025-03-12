
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.megacitycab.model.Booking" %>
<%@ page import="com.example.megacitycab.model.Driver" %>
<%@ page import="com.example.megacitycab.model.Vehicle" %>

<%
  // Redirect if admin is not logged in
  if (session == null || session.getAttribute("admin") == null) {
    response.sendRedirect("admin-login.jsp?error=You must log in to access the admin dashboard.");
    return;
  }

  // Retrieve data from request attributes
  int totalBookings = (int) request.getAttribute("totalBookings");
  int pendingBookings = (int) request.getAttribute("pendingBookings");
  int confirmedBookings = (int) request.getAttribute("confirmedBookings");
  int cancelledBookings = (int) request.getAttribute("cancelledBookings");
  List<Booking> pendingBookingsList = (List<Booking>) request.getAttribute("pendingBookingsList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Bookings - MegaCab</title>
  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome Icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary: #FF4500;
      --dark-bg: #f8f9fa;
      --dark-card: #ffffff;
      --dark-text: #333333;
    }
    body {
      font-family: 'Inter', sans-serif;
      background-color: var(--dark-bg);
      color: var(--dark-text);
    }
    .card {
      background-color: var(--dark-card);
      border: 1px solid #ddd;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .table th, .table td {
      vertical-align: middle;
    }
    .btn-action {
      margin-right: 5px;
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <div class="row">

    <!-- Main Content -->
    <div class="col-md-10 p-4">
      <h2 class="mb-4">Manage Bookings</h2>

      <!-- Cards -->
      <div class="row mb-4">
        <div class="col-md-3">
          <div class="card">
            <div class="card-body text-center">
              <i class="fas fa-book fa-2x text-primary"></i>
              <h5 class="card-title">Total Bookings</h5>
              <p class="card-text"><%= totalBookings %></p>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card">
            <div class="card-body text-center">
              <i class="fas fa-clock fa-2x text-warning"></i>
              <h5 class="card-title">Pending Bookings</h5>
              <p class="card-text"><%= pendingBookings %></p>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card">
            <div class="card-body text-center">
              <i class="fas fa-check-circle fa-2x text-success"></i>
              <h5 class="card-title">Confirmed Bookings</h5>
              <p class="card-text"><%= confirmedBookings %></p>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card">
            <div class="card-body text-center">
              <i class="fas fa-times-circle fa-2x text-danger"></i>
              <h5 class="card-title">Cancelled Bookings</h5>
              <p class="card-text"><%= cancelledBookings %></p>
            </div>
          </div>
        </div>
      </div>

      <!-- Search Bar -->
      <form method="get" action="manage-bookings" class="mb-4">
        <div class="input-group">
          <input type="text" name="search" class="form-control" placeholder="Search bookings...">
          <button type="submit" class="btn btn-primary">Search</button>
        </div>
      </form>

      <!-- Tabs -->
      <ul class="nav nav-tabs mb-4">
        <li class="nav-item">
          <a href="#pending" class="nav-link active" data-bs-toggle="tab">Pending Bookings</a>
        </li>
        <li class="nav-item">
          <a href="#confirmed" class="nav-link" data-bs-toggle="tab">Confirmed Bookings</a>
        </li>
        <li class="nav-item">
          <a href="#cancelled" class="nav-link" data-bs-toggle="tab">Cancelled Bookings</a>
        </li>
        <li class="nav-item">
          <a href="#completed" class="nav-link" data-bs-toggle="tab">Completed Bookings</a>
        </li>
      </ul>

      <!-- Tab Content -->
      <div class="tab-content">
        <!-- Pending Bookings -->
        <div class="tab-pane fade show active" id="pending">
          <table class="table table-bordered">
            <thead>
            <tr>
              <th>Booking ID</th>
              <th>Customer ID</th>
              <th>Vehicle Type</th>
              <th>Pickup Location</th>
              <th>Drop Location</th>
              <th>Date</th>
              <th>Time</th>
              <th>Final Amount</th>
              <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <% if (pendingBookingsList != null && !pendingBookingsList.isEmpty()) { %>
            <% for (Booking booking : pendingBookingsList) { %>
            <tr>
              <td><%= booking.getBookingId() %></td>
              <td><%= booking.getCustomerId() %></td>
              <td><%= booking.getVehicleType() %></td>
              <td><%= booking.getPickupLocation() %></td>
              <td><%= booking.getDropLocation() %></td>
              <td><%= booking.getDate() %></td>
              <td><%= booking.getTime() %></td>
              <td><%= booking.getFinalAmount() %></td>
              <td>
                <a href="assign-booking?bookingId=<%= booking.getBookingId() %>" class="btn btn-sm btn-primary btn-action">Assign</a>
                <a href="${pageContext.request.contextPath}/admin/cancel-booking?bookingId=<%= booking.getBookingId() %>"
                   class="btn btn-sm btn-danger btn-action">Cancel</a>
              </td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
              <td colspan="9" class="text-center">No pending bookings found.</td>
            </tr>
            <% } %>
            </tbody>
          </table>
        </div>

        <!-- Confirmed Bookings -->
        <div class="tab-pane fade" id="confirmed">
          <!-- Confirmed Bookings Table -->
          <div class="row mt-5">
            <div class="col-md-12">
              <h4 class="mb-3">Confirmed Bookings</h4>
              <table class="table table-bordered">
                <thead>
                <tr>
                  <th>Booking ID</th>
                  <th>Customer ID</th>
                  <th>Vehicle Type</th>
                  <th>Pickup Location</th>
                  <th>Drop Location</th>
                  <th>Date</th>
                  <th>Time</th>
                  <th>Final Amount</th>
                  <th>Payment Method</th>
                  <th>Payment Status</th>
                  <th>Vehicle Number</th>
                  <th>Driver Name</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                  List<Booking> confirmedBookingsList = (List<Booking>) request.getAttribute("confirmedBookingsList");
                  if (confirmedBookingsList != null && !confirmedBookingsList.isEmpty()) {
                    for (Booking booking : confirmedBookingsList) {
                %>
                <tr>
                  <td><%= booking.getBookingId() %></td>
                  <td><%= booking.getCustomerId() %></td>
                  <td><%= booking.getVehicleType() %></td>
                  <td><%= booking.getPickupLocation() %></td>
                  <td><%= booking.getDropLocation() %></td>
                  <td><%= booking.getDate() %></td> <!-- Separate Date Column -->
                  <td><%= booking.getTime() %></td> <!-- Separate Time Column -->
                  <td><%= booking.getFinalAmount() %></td>
                  <td><%= booking.getPaymentMethod() %></td>
                  <td><%= booking.getPaymentStatus() %></td>
                  <td><%= booking.getVehicleNumber() %></td>
                  <td><%= booking.getDriverName() %></td>
                  <td>
                    <form action="complete-booking" method="post" style="display:inline;">
                      <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                      <button type="submit" class="btn btn-success btn-sm">Complete</button>
                    </form>
                  </td>
                </tr>
                <%
                  }
                } else {
                %>
                <tr>
                  <td colspan="13" class="text-center">No confirmed bookings found.</td>
                </tr>
                <% } %>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- Cancelled Bookings -->
        <div class="tab-pane fade" id="cancelled">
          <!-- Cancelled Bookings Table -->
          <div class="row mt-5">
            <div class="col-md-12">
              <h4 class="mb-3">Cancelled Bookings</h4>
              <table class="table table-bordered">
                <thead>
                <tr>
                  <th>Booking ID</th>
                  <th>Customer ID</th>
                  <th>Vehicle Type</th>
                  <th>Pickup Location</th>
                  <th>Drop Location</th>
                  <th>Date</th>
                  <th>Time</th>
                  <th>Final Amount</th>
                  <th>Payment Method</th>
                  <th>Payment Status</th>
                  <th>Vehicle Number</th>
                  <th>Driver Name</th>
                </tr>
                </thead>
                <tbody>
                <%
                  List<Booking> cancelledBookingsList = (List<Booking>) request.getAttribute("cancelledBookingsList");
                  if (cancelledBookingsList != null && !cancelledBookingsList.isEmpty()) {
                    for (Booking booking : cancelledBookingsList) {
                %>
                <tr>
                  <td><%= booking.getBookingId() %></td>
                  <td><%= booking.getCustomerId() %></td>
                  <td><%= booking.getVehicleType() %></td>
                  <td><%= booking.getPickupLocation() %></td>
                  <td><%= booking.getDropLocation() %></td>
                  <td><%= booking.getDate() %></td>
                  <td><%= booking.getTime() %></td>
                  <td><%= booking.getFinalAmount() %></td>
                  <td><%= booking.getPaymentMethod() %></td>
                  <td><%= booking.getPaymentStatus() %></td>
                  <td><%= booking.getVehicleNumber() %></td>
                  <td><%= booking.getDriverName() %></td>
                </tr>
                <%
                  }
                } else {
                %>
                <tr>
                  <td colspan="12" class="text-center">No cancelled bookings found.</td>
                </tr>
                <% } %>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <!-- Cancelled Bookings -->
        <div class="tab-pane fade" id="completed">
          <!-- Completed Bookings Table -->
          <div class="row mt-5">
            <div class="col-md-12">
              <h4 class="mb-3">Completed Bookings</h4>
              <table class="table table-bordered">
                <thead>
                <tr>
                  <th>Booking ID</th>
                  <th>Customer ID</th>
                  <th>Vehicle ID</th>
                  <th>Driver ID</th>
                  <th>Payment ID</th>
                  <th>Payment Method</th>
                  <th>Date</th>
                  <th>Time</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                  List<Booking> completedBookingsList = (List<Booking>) request.getAttribute("completedBookingsList");
                  if (completedBookingsList != null && !completedBookingsList.isEmpty()) {
                    for (Booking booking : completedBookingsList) {
                %>
                <tr>
                  <td><%= booking.getBookingId() %></td>
                  <td><%= booking.getCustomerId() %></td>
                  <td><%= booking.getVehicleId() %></td>
                  <td><%= booking.getDriverId() %></td>
                  <td><%= booking.getPaymentId() %></td>
                  <td><%= booking.getPaymentMethod() %></td>
                  <td><%= booking.getDate() %></td>
                  <td><%= booking.getTime() %></td>
                  <td>
                    <form action="manage-bookings" method="post" style="display:inline;">
                      <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                      <button type="submit" class="btn btn-info btn-sm">View Activity</button>
                    </form>
                  </td>
                </tr>
                <%
                  }
                } else {
                %>
                <tr>
                  <td colspan="9" class="text-center">No completed bookings found.</td>
                </tr>
                <% } %>
                </tbody>
              </table>
            </div>
          </div>        </div>

      </div>
    </div>
  </div>
</div>
<!-- Available Drivers Table -->
<div class="row mt-5">
  <div class="col-md-12">
    <h4 class="mb-3">Available Drivers</h4>
    <table class="table table-bordered">
      <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Phone</th>
        <th>NIC</th>
        <th>License</th>
        <th>Status</th>
      </tr>
      </thead>
      <tbody>
      <%
        List<Driver> availableDriversList = (List<Driver>) request.getAttribute("availableDriversList");
        if (availableDriversList != null && !availableDriversList.isEmpty()) {
          for (Driver driver : availableDriversList) {
      %>
      <tr>
        <td><%= driver.getDriverId() %></td>
        <td><%= driver.getFirstName() + " " + driver.getLastName() %></td>
        <td><%= driver.getPhoneNumber() %></td>
        <td><%= driver.getNic() %></td>
        <td><%= driver.getLicenseNumber() %></td>
        <td><%= driver.getStatus() %></td>
      </tr>
      <%
        }
      } else {
      %>
      <tr>
        <td colspan="6" class="text-center">No available drivers found.</td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>
<!-- Available Vehicles Table -->
<div class="row mt-5">
  <div class="col-md-12">
    <h4 class="mb-3">Available Vehicles</h4>
    <!-- Filter Dropdown -->
    <form method="get" action="manage-bookings" class="mb-3">
      <div class="input-group">
        <select name="vehicleTypeFilter" class="form-select">
          <option value="">All Types</option>
          <option value="SUV" ${param.vehicleTypeFilter == 'SUV' ? 'selected' : ''}>SUV</option>
          <option value="Sedan" ${param.vehicleTypeFilter == 'Sedan' ? 'selected' : ''}>Sedan</option>
          <option value="Van" ${param.vehicleTypeFilter == 'Van' ? 'selected' : ''}>Van</option>
        </select>
        <button type="submit" class="btn btn-primary">Filter</button>
      </div>
    </form>
    <table class="table table-bordered">
      <thead>
      <tr>
        <th>ID</th>
        <th>Vehicle Number</th>
        <th>Color</th>
        <th>Register Number</th>
        <th>Model</th>
        <th>Type</th>
      </tr>
      </thead>
      <tbody>
      <%
        List<Vehicle> availableVehiclesList = (List<Vehicle>) request.getAttribute("availableVehiclesList");
        if (availableVehiclesList != null && !availableVehiclesList.isEmpty()) {
          for (Vehicle vehicle : availableVehiclesList) {
      %>
      <tr>
        <td><%= vehicle.getVehicleId() %></td>
        <td><%= vehicle.getVehicleNumber() %></td>
        <td><%= vehicle.getColor() %></td>
        <td><%= vehicle.getRegisterNumber() %></td>
        <td><%= vehicle.getModel() %></td>
        <td><%= vehicle.getType() %></td>
      </tr>
      <%
        }
      } else {
      %>
      <tr>
        <td colspan="6" class="text-center">No available vehicles found.</td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>
<!-- Modal -->
<div class="modal fade" id="activityModal" tabindex="-1" aria-labelledby="activityModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="activityModalLabel">Activity Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <%
          Booking activityDetails = (Booking) request.getAttribute("activityDetails");
          if (activityDetails != null) {
        %>
        <p><strong>Customer Name:</strong> <%= activityDetails.getCustomerName() %></p>
        <p><strong>Driver Name:</strong> <%= activityDetails.getDriverName() %></p>
        <p><strong>Vehicle Number:</strong> <%= activityDetails.getVehicleNumber() %></p>
        <p><strong>Vehicle Type:</strong> <%= activityDetails.getVehicleType() %></p>
        <p><strong>Pickup Location:</strong> <%= activityDetails.getPickupLocation() %></p>
        <p><strong>Drop Location:</strong> <%= activityDetails.getDropLocation() %></p>
        <p><strong>Date:</strong> <%= activityDetails.getDate() %></p>
        <p><strong>Time:</strong> <%= activityDetails.getTime() %></p>
        <p><strong>Payment Method:</strong> <%= activityDetails.getPaymentMethod() %></p>
        <p><strong>Total Distance:</strong> <%= activityDetails.getTotalDistance() %> km</p>
        <p><strong>Final Amount:</strong> $<%= activityDetails.getFinalAmount() %></p>
        <% } else { %>
        <p>No activity details found.</p>
        <% } %>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>