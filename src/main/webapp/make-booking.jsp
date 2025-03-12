<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Ride - MegaCab</title>
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

        .form-label {
            font-weight: 500;
            color: var(--secondary);
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            padding: 12px 15px;
            border-radius: 10px;
            border: 1px solid var(--light-gray);
            color: var(--dark);
            font-size: 1rem;
            margin-bottom: 20px;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(255, 107, 0, 0.25);
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
            padding: 15px;
            color: var(--gray);
            font-size: 0.9rem;
            margin-top: auto;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .section-title {
            font-size: 1.2rem;
            color: var(--secondary);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--light-gray);
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group .form-control {
            padding-left: 40px;
            margin-bottom: 0;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
            z-index: 10;
        }

        /* Vehicle selection card view */
        .vehicle-options {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
        }

        .vehicle-option {
            flex: 1;
            min-width: 120px;
            position: relative;
        }

        .vehicle-option input {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .vehicle-card {
            border: 2px solid var(--light-gray);
            border-radius: 12px;
            padding: 15px;
            display: flex;
            flex-direction: column;
            align-items: center;
            cursor: pointer;
            transition: all 0.3s ease;
            height: 100%;
        }

        .vehicle-card:hover {
            border-color: var(--primary);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .vehicle-option input:checked + .vehicle-card {
            border-color: var(--primary);
            background-color: rgba(255, 107, 0, 0.05);
            box-shadow: 0 5px 15px rgba(255, 107, 0, 0.15);
        }

        .vehicle-icon {
            font-size: 2.5rem;
            color: var(--secondary);
            margin-bottom: 10px;
        }

        .vehicle-option input:checked + .vehicle-card .vehicle-icon {
            color: var(--primary);
        }

        .vehicle-name {
            font-weight: 600;
            text-align: center;
            margin-bottom: 5px;
        }

        .vehicle-info {
            font-size: 0.8rem;
            color: var(--gray);
            text-align: center;
        }

        .vehicle-price {
            margin-top: auto;
            font-weight: 500;
            color: var(--primary);
        }

        /* Responsive Landscape Mode */
        @media (min-width: 768px) and (max-height: 600px) {
            .main-content {
                padding: 15px;
                margin: 10px auto;
                height: auto;
                max-height: calc(100vh - 30px);
            }

            .brand-logo {
                margin-bottom: 15px;
            }

            .steps-indicator {
                margin-bottom: 15px;
            }

            .booking-card {
                padding: 15px;
                margin-bottom: 15px;
            }

            .vehicle-options {
                flex-wrap: nowrap;
                overflow-x: auto;
                padding-bottom: 5px;
                margin-bottom: 15px;
            }

            .vehicle-option {
                min-width: 180px;
                flex-shrink: 0;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 15px;
                margin: 15px auto;
                height: auto;
                max-height: calc(100vh - 30px);
            }

            .booking-card {
                padding: 20px;
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
            <div class="step">
                <div class="step-number">2</div>
                <div class="step-text">Payment</div>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <div class="step-text">Confirmation</div>
            </div>
        </div>

        <div class="page-title">
            <h1>Book Your Ride</h1>
            <p>Enter your journey details below</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <div class="booking-card">
            <form method="post" action="booking-servlet">
                <input type="hidden" name="action" value="calculate-fare">

                <h3 class="section-title">Select Your Vehicle</h3>

                <div class="vehicle-options">
                    <div class="vehicle-option">
                        <input type="radio" id="sedan" name="vehicleType" value="Sedan" required>
                        <label class="vehicle-card" for="sedan">
                            <i class="fas fa-car vehicle-icon"></i>
                            <div class="vehicle-name">Sedan</div>
                            <div class="vehicle-info">Up to 4 passengers</div>
                            <div class="vehicle-info">Standard comfort</div>
                            <div class="vehicle-price">From $15</div>
                        </label>
                    </div>

                    <div class="vehicle-option">
                        <input type="radio" id="suv" name="vehicleType" value="SUV" required>
                        <label class="vehicle-card" for="suv">
                            <i class="fas fa-truck vehicle-icon"></i>
                            <div class="vehicle-name">SUV</div>
                            <div class="vehicle-info">Up to 6 passengers</div>
                            <div class="vehicle-info">Extra comfort</div>
                            <div class="vehicle-price">From $25</div>
                        </label>
                    </div>

                    <div class="vehicle-option">
                        <input type="radio" id="van" name="vehicleType" value="Van" required>
                        <label class="vehicle-card" for="van">
                            <i class="fas fa-shuttle-van vehicle-icon"></i>
                            <div class="vehicle-name">Van</div>
                            <div class="vehicle-info">Up to 8 passengers</div>
                            <div class="vehicle-info">Group travel</div>
                            <div class="vehicle-price">From $35</div>
                        </label>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="numPassengers" class="form-label">Number of Passengers</label>
                    <div class="input-group">
                        <i class="fas fa-users input-icon"></i>
                        <input type="number" class="form-control" id="numPassengers" name="numPassengers" min="1" max="8" required>
                    </div>
                </div>

                <h3 class="section-title">Journey Information</h3>

                <div class="row">
                    <div class="col-md-6">
                        <label for="pickupLocation" class="form-label">Pickup Location</label>
                        <div class="input-group">
                            <i class="fas fa-map-marker-alt input-icon"></i>
                            <select class="form-select" id="pickupLocation" name="pickupLocation" required>
                                <option value="" disabled selected>Select pickup location</option>
                                <option value="Colombo 1">Colombo 1</option>
                                <option value="Colombo 2">Colombo 2</option>
                                <option value="Colombo 3">Colombo 3</option>
                                <option value="Colombo 4">Colombo 4</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label for="dropLocation" class="form-label">Drop-off Location</label>
                        <div class="input-group">
                            <i class="fas fa-map-pin input-icon"></i>
                            <select class="form-select" id="dropLocation" name="dropLocation" required>
                                <option value="" disabled selected>Select drop-off location</option>
                                <option value="Colombo 1">Colombo 1</option>
                                <option value="Colombo 2">Colombo 2</option>
                                <option value="Colombo 3">Colombo 3</option>
                                <option value="Colombo 4">Colombo 4</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <label for="date" class="form-label">Date</label>
                        <div class="input-group">
                            <i class="fas fa-calendar input-icon"></i>
                            <input type="date" class="form-control" id="date" name="date" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label for="time" class="form-label">Time</label>
                        <div class="input-group">
                            <i class="fas fa-clock input-icon"></i>
                            <input type="time" class="form-control" id="time" name="time" required>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="promoCode" class="form-label">Promo Code (Optional)</label>
                    <div class="input-group">
                        <i class="fas fa-tag input-icon"></i>
                        <input type="text" class="form-control" id="promoCode" name="promoCode" placeholder="Enter promo code if you have one">
                    </div>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="customer-dashboard.jsp" class="btn btn-back">
                        <i class="fas fa-arrow-left me-2"></i> Back to Dashboard
                    </a>
                    <button type="submit" class="btn btn-primary ms-2">Calculate Fare <i class="fas fa-arrow-right ms-2"></i></button>
                </div>
            </form>
        </div>
    </div>

    <div class="footer">
        &copy; 2025 MegaCab. All rights reserved.
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Set default date to today
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('date').min = today;
        document.getElementById('date').value = today;

        // Auto-update vehicle image based on selection
        const vehicleOptions = document.querySelectorAll('input[name="vehicleType"]');

        // Auto-adjust number of passengers based on vehicle selection
        vehicleOptions.forEach(option => {
            option.addEventListener('change', function() {
                const passengerInput = document.getElementById('numPassengers');
                const maxPassengers = this.value === 'Sedan' ? 4 : (this.value === 'SUV' ? 6 : 8);

                passengerInput.max = maxPassengers;

                if (parseInt(passengerInput.value) > maxPassengers) {
                    passengerInput.value = maxPassengers;
                }

                // Update placeholder text to show max passengers
                passengerInput.placeholder = `1-${maxPassengers} passengers`;
            });
        });
    });
</script>
</body>
</html>