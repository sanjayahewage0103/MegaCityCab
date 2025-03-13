<%@ page import="com.example.megacitycab.model.Payment" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Payment Details | MegaCab</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #FF4500; /* Intense Orange-Red */
            --primary-dark: #C43E00; /* Darker shade */
            --secondary: #2C3E50;
            --light: #F8F9FA;
            --dark: #1A1A1A;
            --gray: #6C757D;
        }
        body {
            font-family: 'Poppins', sans-serif;
            color: var(--dark);
            background-color: var(--light);
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 40px auto;
        }
        h4 {
            color: var(--primary);
            font-weight: 700;
            margin-bottom: 20px;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            background-color: white;
        }
        .card-body {
            padding: 30px;
        }
        .details-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .details-item strong {
            color: var(--secondary);
            font-weight: 600;
        }
        .details-item span {
            color: var(--dark);
            font-weight: 500;
        }
        .btn-back {
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 107, 0, 0.2);
        }
        .btn-back:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }
        @media (max-width: 768px) {
            .container {
                margin: 20px auto;
            }
            .details-item {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <div class="container">
        <a class="btn btn-back" href="admin-manage-payments">
            <i class="fas fa-arrow-left me-2"></i> Back to Payments
        </a>
    </div>
</nav>

<!-- Main Content -->
<div class="container mt-5">
    <h4>Payment Details</h4>
    <div class="card">
        <div class="card-body">
            <%
                Payment paymentDetails = (Payment) request.getAttribute("paymentDetails");
                if (paymentDetails != null) {
            %>
            <div class="details-item">
                <strong>Booking ID:</strong>
                <span><%= paymentDetails.getBookingId() %></span>
            </div>
            <div class="details-item">
                <strong>Customer Name:</strong>
                <span><%= paymentDetails.getCustomerName() %></span>
            </div>
            <div class="details-item">
                <strong>Pickup Location:</strong>
                <span><%= paymentDetails.getPickupLocation() %></span>
            </div>
            <div class="details-item">
                <strong>Drop Location:</strong>
                <span><%= paymentDetails.getDropLocation() %></span>
            </div>
            <div class="details-item">
                <strong>Date:</strong>
                <span><%= paymentDetails.getDate() %></span>
            </div>
            <div class="details-item">
                <strong>Time:</strong>
                <span><%= paymentDetails.getTime() %></span>
            </div>
            <div class="details-item">
                <strong>Vehicle Number:</strong>
                <span><%= paymentDetails.getVehicleNumber() %></span>
            </div>
            <div class="details-item">
                <strong>Driver Name:</strong>
                <span><%= paymentDetails.getDriverName() %></span>
            </div>
            <div class="details-item">
                <strong>Payment Method:</strong>
                <span><%= paymentDetails.getPaymentMethod() %></span>
            </div>
            <div class="details-item">
                <strong>Payment Status:</strong>
                <span><%= "Success".equalsIgnoreCase(paymentDetails.getPaymentStatus()) ? "<span style='color:green;'>Completed</span>" : "<span style='color:red;'>Pending</span>" %></span>
            </div>
            <div class="details-item">
                <strong>Transaction ID:</strong>
                <span><%= paymentDetails.getTransactionId() %></span>
            </div>
            <%
            } else {
            %>
            <p class="text-center text-muted">No payment details found.</p>
            <%
                }
            %>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>