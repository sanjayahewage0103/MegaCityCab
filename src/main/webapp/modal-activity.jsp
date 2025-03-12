<%@ page import="com.example.megacitycab.model.Booking" %><%--
  Created by IntelliJ IDEA.
  User: pethu
  Date: 3/13/2025
  Time: 4:00 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
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
</body>
</html>
