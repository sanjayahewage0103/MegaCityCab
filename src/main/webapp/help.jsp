<%--
  Created by IntelliJ IDEA.
  User: pethu
  Date: 3/5/2025
  Time: 11:29 AM
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
  <title>Help - MegaCab Admin Dashboard</title>
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
    .help-section {
      margin-bottom: 40px;
    }
    .help-section h3 {
      color: #FF4500;
      border-bottom: 2px solid #FF4500;
      padding-bottom: 10px;
    }
    .help-section ul {
      list-style-type: disc;
      margin-left: 20px;
    }
    .help-section code {
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
  </style>
</head>
<body>
<div class="container mt-5">
  <h1 class="mb-4">Welcome to the MegaCab Admin Dashboard User Manual</h1>

  <!-- Overview Section -->
  <div class="help-section">
    <h3>Overview</h3>
    <p>
      The MegaCab Admin Dashboard is designed to streamline operations for managing customer bookings,
      vehicles, drivers, promotions, and billing. This guide will walk you through the key features and how to use them effectively.
    </p>
  </div>

  <!-- Login Section -->
  <div class="help-section">
    <h3>Login</h3>
    <p>
      To access the admin dashboard, you must log in with valid credentials:
    </p>
    <ul>
      <li>Navigate to the <code>/admin-login.jsp</code> page.</li>
      <li>Enter your email and password.</li>
      <li>Click the "Login" button.</li>
    </ul>
    <p>
      If you are not logged in, you will be redirected to the login page automatically.
    </p>
  </div>

  <!-- Sidebar Navigation -->
  <div class="help-section">
    <h3>Sidebar Navigation</h3>
    <p>
      The sidebar provides quick access to different sections of the dashboard:
    </p>
    <ul>
      <li><strong>Booking:</strong> Manage customer bookings and view details.</li>
      <li><strong>Vehicle:</strong> Add new cars or manage existing vehicles.</li>
      <li><strong>Driver:</strong> Add new drivers or manage existing driver details.</li>
      <li><strong>Customer:</strong> View and manage customer information.</li>
      <li><strong>Promotion:</strong> Manage coupons and promo codes.</li>
      <li><strong>Bill Management:</strong> View all payments, manage bills, and track pending payments.</li>
    </ul>
    <p>
      Click on any menu item to expand it and access sub-options.
    </p>
  </div>

  <!-- Dashboard Cards -->
  <div class="help-section">
    <h3>Dashboard Cards</h3>
    <p>
      The dashboard displays key statistics in card format:
    </p>
    <ul>
      <li><strong>Total Users:</strong> Number of registered users in the system.</li>
      <li><strong>Total Vehicles:</strong> Total number of vehicles managed by the system.</li>
      <li><strong>Total Drivers:</strong> Total number of drivers registered in the system.</li>
      <li><strong>Total Income:</strong> Total income generated from completed bookings.</li>
    </ul>
    <p>
      These cards provide an overview of the system's performance at a glance.
    </p>
  </div>

  <!-- Quick Access Buttons -->
  <div class="help-section">
    <h3>Quick Access Buttons</h3>
    <p>
      Use the quick access buttons to perform common tasks:
    </p>
    <ul>
      <li><strong>Add Vehicle:</strong> Add a new vehicle to the system.</li>
      <li><strong>Add User:</strong> Register a new user or admin account.</li>
      <li><strong>Driver Dashboard:</strong> View driver-specific details and manage drivers.</li>
      <li><strong>Book Ride:</strong> Create a new booking manually.</li>
      <li><strong>Bill Payment:</strong> Process bill payments for customers.</li>
      <li><strong>Apply Discount:</strong> Apply discounts or promo codes to bookings.</li>
    </ul>
  </div>

  <!-- Logout -->
  <div class="help-section">
    <h3>Logout</h3>
    <p>
      To log out of the system:
    </p>
    <ul>
      <li>Click the <strong>Logout</strong> option in the sidebar footer.</li>
      <li>You will be redirected to the login page.</li>
    </ul>
  </div>

  <!-- Back to Dashboard -->
  <a href="admin-dashboard.jsp" class="back-to-dashboard"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>