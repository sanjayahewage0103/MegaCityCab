<%--
  Created by IntelliJ IDEA.
  User: pethu
  Date: 3/5/2025
  Time: 11:29 AM
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Support - MegaCab</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
            line-height: 1.6;
        }
        .support-section {
            margin-bottom: 40px;
        }
        .support-section h3 {
            color: #FF4500;
            border-bottom: 2px solid #FF4500;
            padding-bottom: 10px;
        }
        .support-section ul {
            list-style-type: disc;
            margin-left: 20px;
        }
        .support-section code {
            background-color: #e9ecef;
            padding: 2px 5px;
            border-radius: 5px;
        }
        .back-to-dashboard {
            display: inline-block;
            margin-top: 30px;
            padding: 10px 20px;
            background-color: #FF4500;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .back-to-dashboard:hover {
            background-color: #C43E00;
        }
        .contact-info {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .contact-info i {
            margin-right: 10px;
            color: #FF4500;
        }
    </style>
</head>
<body>
<div class="container mt-5">

    <!-- Overview Section -->
    <div class="support-section">
        <h3>Overview</h3>
        <p>
            We are here to assist you with any questions or issues you may have while using the MegaCab system.
            Below, you'll find answers to frequently asked questions, troubleshooting tips, and contact information
            for further assistance.
        </p>
    </div>

    <!-- Frequently Asked Questions (FAQ) -->
    <div class="support-section">
        <h3>Frequently Asked Questions (FAQ)</h3>
        <div class="accordion" id="faqAccordion">
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                        How do I book a ride?
                    </button>
                </h2>
                <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        To book a ride, log in to your account, navigate to the "Book Ride" section, and fill in your
                        pickup location, drop-off location, and preferred vehicle type. Confirm your booking, and you're
                        all set!
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                        How can I view my recent rides?
                    </button>
                </h2>
                <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        You can view your recent rides by navigating to the "Recent Rides" section on your dashboard.
                        All confirmed and scheduled rides will be displayed there.
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                        What should I do if my payment fails?
                    </button>
                </h2>
                <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        If your payment fails, please check your internet connection and try again. If the issue persists,
                        contact our support team for assistance.
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq4">
                        How do I apply a promo code?
                    </button>
                </h2>
                <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        To apply a promo code, enter it during the booking process in the designated field. The discount
                        will be applied automatically if the code is valid.
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Troubleshooting Tips -->
    <div class="support-section">
        <h3>Troubleshooting Tips</h3>
        <ul>
            <li>If you cannot log in, ensure that you are entering the correct email and password.</li>
            <li>Clear your browser cache if pages are not loading correctly.</li>
            <li>Check your internet connection if transactions or bookings fail.</li>
            <li>Contact support if you encounter persistent issues.</li>
        </ul>
    </div>

    <!-- Contact Information -->
    <div class="support-section">
        <h3>Contact Us</h3>
        <div class="contact-info">
            <p><i class="fas fa-phone"></i> Phone: +94 11 234 5678</p>
            <p><i class="fas fa-envelope"></i> Email: support@megacab.lk</p>
            <p><i class="fas fa-map-marker-alt"></i> Address: No. 45, Galle Road, Colombo 03, Sri Lanka</p>
        </div>
    </div>

    <!-- Back to Dashboard -->
    <a href="index.jsp" class="back-to-dashboard"><i class="fas fa-arrow-left"></i> Back to Home</a>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>