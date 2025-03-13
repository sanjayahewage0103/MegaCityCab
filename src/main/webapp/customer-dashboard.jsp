<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - MegaCab</title>
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
            --sidebar-width: 280px;
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

        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: var(--sidebar-width);
            background-color: white;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            transition: all 0.3s ease;
            overflow-y: auto;
        }

        .sidebar-header {
            padding: 20px;
            display: flex;
            align-items: center;
            border-bottom: 1px solid var(--light-gray);
        }

        .sidebar-header img {
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

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-item {
            padding: 0;
            list-style: none;
        }

        .menu-item a {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: var(--secondary);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }

        .menu-item a:hover, .menu-item a.active {
            background-color: rgba(255, 107, 0, 0.05);
            color: var(--primary);
            border-left-color: var(--primary);
        }

        .menu-item i {
            font-size: 1.2rem;
            margin-right: 15px;
            width: 20px;
            text-align: center;
        }

        .menu-label {
            font-size: 0.8rem;
            text-transform: uppercase;
            color: var(--gray);
            font-weight: 600;
            padding: 10px 20px;
            margin-top: 15px;
        }

        /* Main Content Area */
        .main-content {
            margin-left: var(--sidebar-width);
            transition: all 0.3s ease;
            min-height: 100vh;
            padding-bottom: 60px; /* Space for footer */
        }

        /* Header */
        .main-header {
            background-color: white;
            height: var(--header-height);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .toggle-sidebar {
            font-size: 1.5rem;
            color: var(--secondary);
            cursor: pointer;
            display: none;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .notification-icon {
            position: relative;
            color: var(--secondary);
            font-size: 1.2rem;
            cursor: pointer;
        }

        .notification-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background-color: var(--primary);
            color: white;
            font-size: 0.7rem;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        .user-dropdown {
            position: relative;
            cursor: pointer;
        }

        .user-dropdown-toggle {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 1.2rem;
        }

        .user-info {
            display: none;
        }

        .user-dropdown-content {
            position: absolute;
            top: 100%;
            right: 0;
            background-color: white;
            width: 200px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            padding: 10px 0;
            display: none;
            z-index: 1000;
        }

        .user-dropdown-content a {
            display: block;
            padding: 10px 20px;
            color: var(--secondary);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .user-dropdown-content a:hover {
            background-color: rgba(255, 107, 0, 0.05);
            color: var(--primary);
        }

        .user-dropdown:hover .user-dropdown-content {
            display: block;
            animation: fadeIn 0.3s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Dashboard Content */
        .dashboard-content {
            padding: 25px;
        }

        .page-title {
            margin-bottom: 25px;
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

        .stats-card {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 20px;
            height: 100%;
            transition: all 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .stats-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            border-radius: 10px;
            margin-bottom: 15px;
            font-size: 1.5rem;
            color: white;
        }

        .bg-orange {
            background-color: var(--primary);
        }

        .bg-blue {
            background-color: #3498db;
        }

        .bg-green {
            background-color: #2ecc71;
        }

        .bg-purple {
            background-color: #9b59b6;
        }

        .stats-number {
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0;
            color: var(--secondary);
        }

        .stats-text {
            color: var(--gray);
            margin: 5px 0 0;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            margin-bottom: 25px;
        }

        .card:hover {
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: white;
            border-bottom: 1px solid var(--light-gray);
            padding: 20px;
            border-radius: 15px 15px 0 0 !important;
        }

        .card-title {
            margin: 0;
            color: var(--secondary);
            font-size: 1.2rem;
        }

        .card-body {
            padding: 20px;
        }

        .table th {
            font-weight: 600;
            color: var(--secondary);
            border-bottom-width: 1px;
        }

        .table td {
            vertical-align: middle;
        }

        .btn-primary {
            background-color: var(--primary);
            border: none;
            padding: 8px 15px;
            font-weight: 500;
            border-radius: 8px;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        .ride-status {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-completed {
            background-color: rgba(46, 204, 113, 0.15);
            color: #2ecc71;
        }

        .status-ongoing {
            background-color: rgba(52, 152, 219, 0.15);
            color: #3498db;
        }

        .status-cancelled {
            background-color: rgba(231, 76, 60, 0.15);
            color: #e74c3c;
        }

        .status-scheduled {
            background-color: rgba(155, 89, 182, 0.15);
            color: #9b59b6;
        }

        /* Footer */
        .footer {
            position: absolute;
            bottom: 0;
            right: 0;
            left: var(--sidebar-width);
            padding: 15px 25px;
            background-color: white;
            text-align: center;
            border-top: 1px solid var(--light-gray);
            transition: all 0.3s ease;
        }

        /* Responsive */
        @media (max-width: 991px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .main-content {
                margin-left: 0;
            }

            .footer {
                left: 0;
            }

            .toggle-sidebar {
                display: block;
            }

            .sidebar.show {
                transform: translateX(0);
            }

            .user-info {
                display: block;
            }
        }

        @media (min-width: 992px) {
            .header-username {
                display: block;
            }
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
    // For demonstration, we'll add more mock user information
    String firstName = "John"; // In real app, get from session or DB
    String lastName = "Doe"; // In real app, get from session or DB
    String userInitial = firstName.substring(0, 1);
%>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <img src="Assets/images/megacab-logo.svg" alt="MegaCab Logo" onerror="this.src='/api/placeholder/70/35'; this.onerror=null;">
        <h2 class="brand-text">Mega<span>Cab</span></h2>
    </div>
    <div class="sidebar-menu">
        <ul class="menu-item">
            <li class="menu-item">
                <a href="customer-dashboard.jsp" class="active">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li class="menu-item">
                <a href="make-booking.jsp">
                    <i class="fas fa-taxi"></i> Book a Ride
                </a>
            </li>
            <li class="menu-item">
                <a href="customer-booking-manage">
                    <i class="fas fa-history"></i> My Rides
                </a>
            </li>
            <li class="menu-item">
                <a href="make-payment">
                    <i class="fas fa-credit-card"></i> Payments
                </a>
            </li>
            <li class="menu-label">Account</li>
            <li class="menu-item">
                <a href="customer-profile.jsp">
                    <i class="fas fa-user"></i> Profile
                </a>
            </li>
            <li class="menu-item">
                <a href="help.jsp">
                    <i class="fas fa-question-circle"></i> Help & Support
                </a>
            </li>
            <li class="menu-item">
                <a href="logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </li>
        </ul>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Header -->
    <div class="main-header">
        <div class="toggle-sidebar" id="toggleSidebar">
            <i class="fas fa-bars"></i>
        </div>
        <div class="header-right">
            <div class="notification-icon">
                <i class="fas fa-bell"></i>
                <span class="notification-badge">3</span>
            </div>
            <div class="user-dropdown">
                <div class="user-dropdown-toggle">
                    <div class="avatar"><%= userInitial %></div>
                    <div class="user-info d-none d-md-block">
                        <div class="header-username"><%= firstName %> <%= lastName %></div>
                    </div>
                </div>
                <div class="user-dropdown-content">
                    <a href="customer-profile.jsp"><i class="fas fa-user-circle me-2"></i> Profile</a>
                    <a href="settings.jsp"><i class="fas fa-cog me-2"></i> Settings</a>
                    <a href="logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Dashboard Content -->
    <div class="dashboard-content">
        <div class="page-title">
            <h1>Welcome back, <%= firstName %>!</h1>
            <p>Here's what's happening with your account today.</p>
        </div>

        <!-- Stats Cards -->
        <div class="row g-4 mb-4">
            <div class="col-md-6 col-lg-3">
                <div class="stats-card">
                    <div class="stats-icon bg-orange">
                        <i class="fas fa-taxi"></i>
                    </div>
                    <h3 class="stats-number">12</h3>
                    <p class="stats-text">Total Rides</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="stats-card">
                    <div class="stats-icon bg-blue">
                        <i class="fas fa-route"></i>
                    </div>
                    <h3 class="stats-number">186</h3>
                    <p class="stats-text">Total Distance (km)</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="stats-card">
                    <div class="stats-icon bg-green">
                        <i class="fas fa-wallet"></i>
                    </div>
                    <h3 class="stats-number">₨3,540</h3>
                    <p class="stats-text">Saved with Promos</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="stats-card">
                    <div class="stats-icon bg-purple">
                        <i class="fas fa-star"></i>
                    </div>
                    <h3 class="stats-number">4.9</h3>
                    <p class="stats-text">Average Rating</p>
                </div>
            </div>
        </div>

        <!-- Recent Rides -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="card-title">Recent Rides</h5>
                <a href="booking-activity.jsp" class="btn btn-primary btn-sm">View All</a>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Date</th>
                            <th>From</th>
                            <th>To</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>12 Mar, 2025</td>
                            <td>Colombo Fort</td>
                            <td>Galle Face Green</td>
                            <td>₨650</td>
                            <td><span class="ride-status status-completed">Completed</span></td>
                            <td><a href="#" class="btn btn-sm btn-outline-primary">Details</a></td>
                        </tr>
                        <tr>
                            <td>10 Mar, 2025</td>
                            <td>Negombo</td>
                            <td>Bandaranaike Airport</td>
                            <td>₨2,450</td>
                            <td><span class="ride-status status-completed">Completed</span></td>
                            <td><a href="#" class="btn btn-sm btn-outline-primary">Details</a></td>
                        </tr>
                        <tr>
                            <td>08 Mar, 2025</td>
                            <td>Galle Face Hotel</td>
                            <td>Dutch Hospital Shopping Precinct</td>
                            <td>₨720</td>
                            <td><span class="ride-status status-cancelled">Cancelled</span></td>
                            <td><a href="#" class="btn btn-sm btn-outline-primary">Details</a></td>
                        </tr>
                        <tr>
                            <td>15 Mar, 2025</td>
                            <td>Cinnamon Grand</td>
                            <td>National Museum</td>
                            <td>₨850</td>
                            <td><span class="ride-status status-scheduled">Scheduled</span></td>
                            <td><a href="#" class="btn btn-sm btn-outline-primary">Details</a></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Quick Actions and Special Offers Row -->
        <div class="row">
            <!-- Quick Actions Card -->
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-6">
                                <a href="make-booking.jsp" class="btn btn-primary w-100 py-3">
                                    <i class="fas fa-taxi me-2"></i> Book Now
                                </a>
                            </div>
                            <div class="col-6">
                                <a href="schedule.jsp" class="btn btn-outline-primary w-100 py-3">
                                    <i class="fas fa-calendar-alt me-2"></i> Schedule
                                </a>
                            </div>
                            <div class="col-6">
                                <a href="track.jsp" class="btn btn-outline-primary w-100 py-3">
                                    <i class="fas fa-map-marked-alt me-2"></i> Track Ride
                                </a>
                            </div>
                            <div class="col-6">
                                <a href="support.jsp" class="btn btn-outline-primary w-100 py-3">
                                    <i class="fas fa-headset me-2"></i> Support
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Special Offers Card -->
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Special Offers</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex align-items-center p-3 mb-3 bg-light rounded">
                            <div class="flex-shrink-0 me-3">
                                <i class="fas fa-gift text-primary fa-2x"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Weekend Special: 20% Off</h6>
                                <p class="mb-0 small">Use code WEEKEND20 for 20% off on all weekend rides.</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center p-3 bg-light rounded">
                            <div class="flex-shrink-0 me-3">
                                <i class="fas fa-percentage text-primary fa-2x"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Airport Transfer Discount</h6>
                                <p class="mb-0 small">Book an airport transfer and get 15% off with code AIRPORT15.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 MegaCab. All rights reserved.</p>
    </div>
</div>

<!-- Bootstrap JS and Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle Sidebar
    document.getElementById('toggleSidebar').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('show');
    });

    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', function(event) {
        const sidebar = document.getElementById('sidebar');
        const toggleBtn = document.getElementById('toggleSidebar');

        if (window.innerWidth < 992) {
            if (sidebar.classList.contains('show') &&
                !sidebar.contains(event.target) &&
                !toggleBtn.contains(event.target)) {
                sidebar.classList.remove('show');
            }
        }
    });
</script>
</body>
</html>