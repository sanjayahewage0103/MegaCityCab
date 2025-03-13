<%@ page import="com.example.megacitycab.model.Payment" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: pethu
  Date: 3/13/2025
  Time: 6:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Title</title>
  </head>
  <body>
  <!-- Pending Payments Table -->
  <div class="row mt-5">
    <div class="col-md-12">
      <h4 class="mb-3">Pending Payments</h4>
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
          <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
          List<Payment> pendingPayments = (List<Payment>) request.getAttribute("pendingPayments");
          if (pendingPayments != null && !pendingPayments.isEmpty()) {
            for (Payment payment : pendingPayments) {
        %>
        <tr>
          <td><%= payment.getBookingId() %></td>
          <td><%= payment.getVehicleType() %></td>
          <td><%= payment.getPickupLocation() %></td>
          <td><%= payment.getDropLocation() %></td>
          <td><%= payment.getDate() %></td>
          <td><%= payment.getTime() %></td>
          <td>$<%= payment.getFinalAmount() %></td>
          <td><%= payment.getPaymentMethod() %></td>
          <td><%= payment.getPaymentStatus() %></td>
          <td>
            <form action="make-payment" method="post" style="display:inline;">
              <input type="hidden" name="action" value="updatePaymentMethod">
              <input type="hidden" name="bookingId" value="<%= payment.getBookingId() %>">
              <select name="paymentMethod" class="form-select form-select-sm">
                <option value="Card">Card</option>
                <option value="Cash">Cash</option>
              </select>
              <button type="submit" class="btn btn-warning btn-sm">Change Payment Method</button>
            </form>
            <button type="button" class="btn btn-success btn-sm pay-btn"
                    data-bs-toggle="modal" data-bs-target="#paymentModal"
                    data-booking-id="<%= payment.getBookingId() %>">
              Pay
            </button>
          </td>
        </tr>
        <%
          }
        } else {
        %>
        <tr>
          <td colspan="10" class="text-center">No pending payments found.</td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Modal for Payment -->
  <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="paymentModalLabel">Make Payment</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="paymentForm" action="make-payment" method="post">
            <input type="hidden" name="action" value="processPayment">
            <input type="hidden" id="modalBookingId" name="bookingId">
            <input type="hidden" id="transactionId" name="transactionId" value="TXN123456789">
            <div class="mb-3">
              <label for="cardNumber" class="form-label">Card Number</label>
              <input type="text" class="form-control" id="cardNumber" name="cardDetails" required>
            </div>
            <div class="mb-3">
              <label for="cvv" class="form-label">CVV</label>
              <input type="text" class="form-control" id="cvv" required>
            </div>
            <div class="mb-3">
              <label for="expiryDate" class="form-label">Expiry Date</label>
              <input type="month" class="form-control" id="expiryDate" required>
            </div>
            <button type="submit" class="btn btn-primary">Pay</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Script to Handle Modal Opening -->
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const payButtons = document.querySelectorAll('.pay-btn');
      payButtons.forEach(button => {
        button.addEventListener('click', function () {
          const bookingId = this.getAttribute('data-booking-id');
          document.getElementById('modalBookingId').value = bookingId;
        });
      });
    });
  </script>

  <!-- Payment History Table -->
  <div class="row mt-5">
    <div class="col-md-12">
      <h4 class="mb-3">Payment History</h4>
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
          <th>Transaction ID</th>
          <th>Encrypted Details</th>
        </tr>
        </thead>
        <tbody>
        <%
          List<Payment> paymentHistory = (List<Payment>) request.getAttribute("paymentHistory");
          if (paymentHistory != null && !paymentHistory.isEmpty()) {
            for (Payment payment : paymentHistory) {
        %>
        <tr>
          <td><%= payment.getBookingId() %></td>
          <td><%= payment.getVehicleType() %></td>
          <td><%= payment.getPickupLocation() %></td>
          <td><%= payment.getDropLocation() %></td>
          <td><%= payment.getDate() %></td>
          <td><%= payment.getTime() %></td>
          <td>$<%= payment.getFinalAmount() %></td>
          <td><%= payment.getPaymentMethod() %></td>
          <td><%= payment.getPaymentStatus() %></td>
          <td><%= payment.getTransactionId() %></td> <!-- Display transaction ID -->
          <td><%= payment.getEncryptedDetails() %></td>
        </tr>
        <%
          }
        } else {
        %>
        <tr>
          <td colspan="11" class="text-center">No payment history found.</td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>


  <!-- Completed Payments Table -->
  <div class="row mt-5">
    <div class="col-md-12">
      <h4 class="mb-3">Completed Payments</h4>
      <table class="table table-bordered">
        <thead>
        <tr>
          <th>Booking ID</th>
          <th>Pickup Location</th>
          <th>Drop Location</th>
          <th>Date</th>
          <th>Time</th>
          <th>Final Amount</th>
          <th>Payment Method</th>
          <th>Transaction ID</th>
          <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
          List<Payment> completedPayments = (List<Payment>) request.getAttribute("completedPayments");
          if (completedPayments != null && !completedPayments.isEmpty()) {
            for (Payment payment : completedPayments) {
        %>
        <tr>
          <td><%= payment.getBookingId() %></td>
          <td><%= payment.getPickupLocation() %></td>
          <td><%= payment.getDropLocation() %></td>
          <td><%= payment.getDate() %></td>
          <td><%= payment.getTime() %></td>
          <td>$<%= payment.getFinalAmount() %></td>
          <td><%= payment.getPaymentMethod() %></td>
          <td><%= payment.getTransactionId() %></td>
          <td>
            <form action="make-payment" method="get" style="display:inline;">
              <input type="hidden" name="action" value="downloadReceipt">
              <input type="hidden" name="bookingId" value="<%= payment.getBookingId() %>">
              <button type="submit" class="btn btn-primary btn-sm">Download Receipt</button>
            </form>
          </td>
        </tr>
        <%
          }
        } else {
        %>
        <tr>
          <td colspan="9" class="text-center">No completed payments found.</td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>


  </body>
</html>
