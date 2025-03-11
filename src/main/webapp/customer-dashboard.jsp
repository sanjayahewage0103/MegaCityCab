<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - MegaCab</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .dashboard-links a {
            text-decoration: none;
            color: #0d6efd;
            font-weight: bold;
        }
        .dashboard-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp?error=You must log in to access the dashboard.");
        return;
    }

    String email = (String) session.getAttribute("email");
%>

<div class="container">
    <h1>Welcome to Your Dashboard, <%= email %>!</h1>
    <p>Quick Access:</p>
    <div class="dashboard-links">
        <ul>
            <li><a href="customer-profile.jsp">View Profile</a></li>
            <li><a href="make-booking.jsp">Make Booking</a></li>
            <li><a href="booking-activity.jsp">Booking Activity</a></li>
            <li><a href="payment-activity.jsp">Payment Activity</a></li>
            <li><a href="help.jsp">Help</a></li>
            <li><a href="logout">Logout</a></li>
        </ul>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>