<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
  <title>Add New Driver - MegaCab</title>
  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome Icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
      font-family: 'Inter', sans-serif;
    }

    body {
      background-color: var(--dark-bg);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }

    .container {
      width: 90%;
      height: 90%;
      display: flex;
      border-radius: 15px;
      overflow: hidden;
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    }

    .left-container {
      width: 30%;
      background-color: var(--dark-sidebar);
      padding: 40px 20px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      position: relative;
      overflow: hidden;
    }

    .logo-container {
      text-align: center;
      margin-bottom: 30px;
    }

    .logo-container img {
      height: 60px;
      margin-bottom: 15px;
    }

    .logo-container h2 {
      color: var(--dark-text);
      font-weight: 700;
      font-size: 1.8rem;
    }

    .logo-container h2 em {
      color: var(--primary);
      font-style: normal;
    }

    .driver-illustration {
      position: relative;
      width: 100%;
      height: 200px;
      margin-top: auto;
      overflow: hidden;
      display: flex;
      justify-content: center;
      align-items: flex-end;
    }

    .driver-illustration img {
      width: 80%;
      max-height: 90%;
      object-fit: contain;
      position: relative;
      z-index: 2;
    }

    .driver-illustration::before {
      content: "";
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: radial-gradient(circle at center bottom, var(--primary-dark) 0%, transparent 70%);
      opacity: 0.3;
      z-index: 1;
    }

    .right-container {
      width: 70%;
      background-color: white;
      padding: 40px;
      position: relative;
    }

    .page-title {
      display: flex;
      align-items: center;
      margin-bottom: 30px;
    }

    .page-title h1 {
      color: var(--secondary);
      font-weight: 700;
      font-size: 2rem;
      margin: 0;
    }

    .page-title i {
      color: var(--primary);
      font-size: 2rem;
      margin-right: 15px;
    }

    .message-container {
      margin-bottom: 20px;
    }

    .error {
      background-color: rgba(255, 69, 0, 0.1);
      color: #d9534f;
      padding: 10px 15px;
      border-radius: 5px;
      font-weight: 500;
    }

    .success {
      background-color: rgba(40, 167, 69, 0.1);
      color: #28a745;
      padding: 10px 15px;
      border-radius: 5px;
      font-weight: 500;
    }

    .form-container {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 10px;
    }

    .form-group {
      margin-bottom: 10px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: var(--secondary);
      font-weight: 500;
    }

    .input-group {
      position: relative;
    }

    .input-group i {
      position: absolute;
      left: 12px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--primary);
    }

    .form-control {
      width: 100%;
      padding: 12px 12px 12px 40px;
      border: 1px solid #e0e0e0;
      border-radius: 8px;
      transition: all 0.3s ease;
    }

    .form-control:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(255, 69, 0, 0.2);
      outline: none;
    }

    .form-control::placeholder {
      color: #bbb;
    }

    .form-textarea {
      padding-left: 12px;
      min-height: 100px;
      resize: none;
    }

    .form-select {
      width: 100%;
      padding: 12px 12px 12px 40px;
      border: 1px solid #e0e0e0;
      border-radius: 8px;
      background-color: white;
      transition: all 0.3s ease;
      appearance: none;
      -webkit-appearance: none;
      cursor: pointer;
    }

    .form-select:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(255, 69, 0, 0.2);
      outline: none;
    }

    .select-container {
      position: relative;
    }

    .select-container::after {
      content: "\f107";
      font-family: "Font Awesome 5 Free";
      font-weight: 900;
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--primary);
      pointer-events: none;
    }

    .form-group.full-width {
      /*grid-column: span 2;*/
    }

    .button-container {
      grid-column: span 2;
      display: flex;
      justify-content: space-between;
      margin-top: 10px;
    }

    .btn {
      padding: 12px 25px;
      border-radius: 30px;
      font-weight: 600;
      transition: all 0.3s ease;
      border: none;
      cursor: pointer;
    }

    .btn-primary {
      background-color: var(--primary);
      color: white;
    }

    .btn-primary:hover {
      background-color: var(--primary-dark);
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(255, 69, 0, 0.3);
    }

    .btn-secondary {
      background-color: transparent;
      color: var(--secondary);
      border: 1px solid var(--secondary);
    }

    .btn-secondary:hover {
      background-color: var(--secondary);
      color: white;
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(44, 62, 80, 0.3);
    }

    .btn i {
      margin-right: 8px;
    }

    /* Animation */
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .animated {
      animation: fadeIn 0.5s ease forwards;
    }

    .delay-1 {
      animation-delay: 0.1s;
    }

    .delay-2 {
      animation-delay: 0.2s;
    }

    .delay-3 {
      animation-delay: 0.3s;
    }

    /* Responsive */
    @media (max-width: 992px) {
      .container {
        flex-direction: column;
        height: auto;
      }

      .left-container {
        width: 100%;
        padding: 30px 20px;
      }

      .right-container {
        width: 100%;
      }

      .driver-illustration {
        height: 200px;
      }

      .form-container {
        grid-template-columns: 1fr;
      }

      .form-group.full-width {
        grid-column: span 1;
      }

      .button-container {
        grid-column: span 1;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <!-- Left Side -->
  <div class="left-container">
    <div class="logo-container animated">
      <img src="Assets/images/megacab-logo.svg" alt="MegaCab Logo">
      <h2>Mega<em>Cab</em></h2>
      <p style="color: var(--dark-text); margin-top: 10px;">Admin Dashboard</p>
    </div>

    <div class="driver-details animated delay-1" style="color: var(--dark-text); text-align: center; margin-top: 20px;">
      <h3 style="color: var(--primary); margin-bottom: 15px;">Our Drivers</h3>
      <p>Professional, courteous, and safe drivers are the backbone of our service.</p>
      <div style="margin: 20px 0; text-align: left; padding-left: 20px;">
        <p><i class="fas fa-check" style="color: var(--primary); margin-right: 10px;"></i> Verified backgrounds</p>
        <p><i class="fas fa-check" style="color: var(--primary); margin-right: 10px;"></i> Customer-focused service</p>
        <p><i class="fas fa-check" style="color: var(--primary); margin-right: 10px;"></i> Safe driving records</p>
      </div>
    </div>

    <%--    <div class="driver-illustration animated delay-2">--%>
    <%--      <!-- Placeholder for driver illustration -->--%>
    <%--&lt;%&ndash;      <img src="/api/placeholder/300/300" alt="Driver Illustration">&ndash;%&gt;--%>
    <%--    </div>--%>
  </div>

  <!-- Right Side -->
  <div class="right-container">
    <div class="page-title animated">
      <i class="fas fa-user-plus"></i>
      <h1>Add New Driver</h1>
    </div>

    <!-- Display Error or Success Message -->
    <div class="message-container animated delay-1">
      <% if (request.getAttribute("error") != null) { %>
      <div class="error">
        <i class="fas fa-exclamation-circle"></i>
        <%= request.getAttribute("error") %>
      </div>
      <% } %>

      <% if (request.getAttribute("message") != null) { %>
      <div class="success">
        <i class="fas fa-check-circle"></i>
        <%= request.getAttribute("message") %>
      </div>
      <% } %>
    </div>

    <!-- Form -->
    <form method="post" action="add-driver" class="animated delay-2">
      <div class="form-container">
        <div class="form-group">
          <label for="firstName">First Name</label>
          <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" id="firstName" name="firstName" class="form-control" placeholder="Enter first name" required>
          </div>
        </div>

        <div class="form-group">
          <label for="lastName">Last Name</label>
          <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" id="lastName" name="lastName" class="form-control" placeholder="Enter last name" required>
          </div>
        </div>

        <div class="form-group">
          <label for="phoneNumber">Phone Number</label>
          <div class="input-group">
            <i class="fas fa-phone"></i>
            <input type="tel" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="Enter phone number" required>
          </div>
        </div>

        <div class="form-group">
          <label for="email">Email</label>
          <div class="input-group">
            <i class="fas fa-envelope"></i>
            <input type="email" id="email" name="email" class="form-control" placeholder="Enter email address">
          </div>
        </div>

        <div class="form-group">
          <label for="nic">NIC</label>
          <div class="input-group">
            <i class="fas fa-id-card"></i>
            <input type="text" id="nic" name="nic" class="form-control" placeholder="Enter NIC number" required>
          </div>
        </div>

        <div class="form-group">
          <label for="licenseNumber">License Number</label>
          <div class="input-group">
            <i class="fas fa-id-badge"></i>
            <input type="text" id="licenseNumber" name="licenseNumber" class="form-control" placeholder="Enter license number" required>
          </div>
        </div>

        <div class="form-group full-width">
          <label for="address">Address</label>
          <div class="input-group">
            <textarea id="address" name="address" class="form-control form-textarea" placeholder="Enter full address" rows="3"></textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="status">Status</label>
          <div class="input-group select-container">
            <i class="fas fa-toggle-on"></i>
            <select id="status" name="status" class="form-select" required>
              <option value="" disabled selected>Select status</option>
              <option value="active">Active</option>
              <option value="inactive">Inactive</option>
            </select>
          </div>
        </div>


        <div class="button-container animated delay-3">
          <a href="admin-dashboard.jsp" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
          </a>
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Add Driver
          </button>
        </div>
      </div>
    </form>
  </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS Animation Library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
  // Initialize AOS
  AOS.init();

  // Form validation and animations
  document.addEventListener('DOMContentLoaded', function() {
    const formInputs = document.querySelectorAll('.form-control, .form-select');

    formInputs.forEach(input => {
      input.addEventListener('focus', function() {
        this.parentElement.style.transform = 'scale(1.02)';
        this.parentElement.style.transition = 'all 0.3s ease';
      });

      input.addEventListener('blur', function() {
        this.parentElement.style.transform = 'scale(1)';
      });
    });

    // Phone number validation
    const phoneInput = document.getElementById('phoneNumber');
    phoneInput.addEventListener('input', function() {
      this.value = this.value.replace(/[^0-9+\-\s]/g, '');
    });
  });
</script>
</body>
</html>