<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Details - MegaCab</title>
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
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
        }

        .main-content {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
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

        .booking-card {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            padding: 30px;
            margin-bottom: 30px;
        }

        .booking-card:hover {
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
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

        .footer {
            text-align: center;
            padding: 20px;
            color: var(--gray);
            font-size: 0.9rem;
        }

        .section-title {
            font-size: 1.2rem;
            color: var(--secondary);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--light-gray);
        }

        .info-section {
            margin-bottom: 25px;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .info-label {
            font-weight: 500;
            color: var(--gray);
        }

        .info-value {
            font-weight: 600;
            color: var(--dark);
            text-align: right;
        }

        .price-section {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 25px;
        }

        .price-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .final-price {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary);
            margin-top: 5px;
            padding-top: 15px;
            border-top: 1px dashed var(--gray);
        }

        .payment-method-section {
            margin-bottom: 25px;
        }

        .payment-method-label {
            font-weight: 500;
            margin-bottom: 10px;
            display: block;
        }

        .payment-method-options {
            display: flex;
            gap: 15px;
        }

        .payment-method-option {
            flex: 1;
            position: relative;
        }

        .payment-method-option input {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .payment-method-option label {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 15px;
            border: 2px solid var(--light-gray);
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .payment-method-option label:hover {
            border-color: var(--primary);
            background-color: rgba(255, 107, 0, 0.05);
        }

        .payment-method-option input:checked + label {
            border-color: var(--primary);
            background-color: rgba(255, 107, 0, 0.1);
        }

        .payment-method-icon {
            font-size: 2rem;
            margin-bottom: 10px;
            color: var(--secondary);
        }

        .payment-method-option input:checked + label .payment-method-icon {
            color: var(--primary);
        }

        .payment-method-text {
            font-weight: 500;
        }

        .btn-primary {
            background-color: var(--primary);
            border: none;
            padding: 12px 20px;
            font-weight: 500;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-back {
            background-color: var(--light);
            color: var(--secondary);
            border: 1px solid var(--light-gray);
            padding: 12px 20px;
            font-weight: 500;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background-color: var(--light-gray);
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 15px;
                margin: 20px auto;
            }

            .booking-card {
                padding: 20px;
            }

            .payment-method-options {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
<%
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp?error=You must log in to make a booking.");
        return;
    }
    String email = (String) session.getAttribute("email");
%>

<div class="main-content">
    <!-- Logo -->
    <div class="brand-logo">
        <img src="Assets/images/megacab-logo.svg" alt="MegaCab Logo" onerror="this.src='/api/placeholder/70/35'; this.onerror=null;">
        <h2 class="brand-text">Mega<span>Cab</span></h2>
    </div>

    <!-- Steps Indicator -->
    <div class="steps-indicator">
        <div class="step">
            <div class="step-number">1</div>
            <div class="step-text">Booking Details</div>
        </div>
        <div class="step active">
            <div class="step-number">2</div>
            <div class="step-text">Payment</div>
        </div>
        <div class="step">
            <div class="step-number">3</div>
            <div class="step-text">Confirmation</div>
        </div>
    </div>

    <div class="page-title">
        <h1>Payment Details</h1>
        <p>Please review your booking details and complete payment</p>
    </div>

    <div class="booking-card">
        <form method="post" action="confirm-booking">
            <!-- Hidden Fields -->
            <input type="hidden" name="customerId" value="${customerId}">
            <input type="hidden" name="pickupLocation" value="${pickupLocation}">
            <input type="hidden" name="dropLocation" value="${dropLocation}">
            <input type="hidden" name="date" value="${date}">
            <input type="hidden" name="time" value="${time}">
            <input type="hidden" name="numPassengers" value="${numPassengers}">
            <input type="hidden" name="vehicleType" value="${vehicleType}">
            <input type="hidden" name="totalDistance" value="${totalDistance}">
            <input type="hidden" name="basePrice" value="${basePrice}">
            <input type="hidden" name="taxAmount" value="${taxAmount}">
            <input type="hidden" name="discountAmount" value="${discountAmount}">
            <input type="hidden" name="finalFare" value="${finalFare}">

            <!-- Ride Details Section -->
            <h3 class="section-title">Ride Details</h3>
            <div class="info-section">
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-map-marker-alt me-2"></i>Pickup</span>
                    <span class="info-value">${pickupLocation}</span>
                </div>
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-map-marker me-2"></i>Drop-off</span>
                    <span class="info-value">${dropLocation}</span>
                </div>
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-calendar me-2"></i>Date</span>
                    <span class="info-value">${date}</span>
                </div>
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-clock me-2"></i>Time</span>
                    <span class="info-value">${time}</span>
                </div>
            </div>

            <!-- Vehicle Details Section -->
            <h3 class="section-title">Vehicle Details</h3>
            <div class="info-section">
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-car me-2"></i>Vehicle Type</span>
                    <span class="info-value">${vehicleType}</span>
                </div>
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-users me-2"></i>Passengers</span>
                    <span class="info-value">${numPassengers}</span>
                </div>
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-route me-2"></i>Distance</span>
                    <span class="info-value">${totalDistance} km</span>
                </div>
            </div>

            <!-- Price Breakdown Section -->
            <h3 class="section-title">Price Breakdown</h3>
            <div class="price-section">
                <div class="price-item">
                    <span class="info-label">Base Price</span>
                    <span class="info-value">$${basePrice}</span>
                </div>
                <div class="price-item">
                    <span class="info-label">Tax</span>
                    <span class="info-value">$${taxAmount}</span>
                </div>
                <div class="price-item">
                    <span class="info-label">Discount</span>
                    <span class="info-value text-success">-$${discountAmount}</span>
                </div>
                <div class="price-item final-price">
                    <span class="info-label">Total Fare</span>
                    <span class="info-value">$${finalFare}</span>
                </div>
            </div>

            <!-- Payment Method Section -->
            <h3 class="section-title">Payment Method</h3>
            <div class="payment-method-section">
                <div class="payment-method-options">
                    <div class="payment-method-option">
                        <input type="radio" id="cashPayment" name="paymentMethod" value="Cash" checked>
                        <label for="cashPayment">
                            <i class="fas fa-money-bill-wave payment-method-icon"></i>
                            <span class="payment-method-text">Cash</span>
                        </label>
                    </div>
                    <div class="payment-method-option">
                        <input type="radio" id="cardPayment" name="paymentMethod" value="Card">
                        <label for="cardPayment">
                            <i class="fas fa-credit-card payment-method-icon"></i>
                            <span class="payment-method-text">Card</span>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="d-flex justify-content-between mt-4">
                <a href="javascript:history.back()" class="btn btn-back">
                    <i class="fas fa-arrow-left me-2"></i> Back
                </a>
                <button type="submit" class="btn btn-primary ms-2">Confirm Booking <i class="fas fa-check-circle ms-2"></i></button>
            </div>
        </form>
    </div>

    <div class="footer">
        &copy; 2025 MegaCab. All rights reserved.
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>