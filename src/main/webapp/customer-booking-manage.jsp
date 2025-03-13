<%@ page import="com.example.megacitycab.model.Booking" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Customer Booking Management</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4">Customer Booking Management</h2>


  <!-- Section 1: Pending Bookings -->
  <div class="card mb-4">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Pending Bookings</h5>
    </div>
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



  <!-- Section 2: Confirmed Ongoing Bookings -->
  <div class="card mb-4">
    <div class="card-header bg-success text-white">
      <!-- Confirmed Bookings Table -->
      <div class="row mt-5">
        <div class="col-md-12">
          <h4 class="mb-3">Confirmed Bookings</h4>
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
                <!-- Button to open the modal -->
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

      <!-- Modal for Changing Payment Method -->
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

      <!-- Script to Handle Modal Opening -->
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
    <div class="card-body">




  <!-- Section 3: Cancelled Bookings -->
  <div class="card">
    <div class="card-header bg-secondary text-white">
      <!-- Cancelled Bookings Table -->
      <div class="row mt-5">
        <div class="col-md-12">
          <h4 class="mb-3">Cancelled Bookings</h4>
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



    <div class="card-body">
      <div class="card-header bg-secondary text-white">
        <!-- Cancelled Bookings Table -->
        <div class="row mt-5">
          <div class="col-md-12">
            <h4 class="mb-3">COMPLETED Bookings</h4>
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

      <div>
        <!-- All Bookings Table -->
        <div class="row mt-5">
          <div class="col-md-12">
            <h4 class="mb-3">All Bookings</h4>
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
      </div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>