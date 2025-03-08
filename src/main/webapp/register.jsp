<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegaCab - Register</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- AOS Animation Library -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">
    <!-- Custom Styles -->
    <style>
        :root {
            --primary: #FF6B00;
            --primary-dark: #E55A00;
            --secondary: #2C3E50;
            --light: #F8F9FA;
            --dark: #1A1A1A;
            --gray: #6C757D;
        }

        body {
            font-family: 'Poppins', sans-serif;
            color: var(--dark);
            background-color: var(--light);
            overflow-x: hidden;
            height: 100vh;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
        }

        .btn-primary {
            background-color: var(--primary);
            border: none;
            color: white;
            font-weight: 600;
            padding: 12px 25px;
            border-radius: 50px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 107, 0, 0.3);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .register-container {
            height: 100vh;
            max-width: 100vw;
            display: flex;
            overflow: hidden;
        }

        .register-left {
            position: relative;
            flex: 1;
            background-color: #f9f4ef;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 40px;
            color: var(--secondary);
            overflow: hidden;
        }

        .register-left::after {
            content: "";
            position: absolute;
            right: -100px;
            top: 0;
            width: 200px;
            height: 100%;
            background: linear-gradient(90deg, rgba(249, 244, 239, 1) 0%, rgba(249, 244, 239, 0) 100%);
            z-index: 1;
        }

        .register-right {
            flex: 1;
            background-color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 40px;
            box-shadow: -5px 0 30px rgba(0, 0, 0, 0.05);
        }

        .register-logo {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }

        .register-logo img {
            height: 50px;
            margin-right: 10px;
        }

        .register-logo span {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 1.8rem;
            color: var(--secondary);
        }

        .register-logo span em {
            color: var(--primary);
            font-style: normal;
        }

        .register-headline {
            margin-bottom: 30px;
        }

        .register-headline h1 {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .register-headline h1 span {
            color: var(--primary);
        }

        .register-headline p {
            font-size: 1.1rem;
            color: var(--gray);
            margin-bottom: 0;
        }

        .register-form {
            max-width: 400px;
            margin: 0 auto;
            width: 100%;
        }

        .form-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-title h2 {
            font-size: 2rem;
            color: var(--secondary);
            margin-bottom: 10px;
        }

        .form-title p {
            color: var(--gray);
        }

        .form-floating {
            margin-bottom: 10px;
        }

        .form-floating label {
            color: var(--gray);
        }

        .form-control {
            border-radius: 10px;
            padding: 10px 15px;
            height: 40px;
            border: 1px solid #e1e5ea;
            background-color: #f9fafb;
            transition: all 0.3s ease;
            font-size: 0.8rem;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: var(--primary);
            background-color: white;
        }

        .form-check-label {
            color: var(--gray);
            font-size: 0.8rem;
        }

        .form-check-input:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .register-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .forgot-password {
            color: var(--primary);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s;
        }

        .forgot-password:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        .social-login {
            text-align: center;
            margin-top: 30px;
        }

        .social-login p {
            color: var(--gray);
            margin-bottom: 15px;
            position: relative;
        }

        .social-login p::before,
        .social-login p::after {
            content: "";
            position: absolute;
            top: 50%;
            width: 30%;
            height: 1px;
            background-color: #e1e5ea;
        }

        .social-login p::before {
            left: 0;
        }

        .social-login p::after {
            right: 0;
        }

        .social-icons {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .social-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f9fafb;
            border: 1px solid #e1e5ea;
            color: var(--gray);
            transition: all 0.3s;
        }

        .social-icon:hover {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
            color: var(--gray);
            font-size: 0.9rem;
        }

        .register-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }

        .register-link a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }
        /* Alert Styles */
        .alert {
            position: relative;
            padding: 0;
            margin-bottom: 20px;
            background: none;
            border: none;
            display: none; /* Hide by default */
        }

        .alert-content {
            display: flex;
            align-items: center;
            padding: 10px 15px;
        }

        .alert i {
            margin-right: 10px;
            margin-left: 15px;
            color: black; /* Default black color for icon */
            opacity: 0.5;
            display: none;
        }

        .alert::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background-color: black;
            opacity: 0.5;
        }

        /* Active Error State */
        .alert-danger {
            display: block;
        }

        .alert-danger .alert-content {
            color: #ff4b03;

            .alert-danger i {
                color: #ff4b03;
                opacity: 1;
            }

            .alert-danger::before {
                background-color: rgba(255, 75, 3, 0);
                opacity: 1;
            }

            /* Active Success State */
            .alert-success {
                display: block;
            }

            .alert-success .alert-content {
                color: #40ff00;
            }

            .alert-success i {
                color: #006e15; /* Blue icon for success */
                opacity: 1;
            }

            .alert-success::before {
                background-color: rgba(72, 253, 107, 0.79);
                opacity: 1;
            }
        @media (max-width: 991px) {
            .register-container {
                flex-direction: column;
                height: auto;
            }

            .register-left, .register-right {
                width: 100%;
                padding: 30px 20px;
            }

            .register-left {
                min-height: 300px;
            }

            .register-illustration {
                width: 300px;
                right: -5%;
                bottom: -15%;
            }

            .register-form {
                max-width: 100%;
            }
        }
        }
    </style>
</head>
<body>
<div class="register-container">
    <!-- Left side - Welcome and benefits -->
    <div class="register-left" data-aos="fade-right" data-aos-duration="1000">
        <div class="register-logo">
            <img src="../../../Assets/images/megacab-logo.svg" alt="MegaCab Logo">
            <span>Mega<em>Cab</em></span>
        </div>
        <div class="register-headline">
            <h1>Welcome to <span>MegaCab</span></h1>
            <p>Your premium ride service in Colombo</p>
        </div>
        <div class="login-benefits">
            <div class="benefit-item" data-aos="fade-up" data-aos-delay="100">
                <div class="benefit-icon">
                    <i class="fas fa-rocket"></i>
                </div>
                <div class="benefit-text">
                    <h5>Quick Booking</h5>
                    <p>Book your ride in seconds and be on your way</p>
                </div>
            </div>
            <div class="benefit-item" data-aos="fade-up" data-aos-delay="200">
                <div class="benefit-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <div class="benefit-text">
                    <h5>Safe & Secure</h5>
                    <p>Verified drivers and secure payment options</p>
                </div>
            </div>
            <div class="benefit-item" data-aos="fade-up" data-aos-delay="300">
                <div class="benefit-icon">
                    <i class="fas fa-award"></i>
                </div>
                <div class="benefit-text">
                    <h5>Premium Service</h5>
                    <p>Enjoy our luxury fleet and top-tier customer service</p>
                </div>
            </div>
        </div>
        <img src="/api/placeholder/500/300" alt="Cab Service Illustration" class="login-illustration">
    </div>

    <!-- Right side - Register form -->
    <div class="register-right" data-aos="fade-left" data-aos-duration="1000">
        <form action="register" method="post" class="register-form">
            <div class="form-title">
                <h2>Customer Registration</h2>
                <p>Sign up to book rides and enjoy MegaCab services</p>
            </div>


            <div class="form-floating">
                <input type="text" class="form-control" id="name" name="name" placeholder="Full Name" required>
                <label for="name"><i class="fas fa-user me-2"></i>Full Name</label>
            </div>
            <div class="form-floating">
                <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                <label for="email"><i class="fas fa-envelope me-2"></i>Email address</label>
            </div>
            <div class="form-floating">
                <input type="text" class="form-control" id="address" name="address" placeholder="Your Address" required>
                <label for="address"><i class="fas fa-map-marker-alt me-2"></i>Address</label>
            </div>
            <div class="form-floating">
                <input type="text" class="form-control" id="contact" name="contact" placeholder="Contact Number" required>
                <label for="contact"><i class="fas fa-phone me-2"></i>Contact Number</label>
            </div>
            <div class="form-floating">
                <input type="text" class="form-control" id="nic" name="nic" placeholder="NIC Number" required>
                <label for="nic"><i class="fas fa-id-card me-2"></i>NIC Number</label>
            </div>

            <div class="form-floating">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
                <label for="confirmPassword"><i class="fas fa-lock me-2"></i>Confirm Password</label>
            </div>
            <!-- Error Message -->
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${param.error}
                </div>
            </c:if>

            <!-- Success Message -->
            <c:if test="${not empty param.message}">
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${param.message}
                </div>
            </c:if>
            <button type="submit" class="btn btn-primary w-100">Register</button>

            <div class="register-link">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>
        </form>
    </div>
</div>

<!-- AOS Animation Library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
    // Initialize AOS animation
    AOS.init();
</script>
</body>
</html>
