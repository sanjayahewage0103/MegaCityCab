<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - MegaCab</title>
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
            --header-height: 70px;
        }

        body {
            font-family: 'Poppins', sans-serif;
            color: var(--dark);
            background-color: #f4f6f9;
            overflow-x: hidden;
            position: relative;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
        }

        .main-content {
            max-width: 1000px;
            width: 100%;
            margin: 30px auto;
            padding: 20px;
            flex: 1;
            height: calc(100vh - 100px);
            display: flex;
            flex-direction: column;
        }

        .scrollable-content {
            overflow-y: auto;
            flex: 1;
            padding-right: 5px;
        }

        .scrollable-content::-webkit-scrollbar {
            width: 6px;
        }

        .scrollable-content::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .scrollable-content::-webkit-scrollbar-thumb {
            background: var(--gray);
            border-radius: 10px;
        }

        .scrollable-content::-webkit-scrollbar-thumb:hover {
            background: var(--primary);
        }

        .page-title {
            margin-bottom: 25px;
            text-align: center;
        }

        .page-title h1 {
            margin: 0;
            font-size: 1.8rem;
            color: var(--secondary);
        }

        .page-title p {
            margin: 5px 0 0;
            color: var(--gray);
        }

        .brand-logo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 30px;
        }

        .brand-logo img {
            height: 35px;
            margin-right: 10px;
        }

        .brand-text {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            color: var(--secondary);
            margin: 0;
            font-size: 1.3rem;
        }

        .brand-text span {
            color: var(--primary);
        }

        .confirmation-card {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
        }

        .confirmation-card:hover {
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .success-icon {
            font-size: 4rem;
            color: #28a745;
            margin-bottom: 20px;
        }

        .btn-primary {
            background-color: var(--primary);
            border: none;
            padding: 12px 20px;
            font-weight: 500;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background-color: var(--light);
            color: var(--secondary);
            border: 1px solid var(--light-gray);
            padding: 12px 20px;
            font-weight: 500;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: var(--light-gray);
        }

        .steps-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            flex: 1;
            max-width: 120px;
        }

        .step:not(:last-child)::after {
            content: '';
            position: absolute;
            top: 15px;
            right: -50%;
            width: 100%;
            height: 2px;
            background-color: var(--light-gray);
            z-index: 1;
        }

        .step.active:not(:last-child)::after {
            background-color: var(--primary);
        }

        .step-number {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: var(--light-gray);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin-bottom: 10px;
            position: relative;
            z-index: 2;
        }

        .step.active .step-number {
            background-color: var(--primary);
            color: white;
        }

        .step-text {
            font-size: 0.9rem;
            color: var(--gray);
            text-align: center;
        }

        .step.active .step-text {
            color: var(--primary);
            font-weight: 500;
        }

        .confirmation-details {
            background-color: var(--light);
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
            text-align: left;
        }

        .confirmation-details p {
            margin-bottom: 10px;
            color: var(--secondary);
        }

        .footer {
            text-align: center;
            padding: 15px;
            color: var(--gray);
            font-size: 0.9rem;
            margin-top: auto;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 25px;
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 15px;
                margin: 15px auto;
                height: auto;
                max-height: calc(100vh - 30px);
            }

            .confirmation-card {
                padding: 20px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .action-buttons .btn {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
    <script>
        window.onload = function() {
            const message = "<%= request.getParameter("message") %>";
            if (message && message !== "null") {
                alert(message);
            }
        };
    </script>
</head>
<body>
<%
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp?error=You must log in to view booking details.");
        return;
    }
    String email = (String) session.getAttribute("email");
%>

<div class="main-content">
    <div class="scrollable-content">
        <!-- Logo -->
        <div class="brand-logo">
            <img src="Assets/images/megacab-logo.svg" alt="MegaCab Logo" onerror="this.src='/api/placeholder/70/35'; this.onerror=null;">
            <h2 class="brand-text">Mega<span>Cab</span></h2>
        </div>

        <!-- Steps Indicator -->
        <div class="steps-indicator">
            <div class="step active">
                <div class="step-number">1</div>
                <div class="step-text">Booking Details</div>
            </div>
            <div class="step active">
                <div class="step-number">2</div>
                <div class="step-text">Payment</div>
            </div>
            <div class="step active">
                <div class="step-number">3</div>
                <div class="step-text">Confirmation</div>
            </div>
        </div>

        <div class="page-title">
            <h1>Booking Confirmed!</h1>
            <p>Thank you for choosing MegaCab</p>
        </div>

        <div class="confirmation-card">
            <i class="fas fa-check-circle success-icon"></i>
            <h2>Success!</h2>
            <p class="mb-4">Your ride has been booked successfully. We will assign a driver and vehicle for you shortly.</p>

            <div class="confirmation-details">
                <p><strong><i class="fas fa-info-circle me-2"></i>Booking Reference:</strong> MGB<%= System.currentTimeMillis() % 10000 %></p>
                <p><strong><i class="fas fa-envelope me-2"></i>Confirmation Email:</strong> Sent to <%= email %></p>
                <p><strong><i class="fas fa-bell me-2"></i>Status Updates:</strong> We'll notify you when a driver is assigned</p>
            </div>

            <div class="action-buttons">
                <a href="customer-dashboard.jsp" class="btn btn-secondary">
                    <i class="fas fa-home me-2"></i> Back to Dashboard
                </a>
                <a href="customer-booking-manage" class="btn btn-primary">
                    <i class="fas fa-list me-2"></i> View Your Bookings
                </a>
            </div>
        </div>
    </div>

    <div class="footer">
        &copy; 2025 MegaCab. All rights reserved.
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>