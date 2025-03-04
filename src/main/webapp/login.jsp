<%--
  Created by IntelliJ IDEA.
  User: pethu
  Date: 3/2/2025
  Time: 9:43 AM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegaCab - Login</title>
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

        .login-container {
            height: 100vh;
            max-width: 100vw;
            display: flex;
            overflow: hidden;
        }

        .login-left {
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

        .login-left::after {
            content: "";
            position: absolute;
            right: -100px;
            top: 0;
            width: 200px;
            height: 100%;
            background: linear-gradient(90deg, rgba(249, 244, 239, 1) 0%, rgba(249, 244, 239, 0) 100%);
            z-index: 1;
        }

        .login-right {
            flex: 1;
            background-color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 40px;
            box-shadow: -5px 0 30px rgba(0, 0, 0, 0.05);
        }

        .login-logo {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }

        .login-logo img {
            height: 50px;
            margin-right: 10px;
        }

        .login-logo span {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 1.8rem;
            color: var(--secondary);
        }

        .login-logo span em {
            color: var(--primary);
            font-style: normal;
        }

        .login-headline {
            margin-bottom: 30px;
        }

        .login-headline h1 {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .login-headline h1 span {
            color: var(--primary);
        }

        .login-headline p {
            font-size: 1.1rem;
            color: var(--gray);
            margin-bottom: 0;
        }

        .login-benefits {
            margin-top: 40px;
        }

        .benefit-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .benefit-icon {
            width: 50px;
            height: 50px;
            background-color: rgba(255, 107, 0, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: var(--primary);
            font-size: 1.5rem;
        }

        .benefit-text h5 {
            margin-bottom: 5px;
            font-size: 1.1rem;
        }

        .benefit-text p {
            margin-bottom: 0;
            color: var(--gray);
            font-size: 0.9rem;
        }

        .login-illustration {
            position: absolute;
            bottom: -10%;
            right: -10%;
            width: 500px;
            opacity: 0.5;
            z-index: 0;
        }

        .login-form {
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
            margin-bottom: 20px;
        }

        .form-floating label {
            color: var(--gray);
        }

        .form-control {
            border-radius: 10px;
            padding: 15px 20px;
            height: 60px;
            border: 1px solid #e1e5ea;
            background-color: #f9fafb;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: var(--primary);
            background-color: white;
        }

        .form-check-label {
            color: var(--gray);
            font-size: 0.9rem;
        }

        .form-check-input:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .login-options {
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
            .login-container {
                flex-direction: column;
                height: auto;
            }

            .login-left, .login-right {
                width: 100%;
                padding: 30px 20px;
            }

            .login-left {
                min-height: 300px;
            }

            .login-illustration {
                width: 300px;
                right: -5%;
                bottom: -15%;
            }

            .login-form {
                max-width: 100%;
            }
        }
        }
    </style>
</head>
<body>
<div class="login-container">
    <!-- Left side - Welcome and benefits -->
    <div class="login-left" data-aos="fade-right" data-aos-duration="1000">
        <div class="login-logo">
            <img src="Assets/images/megacab-logo.svg" alt="MegaCab Logo">
            <span>Mega<em>Cab</em></span>
        </div>
        <div class="login-headline">
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
        <img src="Assets/images/sedan.png" alt="Cab Service Illustration" class="login-illustration">
    </div>

    <!-- Right side - Login form -->
    <div class="login-right" data-aos="fade-left" data-aos-duration="1000">
        <form action="login" method="post" class="login-form">
            <div class="form-title">
                <h2>Login</h2>
                <p>Access your account to book rides and manage your trips</p>
            </div>


            <div class="form-floating">
                <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                <label for="email"><i class="fas fa-envelope me-2"></i>Email address</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
            </div>
            <div class="login-options">
<%--                <div class="form-check">--%>
<%--                    <input class="form-check-input" type="checkbox" value="" id="rememberMe">--%>
<%--                    <label class="form-check-label" for="rememberMe">--%>
<%--                        Remember me--%>
<%--                    </label>--%>
<%--                </div>--%>

                <!-- Error Message -->
                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger show">
                        <div class="alert-content">
                            <i class="fas fa-exclamation-circle"></i>${param.error}
                        </div>
                    </div>
                </c:if>
                <a href="#" class="forgot-password">Forgot password?</a>
            </div>
            <button type="submit" class="btn btn-primary w-100">
                <i class="fas fa-sign-in-alt me-2"></i>Login
            </button>



            <!-- Success Message -->
            <c:if test="${not empty param.message}">
                <div class="alert alert-success show">
                    <div class="alert-content">
                        <i class="fas fa-check-circle"></i>${param.message}
                    </div>
                </div>
            </c:if>

            <div class="social-login">
                <p>Or login with</p>
                <div class="social-icons">
                    <a href="#" class="social-icon"><i class="fab fa-google"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-apple"></i></a>
                </div>
            </div>

            <div class="register-link">
                Don't have an account? <a href="register.jsp">Register now</a>
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