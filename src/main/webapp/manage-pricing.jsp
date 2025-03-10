<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.megacitycab.model.Pricing" %>
<%@ page import="java.util.List" %>

<%
  if (session == null || session.getAttribute("admin") == null) {
    response.sendRedirect("admin-login.jsp?error=You must log in to access the admin dashboard.");
    return;
  }
  String adminUsername = (String) session.getAttribute("admin");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Pricing</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
      --light-bg: #f5f7fa;
      --border-color: #e0e5ec;
      --success: #4CAF50;
      --danger: #f44336;
      --card-bg: #ffffff;
      --text-muted: #8392a5;
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
      background-color: var(--light-bg);
      color: var(--secondary);
      transition: all 0.3s ease;
      line-height: 1.6;
      padding: 0;
      height: 100vh;
      overflow-x: hidden;
    }

    /* Container styles */
    .dashboard-container {
      max-width: 1500px;
      margin: 0 auto;
      background-color: var(--light-bg);
      padding: 1.25rem;
    }

    /* Scrollbar Styling */
    ::-webkit-scrollbar {
      width: 6px;
      height: 6px;
    }

    ::-webkit-scrollbar-track {
      background: transparent;
    }

    ::-webkit-scrollbar-thumb {
      background-color: var(--primary);
      border-radius: 20px;
    }

    /* Header Section */
    .page-header {
      display: flex;
      align-items: center;
      background-color: var(--card-bg);
      padding: 1rem 1.5rem;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      margin-bottom: 1.5rem;
    }

    .back-button {
      min-width: 40px;
      margin-right: 1rem;
    }

    .back-button button {
      background-color: var(--primary);
      border: none;
      padding: 0.5rem 0.75rem;
      border-radius: 8px;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      box-shadow: 0 2px 5px rgba(255, 69, 0, 0.3);
    }

    .back-button button:hover {
      background-color: var(--primary-dark);
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(255, 69, 0, 0.4);
    }

    .logo-container {
      margin-right: 1rem;
      display: flex;
      align-items: center;
      justify-content: center;
      width: 40px;
      height: 40px;
    }

    .page-title {
      font-weight: 700;
      color: var(--primary);
      font-size: 1.35rem;
      margin: 0;
      margin-right: auto;
      letter-spacing: -0.5px;
    }

    /* Pricing Table Container */
    .pricing-container {
      background-color: var(--card-bg);
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      padding: 1.5rem;
      margin-bottom: 1.5rem;
      overflow: hidden;
    }

    .section-title {
      color: var(--secondary);
      font-weight: 700;
      font-size: 1.1rem;
      margin-bottom: 1.25rem;
      position: relative;
      padding-bottom: 0.5rem;
      letter-spacing: -0.5px;
    }

    .section-title::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 40px;
      height: 3px;
      background-color: var(--primary);
      border-radius: 2px;
    }

    .pricing-description {
      color: var(--text-muted);
      font-size: 0.9rem;
      margin-bottom: 1.5rem;
    }

    /* Table Styling */
    .table-responsive {
      overflow-x: auto;
      border-radius: 8px;
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
    }

    thead th {
      background-color: rgba(44, 62, 80, 0.05);
      color: var(--secondary);
      font-weight: 600;
      padding: 0.9rem 1rem;
      text-align: left;
      font-size: 0.85rem;
      position: sticky;
      top: 0;
      z-index: 10;
      border-bottom: 1px solid var(--border-color);
    }

    thead th:first-child {
      border-top-left-radius: 8px;
    }

    thead th:last-child {
      border-top-right-radius: 8px;
    }

    tbody tr {
      border-bottom: 1px solid var(--border-color);
      transition: all 0.2s ease;
    }

    tbody tr:hover {
      background-color: rgba(255, 69, 0, 0.03);
    }

    tbody td {
      padding: 0.9rem 1rem;
      vertical-align: middle;
      font-size: 0.9rem;
    }

    /* Input Styling */
    .price-input {
      width: 100%;
      padding: 0.6rem 0.8rem;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      font-size: 0.9rem;
      transition: all 0.25s ease-in-out;
      background-color: var(--light-bg);
    }

    .price-input:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(255, 69, 0, 0.1);
    }

    .price-input:hover {
      border-color: var(--primary-dark);
    }

    /* Button Styling */
    .update-btn {
      background-color: var(--primary);
      color: white;
      border: none;
      padding: 0.6rem 1rem;
      border-radius: 8px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
      width: 100%;
      box-shadow: 0 2px 5px rgba(255, 69, 0, 0.3);
    }

    .update-btn:hover {
      background-color: var(--primary-dark);
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(255, 69, 0, 0.4);
    }

    /* Vehicle Type Badge */
    .vehicle-badge {
      padding: 0.3rem 0.7rem;
      border-radius: 20px;
      font-size: 0.85rem;
      display: inline-block;
      font-weight: 500;
      background-color: rgba(255, 69, 0, 0.1);
      color: var(--primary);
    }

    /* Message Styling */
    .message, .error {
      padding: 1rem;
      border-radius: 10px;
      margin-bottom: 1.25rem;
      display: flex;
      align-items: center;
      gap: 0.8rem;
      animation: slideDown 0.5s ease;
    }

    @keyframes slideDown {
      from { transform: translateY(-15px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }

    .message {
      background-color: rgba(76, 175, 80, 0.1);
      border-left: 4px solid #4CAF50;
      color: #2e7d32;
    }

    .error {
      background-color: rgba(244, 67, 54, 0.1);
      border-left: 4px solid #f44336;
      color: #c62828;
    }

    /* Responsive Design */
    @media (max-width: 1200px) {
      .page-header {
        flex-wrap: wrap;
      }
    }

    @media (max-width: 768px) {
      .page-header {
        flex-direction: column;
        align-items: flex-start;
      }

      .page-title {
        margin: 0.75rem 0;
      }
    }
  </style>
</head>
<body>
<div class="dashboard-container">
  <!-- Success/Error Messages -->
  <% if (request.getParameter("message") != null) { %>
  <div class="message">
    <i class="fas fa-check-circle"></i> <%= request.getParameter("message") %>
  </div>
  <% } %>

  <% if (request.getParameter("error") != null) { %>
  <div class="error">
    <i class="fas fa-exclamation-circle"></i> <%= request.getParameter("error") %>
  </div>
  <% } %>

  <!-- Page Header -->
  <div class="page-header">
    <!-- Back Button -->
    <a href="admin-dashboard.jsp" class="back-button">
      <button>
        <i class="fas fa-arrow-left"></i>
      </button>
    </a>

    <!-- Logo -->
    <div class="logo-container">
      <i class="fas fa-dollar-sign" style="color: var(--primary);"></i>
    </div>

    <!-- Page Title -->
    <h1 class="page-title">Pricing Management</h1>
  </div>

  <!-- Pricing Table Section -->
  <div class="pricing-container">
    <h2 class="section-title">Manage Pricing Tiers</h2>
    <p class="pricing-description">
      Update pricing rates for different vehicle types and distance tiers. Changes will immediately affect new bookings.
    </p>

    <form method="post" action="pricing-servlet">
      <div class="table-responsive">
        <table>
          <thead>
          <tr>
            <th>Vehicle Type</th>
            <th>Tax (%)</th>
            <th>Below 10 KM</th>
            <th>10-20 KM</th>
            <th>20-50 KM</th>
            <th>Above 50 KM</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <%
            List<Pricing> pricings = (List<Pricing>) request.getAttribute("pricings");
            if (pricings != null && !pricings.isEmpty()) {
              for (Pricing pricing : pricings) {
          %>
          <tr>
            <td>
              <span class="vehicle-badge"><%= pricing.getVehicleType() %></span>
            </td>
            <td>
              <input type="number" step="0.01" name="taxPercentage" value="<%= pricing.getTaxPercentage() %>" class="price-input">
            </td>
            <td>
              <input type="number" step="0.01" name="pricePerKmBelow10" value="<%= pricing.getPricePerKmBelow10() %>" class="price-input">
            </td>
            <td>
              <input type="number" step="0.01" name="pricePerKm10To20" value="<%= pricing.getPricePerKm10To20() %>" class="price-input">
            </td>
            <td>
              <input type="number" step="0.01" name="pricePerKm20To50" value="<%= pricing.getPricePerKm20To50() %>" class="price-input">
            </td>
            <td>
              <input type="number" step="0.01" name="pricePerKmAbove50" value="<%= pricing.getPricePerKmAbove50() %>" class="price-input">
            </td>
            <td>
              <input type="hidden" name="pricingId" value="<%= pricing.getPricingId() %>">
              <button type="submit" class="update-btn">
                <i class="fas fa-save"></i> Update
              </button>
            </td>
          </tr>
          <%
            }
          } else {
          %>
          <tr>
            <td colspan="7" style="text-align: center;">No pricing data available.</td>
          </tr>
          <%
            }
          %>
          </tbody>
        </table>
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
  AOS.init({
    duration: 800,
    easing: 'ease-in-out',
    once: true
  });
</script>
</body>
</html>