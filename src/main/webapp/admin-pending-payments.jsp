<%@ page import="com.example.megacitycab.model.Payment" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("admin") == null) {
        response.sendRedirect("admin-login.jsp?error=You must log in to access the admin dashboard.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Payments - MegaCab</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Pending Payments</h2>

    <!-- Total Pending Income Statistic -->
    <div class="card mb-4">
        <div class="card-body text-center">
            <h5 class="card-title">Total Pending Income</h5>
            <p class="card-text">$<%= request.getAttribute("totalPendingIncome") %></p>
        </div>
    </div>

    <!-- Pending Payments Table -->
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Booking ID</th>
            <th>Customer Name</th>
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
        <%
            List<Payment> pendingPayments = (List<Payment>) request.getAttribute("pendingPayments");
            if (pendingPayments != null && !pendingPayments.isEmpty()) {
                for (Payment payment : pendingPayments) {
        %>
        <tr>
            <td><%= payment.getBookingId() %></td>
            <td><%= payment.getCustomerName() %></td>
            <td><%= payment.getVehicleType() %></td>
            <td><%= payment.getPickupLocation() %></td>
            <td><%= payment.getDropLocation() %></td>
            <td><%= payment.getDate() %></td>
            <td><%= payment.getTime() %></td>
            <td>$<%= payment.getFinalAmount() %></td>
            <td>
                <form action="admin-manage-payments" method="get" style="display:inline;">
                    <input type="hidden" name="action" value="viewDetails">
                    <input type="hidden" name="bookingId" value="<%= payment.getBookingId() %>">
                    <button type="submit" class="btn btn-primary btn-sm">View Details</button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="9" class="text-center">No pending payments found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>