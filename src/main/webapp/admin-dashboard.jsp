<%--
  Created by IntelliJ IDEA.
  User: pethu
  Date: 3/5/2025
  Time: 11:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("admin") == null) {
        response.sendRedirect("admin-login.jsp?error=You must log in to access the admin dashboard.");
        return;
    }

    // Retrieve the admin username from the session
    String adminUsername = (String) session.getAttribute("admin");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - MegaCab</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Unicons for Dropdown Icons -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <!-- AOS Animation Library -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">
    <style>
        :root {
            /* Custom Color Palette */
            --primary: #FF4500;  /* Intense Orange-Red */
            --primary-dark: #C43E00;  /* Darker shade */
            --secondary: #2C3E50;
            --accent: #FF6347;  /* Tomato Red */

            /* Dark Mode Colors */
            --dark-bg: rgba(255, 255, 255, 0.9);
            --dark-sidebar: #262629;
            --dark-card: #2C2C2E;
            --dark-text: #E1E1E3;
            --dark-hover: #FF5733;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            scrollbar-width: thin;
            scrollbar-color: var(--primary) transparent;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--dark-bg);
            color: var(--dark-text);
            transition: all 0.3s ease;
            line-height: 1.6;
        }

        /* Scrollbar Styling */
        body::-webkit-scrollbar {
            width: 8px;
        }

        body::-webkit-scrollbar-track {
            background: transparent;
        }

        body::-webkit-scrollbar-thumb {
            background-color: var(--primary);
            border-radius: 20px;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 300px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background-color: var(--dark-sidebar);
            color: var(--dark-text);
            padding: 20px 0;
            z-index: 1000;
            overflow-y: auto;
            transition: all 0.3s ease;
            border-right: 2px solid var(--primary);
        }

        .sidebar-logo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 30px;
            padding: 0 20px;
        }

        .sidebar-logo img {
            height: 50px;
            margin-right: 15px;
        }

        .sidebar-logo span {
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--dark-text);
        }

        .sidebar-logo span em {
            color: var(--primary);
            font-style: normal;
        }

        /* Sidebar Menu Styles */
        .sidebar .accordion-item {
            background-color: transparent;
            border: none;
        }

        .sidebar .sidebar-toggle {
            width: 100%;
            text-align: left;
            color: var(--dark-text);
            background: none;
            border: none;
            padding: 12px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            border-radius: 0 20px 20px 0;
        }

        .sidebar .sidebar-toggle:hover {
            background-color: var(--dark-hover);
            color: var(--dark-bg);
        }

        .sidebar .sidebar-toggle i.menu-icon {
            margin-right: 15px;
            width: 25px;
            text-align: center;
            color: var(--primary);
        }

        .sidebar .sidebar-toggle i.dropdown-icon {
            transition: transform 0.3s ease;
            color: var(--primary);
        }

        .sidebar .sidebar-toggle.active i.dropdown-icon {
            transform: rotate(180deg);
        }

        .sidebar .accordion-body {
            padding: 0;
        }

        .sidebar .accordion-body a {
            display: block;
            color: var(--dark-text);
            padding: 10px 20px 10px 50px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }

        .sidebar .accordion-body a:hover {
            background-color: rgba(255,67,51,0.1);
            border-left-color: var(--primary);
            color: var(--primary);
        }

        .sidebar .accordion-body a i {
            margin-right: 12px;
            width: 20px;
            text-align: center;
            color: var(--accent);
        }

        /* Main Content Styles */
        .main-content {
            margin-left: 300px;
            padding: 30px;
            transition: all 0.3s ease;
        }

        .welcome-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .welcome-header h2 {
            color: var(--primary);
            font-weight: 700;
        }

        /* Card Styles */
        .card {
            background-color: var(--dark-card);
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .card-body {
            text-align: center;
            padding: 25px;
        }

        .card-body i {
            color: var(--primary);
            margin-bottom: 15px;
        }

        .card-title {
            color: var(--dark-text);
            font-weight: 600;
            margin-bottom: 10px;
        }

        .card-text {
            color: var(--accent);
            font-size: 1.5rem;
            font-weight: 700;
        }

        /* Quick Access Buttons */
        .quick-access-buttons .btn {
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 30px 15px;
            margin-bottom: 15px;
            font-weight: 700;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .quick-access-buttons .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(255,67,51,0.3);
        }

        /* Theme Toggle */
        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1100;
        }

        .theme-toggle input {
            display: none;
        }

        .theme-toggle label {
            cursor: pointer;
            background-color: var(--primary);
            color: white;
            padding: 10px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 15px rgba(255,67,51,0.3);
            transition: all 0.3s ease;
        }

        .theme-toggle label:hover {
            transform: rotate(180deg);
        }

        /* Responsive Design */
        @media (max-width: 991px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: static;
            }

            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-logo">
        <img src="Assets/images/megacab-logo.svg" alt="MegaCab Logo">
        <span>Mega<em>Cab</em></span>
    </div>
    <h6 class="text-center mb-4" style="color: var(--primary);">Admin Dashboard</h6>

    <div class="accordion" id="adminSidebar">
        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="sidebar-toggle" type="button" data-bs-toggle="collapse" data-bs-target="#bookingMenu">
                    <div>
                        <i class="fas fa-book menu-icon"></i> Booking
                    </div>
                    <i class="uil uil-angle-down dropdown-icon"></i>
                </button>
            </h2>
            <div id="bookingMenu" class="accordion-collapse collapse">
                <div class="accordion-body">
                    <a href="manage-bookings"><i class="fas fa-list"></i>Manage Booking</a>
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="sidebar-toggle" type="button" data-bs-toggle="collapse" data-bs-target="#vehicleMenu">
                    <div>
                        <i class="fas fa-car menu-icon"></i> Vehicle
                    </div>
                    <i class="uil uil-angle-down dropdown-icon"></i>
                </button>
            </h2>
            <div id="vehicleMenu" class="accordion-collapse collapse">
                <div class="accordion-body">
                    <a href="add-vehicle.jsp"><i class="fas fa-plus"></i>Add New Car</a>
                    <a href="view-edit-vehicle"><i class="fas fa-list"></i>Manage Cars</a>
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="sidebar-toggle" type="button" data-bs-toggle="collapse" data-bs-target="#driverMenu">
                    <div>
                        <i class="fas fa-user-tie menu-icon"></i> Driver
                    </div>
                    <i class="uil uil-angle-down dropdown-icon"></i>
                </button>
            </h2>
            <div id="driverMenu" class="accordion-collapse collapse">
                <div class="accordion-body">
                    <a href="add-driver.jsp"><i class="fas fa-user-plus"></i>Add New Driver</a>
                    <a href="manage-driver"><i class="fas fa-list"></i>Manage Driver</a>
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="sidebar-toggle" type="button" data-bs-toggle="collapse" data-bs-target="#customerMenu">
                    <div>
                        <i class="fas fa-users menu-icon"></i> Customer
                    </div>
                    <i class="uil uil-angle-down dropdown-icon"></i>
                </button>
            </h2>
            <div id="customerMenu" class="accordion-collapse collapse">
                <div class="accordion-body">
                    <a href="taxi-management"><i class="fas fa-list"></i>Manage Customer</a>
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="sidebar-toggle" type="button" data-bs-toggle="collapse" data-bs-target="#promoMenu">
                    <div>
                        <i class="fas fa-tags menu-icon"></i> Promotion
                    </div>
                    <i class="uil uil-angle-down dropdown-icon"></i>
                </button>
            </h2>
            <div id="promoMenu" class="accordion-collapse collapse">
                <div class="accordion-body">
                    <a href="promo-code-servlet"><i class="fas fa-percent"></i>Manage Promo Codes</a>
                    <a href="pricing-servlet"><i class="fas fa-ticket-alt"></i>Manage Tax & pay</a>
                    <a href="discount-servlet"><i class="fas fa-ticket-alt"></i>Manage Discounts</a>
                </div>
            </div>
        </div>

        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="sidebar-toggle" type="button" data-bs-toggle="collapse" data-bs-target="#billMenu">
                    <div>
                        <i class="fas fa-file-invoice-dollar menu-icon"></i> Bill Management
                    </div>
                    <i class="uil uil-angle-down dropdown-icon"></i>
                </button>
            </h2>
            <div id="billMenu" class="accordion-collapse collapse">
                <div class="accordion-body">
                    <a href="#"><i class="fas fa-credit-card"></i>All Payments</a>
                    <a href="#"><i class="fas fa-file-alt"></i>Manage Bill</a>
                    <a href="#"><i class="fas fa-hourglass-half"></i>Pending Payments</a>
                </div>
            </div>
        </div>
    </div>

    <div class="sidebar-footer mt-4 px-3">
        <a href="#" class="sidebar-toggle text-white text-decoration-none">
            <i class="fas fa-question-circle menu-icon"></i> FAQ
        </a>
        <a href="logout" class="sidebar-toggle text-white text-decoration-none mt-2">
            <i class="fas fa-sign-out-alt menu-icon"></i> Logout
        </a>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="welcome-header">
        <h2>Welcome, Admin! 👋</h2>
        <div class="d-flex align-items-center">
            <span class="me-2">🕒</span>
                <small id="current-time" style="color: var(--accent);"></small>
        </div>
    </div>

    <!-- Cards -->
    <div class="row">
        <div class="col-md-3" data-aos="fade-up" data-aos-delay="100">
            <div class="card">
                <div class="card-body">
                    <i class="fas fa-users fa-3x mb-3"></i>
                    <h5 class="card-title">Total Users</h5>
                    <p class="card-text">1,200</p>
                </div>
            </div>
        </div>
        <div class="col-md-3" data-aos="fade-up" data-aos-delay="200">
            <div class="card">
                <div class="card-body">
                    <i class="fas fa-car fa-3x mb-3"></i>
                    <h5 class="card-title">Total Vehicles</h5>
                    <p class="card-text">500</p>
                </div>
            </div>
        </div>
        <div class="col-md-3" data-aos="fade-up" data-aos-delay="300">
            <div class="card">
                <div class="card-body">
                    <i class="fas fa-user-tie fa-3x mb-3"></i>
                    <h5 class="card-title">Total Drivers</h5>
                    <p class="card-text">300</p>
                </div>
            </div>
        </div>
        <div class="col-md-3" data-aos="fade-up" data-aos-delay="400">
            <div class="card">
                <div class="card-body">
                    <i class="fas fa-dollar-sign fa-3x mb-3"></i>
                    <h5 class="card-title">Total Income</h5>
                    <p class="card-text">$50,000</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Access Buttons -->
    <div class="row quick-access-buttons">
        <div class="col-md-4">
            <a href="manage-vehicle" class="text-decoration-none" style="color: inherit;">
                <button class="btn w-100 mb-3">
                    <i class="fas fa-id-badge"></i> Vehicle
                </button>
            </a>
            <button class="btn w-100"><i class="fas fa-user-plus"></i>Add User</button>
        </div>
        <div class="col-md-4">
            <a href="driver-dashboard" class="text-decoration-none" style="color: inherit;">
                <button class="btn w-100 mb-3">
                    <i class="fas fa-id-badge"></i> Driver
                </button>
            </a>
            <a href="view-confirmed-bookings" class="text-decoration-none" style="color: inherit;">
                <button class="btn w-100 mb-3">
                    <i class="fas fa-id-badge"></i> booking
                </button>
            </a>
        </div>
        <div class="col-md-4">
            <button class="btn w-100 mb-3"><i class="fas fa-file-invoice-dollar"></i>Bill Payment</button>
            <button class="btn w-100"><i class="fas fa-percent"></i>Apply Discount</button>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS Animation Library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
    // Initialize AOS
    AOS.init();

    // Current Time Display
    function updateTime() {
        const now = new Date();
        document.getElementById('current-time').textContent = now.toLocaleString('en-US', {
            hour: '2-digit',
            minute: '2-digit',
            hour12: true,
            day: '2-digit',
            month: 'short',
            year: 'numeric'
        });
    }
    updateTime();
    setInterval(updateTime, 1000);

    // Theme Toggle
    const themeSwitch = document.getElementById('theme-switch');
    const body = document.body;

    // Check for saved theme preference or default to dark mode
    const savedTheme = localStorage.getItem('megacab-theme');
    if (savedTheme === 'dark' || savedTheme === null) {
        body.classList.add('dark-mode');
        themeSwitch.checked = true;
    }

    themeSwitch.addEventListener('change', () => {
        body.classList.toggle('dark-mode');

        // Save theme preference
        if (body.classList.contains('dark-mode')) {
            localStorage.setItem('megacab-theme', 'dark');
        } else {
            localStorage.setItem('megacab-theme', 'light');
        }
    });

    // Sidebar Dropdown Handling
    const sidebarToggles = document.querySelectorAll('.sidebar-toggle');
    sidebarToggles.forEach(toggle => {
        toggle.addEventListener('click', (e) => {
            // Get the target dropdown
            const targetId = toggle.getAttribute('data-bs-target');
            const dropdown = targetId ? document.querySelector(targetId) : null;

            // Toggle active state
            toggle.classList.toggle('active');

            // Close other open dropdowns
            sidebarToggles.forEach(otherToggle => {
                if (otherToggle !== toggle) {
                    otherToggle.classList.remove('active');
                    const otherTargetId = otherToggle.getAttribute('data-bs-target');
                    if (otherTargetId) {
                        const otherDropdown = document.querySelector(otherTargetId);
                        if (otherDropdown) {
                            otherDropdown.classList.remove('show');
                        }
                    }
                }
            });

            // Toggle current dropdown
            if (dropdown) {
                dropdown.classList.toggle('show');
            }
        });
    });

    // Responsive Sidebar for Mobile
    function handleSidebarResponsiveness() {
        const sidebar = document.querySelector('.sidebar');
        const mainContent = document.querySelector('.main-content');

        if (window.innerWidth <= 991) {
            sidebar.classList.add('mobile-sidebar');
            mainContent.style.marginLeft = '0';
        } else {
            sidebar.classList.remove('mobile-sidebar');
            mainContent.style.marginLeft = '260px';
        }
    }

    // Initial check and add event listener
    handleSidebarResponsiveness();
    window.addEventListener('resize', handleSidebarResponsiveness);
</script>
</body>
</html>