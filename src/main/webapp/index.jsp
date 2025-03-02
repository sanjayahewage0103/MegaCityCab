<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab Service</title>
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
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
        }

        .navbar {
            background-color: #FFFFFF;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            color: var(--secondary) !important;
            display: flex;
            align-items: center;
        }

        .navbar-brand img {
            height: 40px;
            margin-right: 10px;
        }

        .navbar-brand span {
            color: var(--primary);
        }

        .nav-link {
            color: var(--secondary) !important;
            font-weight: 500;
            padding: 8px 15px !important;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-link:hover {
            color: var(--primary) !important;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            background: var(--primary);
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            transition: width 0.3s;
        }

        .nav-link:hover::after {
            width: 70%;
        }

        .btn-primary {
            background-color: var(--primary);
            border: none;
            color: white;
            font-weight: 600;
            padding: 10px 25px;
            border-radius: 50px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 107, 0, 0.3);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-outline {
            background-color: transparent;
            border: 2px solid var(--primary);
            color: var(--primary);
            font-weight: 600;
            padding: 9px 24px;
            border-radius: 50px;
            transition: all 0.3s ease;
        }

        .btn-outline:hover {
            background-color: var(--primary);
            color: white;
            transform: translateY(-2px);
        }

        .profile-dropdown {
            position: relative;
            display: inline-block;
        }

        .profile-dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            min-width: 200px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            z-index: 100;
            overflow: hidden;
        }

        .profile-dropdown-content a {
            color: var(--secondary);
            padding: 15px 20px;
            text-decoration: none;
            display: block;
            transition: all 0.2s ease;
            font-weight: 500;
        }

        .profile-dropdown-content a:hover {
            background-color: #f4f6f9;
            color: var(--primary);
            padding-left: 25px;
        }

        .profile-dropdown:hover .profile-dropdown-content {
            display: block;
            animation: fadeIn 0.3s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        #home {
            padding: 120px 0 80px;
            position: relative;
            overflow: hidden;
        }

        #home::before {
            content: "";
            position: absolute;
            top: 0;
            right: 0;
            width: 60%;
            height: 100%;
            background-color: #f9f4ef;
            border-bottom-left-radius: 100px;
            z-index: -1;
        }

        .hero-text h1 {
            font-size: 3.5rem;
            line-height: 1.2;
            margin-bottom: 20px;
        }

        .hero-text h1 span {
            color: var(--primary);
        }

        .hero-text p {
            font-size: 1.1rem;
            color: var(--gray);
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .hero-buttons {
            display: flex;
            gap: 15px;
        }

        .vehicle-img {
            max-height: 400px;
            width: 100%;
            object-fit: cover;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.5s ease;
        }

        .vehicle-img:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .section {
            padding: 80px 0;
            position: relative;
        }

        .section h2 {
            position: relative;
            display: inline-block;
            margin-bottom: 50px;
            font-size: 2.5rem;
        }

        .section h2::after {
            content: '';
            position: absolute;
            width: 70px;
            height: 3px;
            background: var(--primary);
            bottom: -10px;
            left: 0;
        }

        .text-center h2::after {
            left: 50%;
            transform: translateX(-50%);
        }

        .service-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            height: 100%;
        }

        .service-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .service-card img {
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .service-card h5 {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: var(--secondary);
        }

        .service-card p {
            color: var(--gray);
        }

        .contact-form {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.05);
        }

        .form-label {
            font-weight: 500;
            color: var(--secondary);
        }

        .form-control {
            padding: 12px 15px;
            border-radius: 10px;
            border: 1px solid #e1e5ea;
            background-color: #f9fafb;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: var(--primary);
            background-color: white;
        }

        .footer {
            background-color: var(--secondary);
            color: white;
            padding: 30px 0;
            position: relative;
        }

        .footer p {
            margin: 0;
            font-weight: 300;
        }

        .social-icons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
            justify-content: center;
        }

        .social-icons a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            color: white;
            transition: all 0.3s ease;
        }

        .social-icons a:hover {
            background-color: var(--primary);
            transform: translateY(-5px);
        }

        /* Responsive Adjustments */
        @media (max-width: 991px) {
            .hero-text h1 {
                font-size: 2.5rem;
            }

            #home::before {
                width: 100%;
                border-bottom-left-radius: 0;
            }
        }

        @media (max-width: 767px) {
            #home {
                padding: 100px 0 60px;
                text-align: center;
            }

            .hero-buttons {
                justify-content: center;
            }

            .section h2 {
                font-size: 2rem;
            }

            .section h2::after {
                left: 50%;
                transform: translateX(-50%);
            }

            .vehicle-img {
                margin-top: 40px;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="Assets/images/megacab-logo.svg" alt="MegaCab Logo" onerror="this.src='/api/placeholder/80/40'; this.onerror=null;">
            Mega<span>Cab</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav align-items-center">
                <li class="nav-item">
                    <a class="nav-link" href="#home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about">About Us</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#fleet">Our Fleet</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contact">Contact Us</a>
                </li>
                <li class="nav-item profile-dropdown ms-3">
                    <a class="btn btn-primary rounded-circle" href="#" style="width: 40px; height: 40px; padding: 0; display: flex; align-items: center; justify-content: center;">
                        <i class="fas fa-user"></i>
                    </a>
                    <div class="profile-dropdown-content">
                        <a href="login.jsp"><i class="fas fa-sign-in-alt me-2"></i>Login</a>
                        <a href="register.jsp"><i class="fas fa-user-plus me-2"></i>Sign Up</a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section id="home" class="container section">
    <div class="row align-items-center">
        <div class="col-lg-6" data-aos="fade-right" data-aos-duration="1000">
            <div class="hero-text">
                <h1>Your Ride, <span>Your Way</span></h1>
                <p>
                    Experience premium transportation with Mega City Cab – Colombo's most reliable and comfortable
                    ride service. Book in seconds, travel in style, and arrive refreshed.
                </p>
                <div class="hero-buttons">
                    <a href="login.jsp" class="btn btn-primary"><i class="fas fa-sign-in-alt me-2"></i>Login</a>
                    <a href="register.jsp" class="btn btn-outline"><i class="fas fa-user-plus me-2"></i>Sign Up</a>
                </div>
            </div>
        </div>
        <div class="col-lg-6" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="200">
            <img src="Assets/images/home.png" alt="Cab Service Illustration" class="vehicle-img"
                 onerror="this.src='/api/placeholder/400/300'; this.onerror=null;">
        </div>
    </div>
</section>

<!-- About Us Section -->
<section id="about" class="container section">
    <div class="row">
        <div class="col-lg-6" data-aos="fade-right" data-aos-duration="1000">
            <h2>About Us</h2>
            <p>
                Mega City Cab is a premium transportation provider in Colombo, revolutionizing the way
                people travel across the city. With our fleet of well-maintained vehicles and professional
                drivers, we ensure safe, comfortable, and timely journeys.
            </p>
            <p>
                Our tech-enabled platform allows you to book, track, and pay for rides with ease. We're
                committed to sustainability, customer satisfaction, and creating positive experiences for
                every passenger who chooses MegaCab.
            </p>
        </div>
        <div class="col-lg-6" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="200">
            <img src="Assets/images/about.png" alt="About Mega City Cab" class="vehicle-img"
                 onerror="this.src='/api/placeholder/400/300'; this.onerror=null;">
        </div>
    </div>
</section>

<!-- Our Fleet Section -->
<section id="fleet" class="container section">
    <h2 class="text-center">Our Premium Fleet</h2>
    <div class="row g-4">
        <div class="col-md-4" data-aos="fade-up" data-aos-duration="800">
            <div class="service-card text-center">
                <img src="Assets/images/sedan.png" alt="Sedan"
                     onerror="this.src='/api/placeholder/400/200'; this.onerror=null;">
                <h5>Premium Sedan</h5>
                <p>Luxurious and comfortable rides for up to 4 passengers with ample luggage space.</p>
            </div>
        </div>
        <div class="col-md-4" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
            <div class="service-card text-center">
                <img src="Assets/images/suv.png" alt="SUV"
                     onerror="this.src='/api/placeholder/400/200'; this.onerror=null;">
                <h5>Spacious SUV</h5>
                <p>Perfect for families or small groups seeking comfort and extra luggage capacity.</p>
            </div>
        </div>
        <div class="col-md-4" data-aos="fade-up" data-aos-duration="800" data-aos-delay="400">
            <div class="service-card text-center">
                <img src="Assets/images/van.png" alt="Van"
                     onerror="this.src='/api/placeholder/400/200'; this.onerror=null;">
                <h5>Luxury Van</h5>
                <p>Ideal for group travel, corporate outings, or airport transfers with ample space.</p>
            </div>
        </div>
    </div>
</section>

<!-- Contact Us Section -->
<section id="contact" class="container section">
    <h2 class="text-center">Get In Touch</h2>
    <div class="row justify-content-center">
        <div class="col-lg-8" data-aos="zoom-in" data-aos-duration="1000">
            <div class="contact-form">
                <form>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="name" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="name" placeholder="John Doe" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" placeholder="johndoe@example.com" required>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="mb-3">
                                <label for="subject" class="form-label">Subject</label>
                                <input type="text" class="form-control" id="subject" placeholder="How can we help you?">
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="mb-4">
                                <label for="message" class="form-label">Message</label>
                                <textarea class="form-control" id="message" rows="5" placeholder="Your message here..." required></textarea>
                            </div>
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-paper-plane me-2"></i>Send Message
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="text-center">
            <p>&copy; 2025 MegaCab. All rights reserved.</p>
            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS Animation Library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
    // Initialize AOS animation
    AOS.init();

    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.style.padding = '10px 0';
            navbar.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.1)';
        } else {
            navbar.style.padding = '15px 0';
            navbar.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.1)';
        }
    });
</script>
</body>
</html>