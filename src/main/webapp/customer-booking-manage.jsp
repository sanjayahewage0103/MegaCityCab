<%@ page import="com.example.megacitycab.model.Booking" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Customer Booking Management</title>
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
      --primary: #FF4500; /* Intense Orange-Red */
      --primary-dark: #C43E00; /* Darker shade */
      --secondary: #2C3E50;
      --accent: #FF6347; /* Tomato Red */
      --dark-bg: rgba(255, 255, 255, 0.9);
      --dark-card: #2C2C2E;
      --dark-text: #E1E1E3;
      --dark-hover: #FF5733;
    }
    body {
      font-family: 'Inter', sans-serif;
      background-color: var(--dark-bg);
      color: var(--dark-text);
      transition: all 0.3s ease;
    }
    .container-fluid {
      height: 100vh;
      display: flex;
      flex-direction: column;
    }
    .main-content {
      flex: 1;
      overflow-y: auto;
    }
    .nav-tabs {
      border-bottom: 2px solid var(--primary);
    }
    .nav-tabs .nav-link {
      color: var(--dark-text);
      font-weight: 500;
      border: none;
      margin-bottom: -2px;
      transition: all 0.3s ease;
    }
    .nav-tabs .nav-link.active {
      background-color: transparent;
      color: var(--primary);
      border-bottom: 2px solid var(--primary);
    }
    .nav-tabs .nav-link:hover {
      color: var(--primary-dark);
    }
    .card {
      background-color: var(--dark-card);
      border: none;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      transition: all 0.3s ease;
    }
    .table {
      color: var(--dark-text);
    }
    .table thead th {
      background-color: var(--primary);
      color: white;
      border: none;
    }
    .table tbody tr:hover {
      background-color: rgba(255, 67, 51, 0.1);
    }
    .btn-sm {
      font-size: 0.8rem;
      padding: 5px 10px;
    }
  </style>
</head>
<body>
<div class="container-fluid d-flex flex-column">
  <!-- Header -->
  <header class="bg-primary text-white py-3 px-4">
    <h2 class="mb-0"><i class="fas fa-book me-2"></i> Customer Booking Management</h2>
  </header>

  <!-- Main Content -->
  <div class="main-content p-4">
    <!-- Tabs -->
    <ul class="nav nav-tabs mb-4" id="bookingTabs" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button" role="tab" aria-controls="pending" aria-selected="true">
          <i class="fas fa-clock me-2"></i>Pending
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="confirmed-tab" data-bs-toggle="tab" data-bs-target="#confirmed" type="button" role="tab" aria-controls="confirmed" aria-selected="false">
          <i class="fas fa-check-circle me-2"></i>Confirmed
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="cancelled-tab" data-bs-toggle="tab" data-bs-target="#cancelled" type="button" role="tab" aria-controls="cancelled" aria-selected="false">
          <i class="fas fa-ban me-2"></i>Cancelled
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="completed-tab" data-bs-toggle="tab" data-bs-target="#completed" type="button" role="tab" aria-controls="completed" aria-selected="false">
          <i class="fas fa-check-double me-2"></i>Completed
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" type="button" role="tab" aria-controls="all" aria-selected="false">
          <i class="fas fa-list-alt me-2"></i>All Bookings
        </button>
      </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content" id="bookingTabsContent">
      <!-- Pending Bookings -->
      <div class="tab-pane fade show active" id="pending" role="tabpanel" aria-labelledby="pending-tab">
        <div class="card">
          <div class="card-body">
            <table class="table table-bordered">
              <thead>
              <tr>
                <th>Booking ID</th>
                <th>Vehicle Type</th>
                <th>Pickup Location</th>
                <th>Drop Location</th>
                <th>Date</th>
                <th>Time</th>
                <th>Final Amount</th>
                <th>Payment Method</th>
                <th>Action</th>
              </tr>
              </thead>
              <tbody>
              <%
                List<Booking> pendingBookingsList = (List<Booking>) request.getAttribute("pendingBookingsList");
                if (pendingBookingsList != null && !pendingBookingsList.isEmpty()) {
                  for (Booking booking : pendingBookingsList) {
              %>
              <tr>
                <td><%= booking.getBookingId() %></td>
                <td><%= booking.getVehicleType() %></td>
                <td><%= booking.getPickupLocation() %></td>
                <td><%= booking.getDropLocation() %></td>
                <td><%= booking.getDate() %></td>
                <td><%= booking.getTime() %></td>
                <td>$<%= booking.getFinalAmount() %></td>
                <td><%= booking.getPaymentMethod() %></td>
                <td>
                  <form action="customer-booking-manage" method="post" style="display:inline;">
                    <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                    <button type="submit" class="btn btn-danger btn-sm">Cancel</button>
                  </form>
                </td>
              </tr>
              <%
                }
              } else {
              %>
              <tr>
                <td colspan="9" class="text-center">No pending bookings found.</td>
              </tr>
              <% } %>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Confirmed Bookings -->
      <div class="tab-pane fade" id="confirmed" role="tabpanel" aria-labelledby="confirmed-tab">
        <div class="card">
          <div class="card-body">
            <table class="table table-bordered">
              <thead>
              <tr>
                <th>Booking ID</th>
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
                <td><%= booking.getVehicleType() %></td>
                <td><%= booking.getPickupLocation() %></td>
                <td><%= booking.getDropLocation() %></td>
                <td><%= booking.getDate() %></td>
                <td><%= booking.getTime() %></td>
                <td>$<%= booking.getFinalAmount() %></td>
                <td><%= booking.getPaymentMethod() %></td>
                <td><%= booking.getPaymentStatus() %></td>
                <td><%= booking.getVehicleNumber() %></td>
                <td><%= booking.getDriverName() %></td>
                <td>
                  <button type="button" class="btn btn-warning btn-sm change-payment-method-btn"
                          data-bs-toggle="modal" data-bs-target="#changePaymentMethodModal"
                          data-booking-id="<%= booking.getBookingId() %>">
                    Change Payment Method
                  </button>
                  <form action="customer-booking-manage" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="makePayment">
                    <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                    <button type="submit" class="btn btn-success btn-sm">Make Payment</button>
                  </form>
                </td>
              </tr>
              <%
                }
              } else {
              %>
              <tr>
                <td colspan="12" class="text-center">No confirmed bookings found.</td>
              </tr>
              <% } %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <div class="modal fade" id="changePaymentMethodModal" tabindex="-1" aria-labelledby="changePaymentMethodModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="changePaymentMethodModalLabel">Change Payment Method</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form action="customer-booking-manage" method="post">
                <input type="hidden" name="action" value="updatePaymentMethod">
                <input type="hidden" name="bookingId" id="modalBookingIdInput">
                <div class="mb-3">
                  <label for="paymentMethodSelect" class="form-label">Payment Method</label>
                  <select class="form-select" id="paymentMethodSelect" name="paymentMethod">
                    <option value="Card">Card</option>
                    <option value="Cash">Cash</option>
                  </select>
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- Cancelled Bookings -->
      <div class="tab-pane fade" id="cancelled" role="tabpanel" aria-labelledby="cancelled-tab">
        <div class="card">
          <div class="card-body">
            <table class="table table-bordered">
              <thead>
              <tr>
                <th>Booking ID</th>
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
                <td><%= booking.getVehicleType() %></td>
                <td><%= booking.getPickupLocation() %></td>
                <td><%= booking.getDropLocation() %></td>
                <td><%= booking.getDate() %></td>
                <td><%= booking.getTime() %></td>
                <td>$<%= booking.getFinalAmount() %></td>
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
                <td colspan="11" class="text-center">No cancelled bookings found.</td>
              </tr>
              <% } %>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Completed Bookings -->
      <div class="tab-pane fade" id="completed" role="tabpanel" aria-labelledby="completed-tab">
        <div class="card">
          <div class="card-body">
            <table class="table table-bordered">
              <thead>
              <tr>
                <th>Booking ID</th>
                <th>Payment ID</th>
                <th>Date</th>
                <th>Time</th>
                <th>Status</th>
                <th>Pickup Location</th>
                <th>Drop Location</th>
                <th>Final Amount</th>
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
                <td><%= booking.getPaymentId() %></td>
                <td><%= booking.getDate() %></td>
                <td><%= booking.getTime() %></td>
                <td><%= booking.getStatus() %></td>
                <td><%= booking.getPickupLocation() %></td>
                <td><%= booking.getDropLocation() %></td>
                <td>$<%= booking.getFinalAmount() %></td>
                <td>
                  <form action="customer-booking-manage" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="viewDetails">
                    <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                    <button type="submit" class="btn btn-info btn-sm">Details</button>
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

      <!-- All Bookings -->
      <div class="tab-pane fade" id="all" role="tabpanel" aria-labelledby="all-tab">
        <div class="card">
          <div class="card-body">
            <table class="table table-bordered">
              <thead>
              <tr>
                <th>Booking ID</th>
                <th>Vehicle Type</th>
                <th>Pickup Location</th>
                <th>Drop Location</th>
                <th>Date</th>
                <th>Time</th>
                <th>Booking Status</th>
                <th>Payment Status</th>
                <th>Action</th>
              </tr>
              </thead>
              <tbody>
              <%
                List<Booking> allBookingsList = (List<Booking>) request.getAttribute("allBookingsList");
                if (allBookingsList != null && !allBookingsList.isEmpty()) {
                  for (Booking booking : allBookingsList) {
              %>
              <tr>
                <td><%= booking.getBookingId() %></td>
                <td><%= booking.getVehicleType() %></td>
                <td><%= booking.getPickupLocation() %></td>
                <td><%= booking.getDropLocation() %></td>
                <td><%= booking.getDate() %></td>
                <td><%= booking.getTime() %></td>
                <td><%= booking.getStatus() %></td>
                <td><%= booking.getPaymentStatus() %></td>
                <td>
                  <form action="customer-booking-manage" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="viewDetails">
                    <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                    <button type="submit" class="btn btn-info btn-sm">View</button>
                  </form>
                </td>
              </tr>
              <%
                }
              } else {
              %>
              <tr>
                <td colspan="9" class="text-center">No bookings found.</td>
              </tr>
              <% } %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal for Viewing Booking Details -->
  <div class="modal fade" id="viewDetailsModal" tabindex="-1" aria-labelledby="viewDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="viewDetailsModalLabel">Booking Details</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <%
            Booking bookingDetails = (Booking) request.getAttribute("bookingDetails");
            if (bookingDetails != null) {
          %>
          <p><strong>Customer Name:</strong> <%= bookingDetails.getCustomerName() %></p>
          <p><strong>Mobile Number:</strong> <%= bookingDetails.getCustomerMobile() %></p>
          <p><strong>Date:</strong> <%= bookingDetails.getDate() %></p>
          <p><strong>Time:</strong> <%= bookingDetails.getTime() %></p>
          <p><strong>Pickup Location:</strong> <%= bookingDetails.getPickupLocation() %></p>
          <p><strong>Drop Location:</strong> <%= bookingDetails.getDropLocation() %></p>
          <p><strong>Total Distance:</strong> <%= bookingDetails.getTotalDistance() %> km</p>
          <p><strong>Base Price:</strong> $<%= bookingDetails.getBasePrice() %></p>
          <p><strong>Tax Amount:</strong> $<%= bookingDetails.getTaxAmount() %></p>
          <p><strong>Discount Amount:</strong> $<%= bookingDetails.getDiscountAmount() %></p>
          <p><strong>Final Amount:</strong> $<%= bookingDetails.getFinalAmount() %></p>
          <p><strong>Vehicle Type:</strong> <%= bookingDetails.getVehicleType() %></p>
          <p><strong>Number of Passengers:</strong> <%= bookingDetails.getNumPassengers() %></p>
          <p><strong>Assigned Driver:</strong> <%= bookingDetails.getDriverName() %></p>
          <p><strong>Vehicle Number:</strong> <%= bookingDetails.getVehicleNumber() %></p>
          <p><strong>Vehicle Color:</strong> <%= bookingDetails.getVehicleColor() %></p>
          <p><strong>Payment Method:</strong> <%= bookingDetails.getPaymentMethod() %></p>
          <p><strong>Transaction ID:</strong> <%= bookingDetails.getTransactionId() %></p>
          <p><strong>Booking Status:</strong> <%= bookingDetails.getStatus() %></p>
          <p><strong>Payment Status:</strong> <%= bookingDetails.getPaymentStatus() %></p>
          <%
          } else {
          %>
          <p>No details available for this booking.</p>
          <%
            }
          %>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <script>
    // Wait for the DOM to fully load
    document.addEventListener("DOMContentLoaded", function () {
      // Add event listener to all "Change Payment Method" buttons
      const changePaymentMethodButtons = document.querySelectorAll('.change-payment-method-btn');
      changePaymentMethodButtons.forEach(button => {
        button.addEventListener('click', function () {
          // Get the booking ID from the button's data attribute
          const bookingId = this.getAttribute('data-booking-id');
          // Set the booking ID in the modal's hidden input field
          document.getElementById('modalBookingIdInput').value = bookingId;
        });
      });
    });
  </script>
  <!-- Bootstrap JS Bundle -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>