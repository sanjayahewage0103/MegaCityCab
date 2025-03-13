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
      --secondary: #FF8C00;
      --dark-bg: #f8f9fa;
      --dark-card: #ffffff;
      --dark-text: #333333;
      --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      --border-radius: 10px;
    }

    body {
      font-family: 'Inter', sans-serif;
      background-color: var(--dark-bg);
      color: var(--dark-text);
    }

    .dashboard-container {
      display: grid;
      grid-template-columns: repeat(8, 1fr);
      grid-template-rows: auto;
      gap: 1rem;
      padding: 1.5rem;
      max-width: 1600px;
      margin: 0 auto;
    }

    .dashboard-title {
      grid-column: span 4;
      display: flex;
      align-items: center;
    }

    .dashboard-title h2 {
      margin: 0;
      font-weight: 600;
    }

    .booking-stats-card {
      background-color: var(--dark-card);
      border-radius: var(--border-radius);
      box-shadow: var(--card-shadow);
      padding: 1rem;
      text-align: center;
      transition: transform 0.3s ease;
    }

    .booking-stats-card:hover {
      transform: translateY(-5px);
    }

    .navigation-section {
      grid-column: span 8;
      background-color: var(--dark-card);
      border-radius: var(--border-radius);
      box-shadow: var(--card-shadow);
      padding: 1rem;
    }

    .search-bar {
      display: flex;
      margin-bottom: 1rem;
    }

    .search-bar input {
      flex-grow: 1;
      margin-right: 0.5rem;
      border-radius: 5px;
    }

    .booking-tabs {
      grid-column: span 8;
      grid-row: span 4;
      background-color: var(--dark-card);
      border-radius: var(--border-radius);
      box-shadow: var(--card-shadow);
      padding: 1rem;
      overflow: auto;
    }

    .drivers-section, .vehicles-section {
      grid-column: span 4;
      grid-row: span 3;
      background-color: var(--dark-card);
      border-radius: var(--border-radius);
      box-shadow: var(--card-shadow);
      padding: 1rem;
      overflow: auto;
    }

    .table-wrapper {
      overflow-x: auto;
    }

    .card {
      height: 100%;
      border: none;
      box-shadow: var(--card-shadow);
      transition: transform 0.3s ease;
    }

    .card:hover {
      transform: translateY(-5px);
    }

    .card-icon {
      margin-bottom: 0.5rem;
      font-size: 1.75rem;
    }

    .total-bookings .card-icon {
      color: #4e73df;
    }

    .pending-bookings .card-icon {
      color: #f6c23e;
    }

    .confirmed-bookings .card-icon {
      color: #1cc88a;
    }

    .cancelled-bookings .card-icon {
      color: #e74a3b;
    }

    .card-value {
      font-size: 1.5rem;
      font-weight: 700;
    }

    .nav-tabs .nav-link {
      color: var(--dark-text);
      border: none;
      border-bottom: 2px solid transparent;
      font-weight: 500;
    }

    .nav-tabs .nav-link.active {
      color: var(--primary);
      background-color: transparent;
      border-bottom: 2px solid var(--primary);
    }

    .btn-primary {
      background-color: var(--primary);
      border-color: var(--primary);
    }

    .btn-primary:hover {
      background-color: var(--secondary);
      border-color: var(--secondary);
    }

    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1rem;
    }

    .section-title {
      font-weight: 600;
      margin: 0;
    }

    table {
      width: 100%;
    }

    table th {
      background-color: #f1f1f1;
      position: sticky;
      top: 0;
      z-index: 1;
    }

    .table-responsive {
      max-height: 400px;
      overflow-y: auto;
    }

    @media (max-width: 768px) {
      .dashboard-container {
        grid-template-columns: 1fr;
      }

      .dashboard-title,
      .booking-stats-card,
      .navigation-section,
      .booking-tabs,
      .drivers-section,
      .vehicles-section {
        grid-column: span 1;
      }
    }
  </style>
</head>
<body>
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

<div class="dashboard-container">
  <!-- Title (Position 23) -->
  <div class="dashboard-title">
    <h2><i class="fas fa-taxi me-2"></i> Manage Bookings</h2>
  </div>

  <!-- Booking Stat Cards (Positions 24-27) -->
  <div class="booking-stats-card total-bookings">
    <div class="card-icon">
      <i class="fas fa-book"></i>
    </div>
    <h5>Total Bookings</h5>
    <div class="card-value"><%= totalBookings %></div>
  </div>

  <div class="booking-stats-card pending-bookings">
    <div class="card-icon">
      <i class="fas fa-clock"></i>
    </div>
    <h5>Pending Bookings</h5>
    <div class="card-value"><%= pendingBookings %></div>
  </div>

  <div class="booking-stats-card confirmed-bookings">
    <div class="card-icon">
      <i class="fas fa-check-circle"></i>
    </div>
    <h5>Confirmed Bookings</h5>
    <div class="card-value"><%= confirmedBookings %></div>
  </div>

  <div class="booking-stats-card cancelled-bookings">
    <div class="card-icon">
      <i class="fas fa-times-circle"></i>
    </div>
    <h5>Cancelled Bookings</h5>
    <div class="card-value"><%= cancelledBookings %></div>
  </div>

  <!-- Navigation Section (Position 28) -->
  <div class="navigation-section">

    <!-- Tabs -->
    <ul class="nav nav-tabs">
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
  </div>

  <!-- Booking Tabs Content (Position 29) -->
  <div class="booking-tabs">
    <div class="tab-content">
      <!-- Pending Bookings -->
      <div class="tab-pane fade show active" id="pending">
        <div class="table-responsive">
          <table class="table table-bordered table-hover">
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
                <a href="assign-booking?bookingId=<%= booking.getBookingId() %>" class="btn btn-sm btn-primary">Assign</a>
                <a href="${pageContext.request.contextPath}/admin/cancel-booking?bookingId=<%= booking.getBookingId() %>" class="btn btn-sm btn-danger">Cancel</a>
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
      </div>

      <!-- Confirmed Bookings -->
      <div class="tab-pane fade" id="confirmed">
        <div class="table-responsive">
          <table class="table table-bordered table-hover">
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
              <td><%= booking.getDate() %></td>
              <td><%= booking.getTime() %></td>
              <td><%= booking.getFinalAmount() %></td>
              <td><%= booking.getPaymentMethod() %></td>
              <td><%= booking.getPaymentStatus() %></td>
              <td><%= booking.getVehicleNumber() %></td>
              <td><%= booking.getDriverName() %></td>
              <td>
                <form action="complete-booking" method="post">
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

      <!-- Cancelled Bookings -->
      <div class="tab-pane fade" id="cancelled">
        <div class="table-responsive">
          <table class="table table-bordered table-hover">
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

      <!-- Completed Bookings -->
      <div class="tab-pane fade" id="completed">
        <div class="table-responsive">
          <table class="table table-bordered table-hover">
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
                <form action="manage-bookings" method="post">
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
      </div>
    </div>
  </div>

  <!-- Available Drivers (Position 31) -->
  <div class="drivers-section">
    <div class="section-header">
      <h4 class="section-title"><i class="fas fa-user-tie me-2"></i> Available Drivers</h4>
    </div>
    <div class="table-responsive">
      <table class="table table-bordered table-hover">
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
          <td><span class="badge bg-success"><%= driver.getStatus() %></span></td>
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

  <!-- Available Vehicles (Position 32) -->
  <div class="vehicles-section">
    <div class="section-header">
      <h4 class="section-title"><i class="fas fa-car me-2"></i> Available Vehicles</h4>
    </div>

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

    <div class="table-responsive">
      <table class="table table-bordered table-hover">
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
          <td>
            <span class="d-inline-block me-2" style="width: 20px; height: 20px; background-color: <%= vehicle.getColor() %>; border-radius: 50%; border: 1px solid #ddd;"></span>
            <%= vehicle.getColor() %>
          </td>
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
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>