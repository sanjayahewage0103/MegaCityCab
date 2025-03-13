<%@ page import="com.example.megacitycab.model.Payment" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Make Payment - MegaCab</title>
  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome Icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <!-- Custom Styles -->
  <style>
    :root {
      --primary: #FF6B00;
      --primary-dark: #E55A00;
      --secondary: #2C3E50;
      --light: #F8F9FA;
      --dark: #1A1A1A;
      --gray: #6C757D;
      --light-gray: #E9ECEF;
    }
    body {
      font-family: 'Poppins', sans-serif;
      color: var(--dark);
      background-color: #f4f6f9;
      overflow-x: hidden;
    }
    .tab-content {
      margin-top: 20px;
    }
    .table th {
      font-weight: 600;
      color: var(--secondary);
    }
    .btn-primary {
      background-color: var(--primary);
      border: none;
    }
    .btn-primary:hover {
      background-color: var(--primary-dark);
    }
    .ride-status {
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 0.85rem;
      font-weight: 500;
    }
    .status-completed {
      background-color: rgba(46, 204, 113, 0.15);
      color: #2ecc71;
    }
    .status-pending {
      background-color: rgba(241, 196, 15, 0.15);
      color: #f1c40f;
    }
    .status-cancelled {
      background-color: rgba(231, 76, 60, 0.15);
      color: #e74c3c;
    }
  </style>
</head>
<body>
<!-- Main Content -->
<div class="main-content">
  <div class="container-fluid">
    <h2 class="mb-4">Manage Payments</h2>

    <!-- Tabs -->
    <ul class="nav nav-tabs" id="paymentTabs" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button" role="tab" aria-controls="pending" aria-selected="true">
          <i class="fas fa-clock me-2"></i>Pending Payments
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="history-tab" data-bs-toggle="tab" data-bs-target="#history" type="button" role="tab" aria-controls="history" aria-selected="false">
          <i class="fas fa-history me-2"></i>Payment History
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="completed-tab" data-bs-toggle="tab" data-bs-target="#completed" type="button" role="tab" aria-controls="completed" aria-selected="false">
          <i class="fas fa-check-circle me-2"></i>Completed Payments
        </button>
      </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content" id="paymentTabsContent">
      <!-- Pending Payments -->
      <div class="tab-pane fade show active" id="pending" role="tabpanel" aria-labelledby="pending-tab">
        <div class="card mt-3">
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
                <td><span class="ride-status status-pending"><%= payment.getPaymentStatus() %></span></td>
                <td>
                  <form action="make-payment" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="updatePaymentMethod">
                    <input type="hidden" name="bookingId" value="<%= payment.getBookingId() %>">
                    <select name="paymentMethod" class="form-select form-select-sm">
                      <option value="Card">Card</option>
                      <option value="Cash">Cash</option>
                    </select>
                    <button type="submit" class="btn btn-warning btn-sm">Change</button>
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
      </div>

      <!-- Payment History -->
      <div class="tab-pane fade" id="history" role="tabpanel" aria-labelledby="history-tab">
        <div class="card mt-3">
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
                <td><span class="ride-status status-completed"><%= payment.getPaymentStatus() %></span></td>
                <td><%= payment.getTransactionId() %></td>
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
      </div>

      <!-- Completed Payments -->
      <div class="tab-pane fade" id="completed" role="tabpanel" aria-labelledby="completed-tab">
        <div class="card mt-3">
          <div class="card-body">
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
      </div>
    </div>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
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
</body>
</html>