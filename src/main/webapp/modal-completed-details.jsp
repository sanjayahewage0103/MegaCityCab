<%@ page import="com.example.megacitycab.model.Booking" %><%--
  Created by IntelliJ IDEA.
  User: pethu
  Date: 3/13/2025
  Time: 9:01 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Title</title>
  </head>
  <body>
  <div class="modal fade" id="completedDetailsModal" tabindex="-1" aria-labelledby="completedDetailsModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title" id="completedDetailsModalLabel">Booking Details</h5>
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
          // Add event listener to all "View" buttons
          const viewBookingButtons = document.querySelectorAll('.view-booking-btn');
          viewBookingButtons.forEach(button => {
              button.addEventListener('click', function () {
                  // Retrieve data attributes from the clicked button
                  const customerName = this.getAttribute('data-customer-name');
                  const customerMobile = this.getAttribute('data-customer-mobile');
                  const date = this.getAttribute('data-date');
                  const time = this.getAttribute('data-time');
                  const pickupLocation = this.getAttribute('data-pickup-location');
                  const dropLocation = this.getAttribute('data-drop-location');
                  const totalDistance = this.getAttribute('data-total-distance');
                  const basePrice = this.getAttribute('data-base-price');
                  const taxAmount = this.getAttribute('data-tax-amount');
                  const discountAmount = this.getAttribute('data-discount-amount');
                  const finalAmount = this.getAttribute('data-final-amount');
                  const vehicleType = this.getAttribute('data-vehicle-type');
                  const numPassengers = this.getAttribute('data-num-passengers');
                  const driverName = this.getAttribute('data-driver-name');
                  const vehicleNumber = this.getAttribute('data-vehicle-number');
                  const vehicleColor = this.getAttribute('data-vehicle-color');
                  const paymentMethod = this.getAttribute('data-payment-method');
                  const transactionId = this.getAttribute('data-transaction-id');
                  const bookingStatus = this.getAttribute('data-booking-status');
                  const paymentStatus = this.getAttribute('data-payment-status');

                  // Populate the modal with the retrieved data
                  document.getElementById('modalCustomerName').textContent = customerName;
                  document.getElementById('modalCustomerMobile').textContent = customerMobile;
                  document.getElementById('modalDate').textContent = date;
                  document.getElementById('modalTime').textContent = time;
                  document.getElementById('modalPickupLocation').textContent = pickupLocation;
                  document.getElementById('modalDropLocation').textContent = dropLocation;
                  document.getElementById('modalTotalDistance').textContent = totalDistance;
                  document.getElementById('modalBasePrice').textContent = basePrice;
                  document.getElementById('modalTaxAmount').textContent = taxAmount;
                  document.getElementById('modalDiscountAmount').textContent = discountAmount;
                  document.getElementById('modalFinalAmount').textContent = finalAmount;
                  document.getElementById('modalVehicleType').textContent = vehicleType;
                  document.getElementById('modalNumPassengers').textContent = numPassengers;
                  document.getElementById('modalDriverName').textContent = driverName;
                  document.getElementById('modalVehicleNumber').textContent = vehicleNumber;
                  document.getElementById('modalVehicleColor').textContent = vehicleColor;
                  document.getElementById('modalPaymentMethod').textContent = paymentMethod;
                  document.getElementById('modalTransactionId').textContent = transactionId;
                  document.getElementById('modalBookingStatus').textContent = bookingStatus;
                  document.getElementById('modalPaymentStatus').textContent = paymentStatus;
              });
          });
      });
  </script>
  </body>
</html>
