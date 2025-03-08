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
<html>
<head>
  <title>Driver Management Dashboard</title>
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

    .search-container {
      display: flex;
      align-items: center;
      min-width: 300px;
      position: relative;
    }

    .search-container input {
      padding: 0.6rem 1rem 0.6rem 2.5rem;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      font-size: 0.9rem;
      width: 100%;
      transition: all 0.35s ease-in-out;
      background-color: var(--light-bg);
    }

    .search-container input:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(255, 69, 0, 0.1);
    }

    .search-icon {
      position: absolute;
      left: 0.8rem;
      color: var(--text-muted);
    }

    .search-button {
      background-color: var(--primary);
      color: white;
      border: none;
      padding: 0.6rem 1rem;
      border-radius: 8px;
      margin-left: 0.5rem;
      transition: all 0.3s ease;
      box-shadow: 0 2px 5px rgba(255, 69, 0, 0.3);
    }

    .search-button:hover {
      background-color: var(--primary-dark);
      box-shadow: 0 4px 8px rgba(255, 69, 0, 0.4);
    }

    /* Main Content Layout */
    .main-content {
      display: flex;
      gap: 1rem;
    }

    /* Left Column - Form */
    .left-column {
      width: 30%;
    }

    .form-container {
      background-color: var(--card-bg);
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      padding: 1.5rem;
      margin-bottom: 1.5rem;
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

    /* Form Styling */
    .input-group {
      margin-bottom: 0.5rem;
      position: relative;
    }

    .input-group-icon {
      position: relative;
    }

    .input-group-icon input,
    .input-group-icon select,
    .input-group-icon textarea {
      width: 100%;
      padding: 0.6rem 0.8rem 0.6rem 2.5rem;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      font-size: 0.9rem;
      transition: all 0.35s ease-in-out;
      background-color: var(--light-bg);
    }

    .input-group-icon textarea {
      min-height: 80px;
    }

    .input-group-icon .input-icon {
      position: absolute;
      top: 0;
      left: 0;
      width: 40px;
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--text-muted);
    }

    .input-group-icon input:focus,
    .input-group-icon select:focus,
    .input-group-icon textarea:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(255, 69, 0, 0.1);
    }

    .input-group-icon input:focus + .input-icon,
    .input-group-icon select:focus + .input-icon,
    .input-group-icon textarea:focus + .input-icon {
      color: var(--primary);
    }

    .submit-btn {
      background-color: var(--primary);
      color: white;
      border: none;
      padding: 0.7rem 1rem;
      border-radius: 8px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
      width: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
      box-shadow: 0 2px 5px rgba(255, 69, 0, 0.3);
    }

    .submit-btn:hover {
      background-color: var(--primary-dark);
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(255, 69, 0, 0.4);
    }

    /* Right Column */
    .right-column {
      width: 70%;
    }

    /* Stats Cards */
    .stats-cards {
      display: flex;
      justify-content: space-between;
      gap: 1rem;
      margin-bottom: 1rem;
    }

    .stat-card {
      flex: 1;
      background: var(--card-bg);
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      padding: 1.25rem;
      display: flex;
      align-items: center;
      transition: all 0.3s ease;
      overflow: hidden;
      position: relative;
    }

    .stat-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 15px rgba(0,0,0,0.1);
    }

    .stat-icon {
      width: 50px;
      height: 50px;
      background-color: rgba(255, 69, 0, 0.1);
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 1rem;
      color: var(--primary);
    }

    .stat-info h3 {
      font-size: 0.9rem;
      margin: 0;
      color: var(--text-muted);
      font-weight: 500;
    }

    .stat-info p {
      font-size: 1.5rem;
      font-weight: 700;
      margin: 0.2rem 0 0;
      color: var(--secondary);
    }

    /* Table Styling */
    .table-container {
      background-color: var(--card-bg);
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      padding: 1.5rem;
      overflow: hidden;
    }

    .table-responsive {
      overflow-x: auto;
      max-height: 550px;
      overflow-y: auto;
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

    .action-buttons {
      display: flex;
      gap: 0.4rem;
    }

    .action-btn {
      padding: 0.4rem 0.6rem;
      border-radius: 6px;
      font-size: 0.75rem;
      cursor: pointer;
      transition: all 0.3s ease;
      border: none;
      display: flex;
      align-items: center;
      gap: 0.3rem;
      font-weight: 500;
    }

    .edit-btn {
      background-color: rgba(76, 175, 80, 0.1);
      color: var(--success);
    }

    .edit-btn:hover {
      background-color: var(--success);
      color: white;
    }

    .delete-btn {
      background-color: rgba(244, 67, 54, 0.1);
      color: var(--danger);
    }

    .delete-btn:hover {
      background-color: var(--danger);
      color: white;
    }

    /* Status Badge */
    .status-badge {
      padding: 0.3rem 0.7rem;
      border-radius: 20px;
      font-size: 0.75rem;
      display: inline-block;
      font-weight: 500;
    }

    .status-badge.active {
      background-color: rgba(76, 175, 80, 0.15);
      color: #2e7d32;
    }

    .status-badge.inactive {
      background-color: rgba(244, 67, 54, 0.15);
      color: #c62828;
    }

    /* Notification Styling */
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

    /* Modal Styling */
    .modal {
      display: none;
      position: fixed;
      z-index: 1000;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0, 0, 0, 0.5);
      animation: fadeIn 0.3s ease;
      backdrop-filter: blur(3px);
    }

    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    .modal-content {
      background-color: #fff;
      margin: 5% auto;
      padding: 1.5rem;
      border-radius: 12px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.15);
      width: 60%;
      max-width: 600px;
      transform: translateY(20px);
      animation: slideIn 0.3s forwards;
    }

    @keyframes slideIn {
      to { transform: translateY(0); }
    }

    .modal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1.25rem;
      border-bottom: 1px solid var(--border-color);
      padding-bottom: 1rem;
    }

    .modal-title {
      font-weight: 700;
      color: var(--secondary);
      margin: 0;
      font-size: 1.2rem;
    }

    .close {
      color: var(--text-muted);
      font-size: 1.5rem;
      font-weight: bold;
      cursor: pointer;
      transition: all 0.2s ease;
      width: 30px;
      height: 30px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
    }

    .close:hover {
      color: var(--primary);
      background-color: rgba(0,0,0,0.05);
    }

    /* Counter Animation */
    .counter-anim {
      animation: count 2s ease-out;
    }

    @keyframes count {
      from { opacity: 0; transform: translateY(8px); }
      to { opacity: 1; transform: translateY(0); }
    }

    /* Responsive Design */
    @media (max-width: 1200px) {
      .page-header {
        flex-wrap: wrap;
      }

      .search-container {
        margin-top: 1rem;
        width: 100%;
      }

      .main-content {
        flex-direction: column;
      }

      .left-column, .right-column {
        width: 100%;
      }
    }

    @media (max-width: 768px) {
      .stats-cards {
        flex-direction: column;
      }

      .page-header {
        flex-direction: column;
        align-items: flex-start;
      }

      .page-title {
        margin: 0.75rem 0;
      }

      .search-container {
        width: 100%;
      }

      .modal-content {
        width: 90%;
      }
    }
  </style>
</head>
<body>
<div class="dashboard-container">
  <!-- Success/Error Messages -->
  <% if (request.getAttribute("message") != null) { %>
  <div class="message">
    <i class="fas fa-check-circle"></i> <%= request.getAttribute("message") %>
  </div>
  <% } %>

  <% if (request.getAttribute("error") != null) { %>
  <div class="error">
    <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
  </div>
  <% } %>

  <!-- Page Header with proper organization -->
  <div class="page-header">
    <!-- Back Button -->
    <a href="admin-dashboard.jsp" class="back-button">
      <button>
        <i class="fas fa-arrow-left"></i>
      </button>
    </a>

    <!-- Logo -->
    <div class="logo-container">
      <i class="fas fa-taxi" style="color: var(--primary);"></i>
    </div>

    <!-- Page Title -->
    <h1 class="page-title">Driver Management Dashboard</h1>

    <!-- Search Bar -->
    <form method="get" action="driver-dashboard" class="search-container">
      <i class="fas fa-search search-icon"></i>
      <input type="text" name="search" id="searchBar" placeholder="Search by name, NIC, or license number">
      <button type="submit" class="search-button">
        Search
      </button>
    </form>
  </div>

  <!-- Main Content with 30-70 Split -->
  <div class="main-content">
    <!-- Left Column (30%) - Add Driver Form -->
    <div class="left-column">
      <div class="form-container">
        <h2 class="section-title">Add New Driver</h2>
        <form method="post" action="driver-dashboard">
          <input type="hidden" name="action" value="add">

          <div class="input-group input-group-icon">
            <input type="text" id="firstName" name="firstName" placeholder="First Name" required>
            <div class="input-icon">
              <i class="fas fa-user"></i>
            </div>
          </div>

          <div class="input-group input-group-icon">
            <input type="text" id="lastName" name="lastName" placeholder="Last Name" required>
            <div class="input-icon">
              <i class="fas fa-user"></i>
            </div>
          </div>

          <div class="input-group input-group-icon">
            <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="Phone Number" required>
            <div class="input-icon">
              <i class="fas fa-phone"></i>
            </div>
          </div>

          <div class="input-group input-group-icon">
            <input type="text" id="nic" name="nic" placeholder="NIC" required>
            <div class="input-icon">
              <i class="fas fa-id-card"></i>
            </div>
          </div>

          <div class="input-group input-group-icon">
            <input type="text" id="licenseNumber" name="licenseNumber" placeholder="License Number" required>
            <div class="input-icon">
              <i class="fas fa-id-badge"></i>
            </div>
          </div>

          <div class="input-group input-group-icon">
            <input type="email" id="email" name="email" placeholder="Email Address">
            <div class="input-icon">
              <i class="fas fa-envelope"></i>
            </div>
          </div>

          <div class="input-group input-group-icon">
            <textarea id="address" name="address" placeholder="Address"></textarea>
            <div class="input-icon">
              <i class="fas fa-home"></i>
            </div>
          </div>

          <div class="input-group input-group-icon">
            <select id="status" name="status" required>
              <option value="" disabled selected>Select Status</option>
              <option value="active">Active</option>
              <option value="inactive">Inactive</option>
            </select>
            <div class="input-icon">
              <i class="fas fa-user-check"></i>
            </div>
          </div>

          <button type="submit" class="submit-btn">
            <i class="fas fa-plus-circle"></i> Add Driver
          </button>
        </form>
      </div>
    </div>

    <!-- Right Column (70%) - Stats Cards and Driver Table -->
    <div class="right-column">
      <!-- Stats Cards -->
      <div class="stats-cards">
        <div class="stat-card" data-aos="fade-up" data-aos-delay="100">
          <div class="stat-icon">
            <i class="fas fa-users"></i>
          </div>
          <div class="stat-info">
            <h3>Total Drivers</h3>
            <p class="counter-anim" data-count="<%= request.getAttribute("totalDrivers") %>">0</p>
          </div>
        </div>

        <div class="stat-card" data-aos="fade-up" data-aos-delay="200">
          <div class="stat-icon">
            <i class="fas fa-user-check"></i>
          </div>
          <div class="stat-info">
            <h3>Active Drivers</h3>
            <p class="counter-anim" data-count="<%= request.getAttribute("activeDrivers") %>">0</p>
          </div>
        </div>

        <div class="stat-card" data-aos="fade-up" data-aos-delay="300">
          <div class="stat-icon">
            <i class="fas fa-user-times"></i>
          </div>
          <div class="stat-info">
            <h3>Inactive Drivers</h3>
            <p class="counter-anim" data-count="<%= request.getAttribute("inactiveDrivers") %>">0</p>
          </div>
        </div>
      </div>

      <!-- Driver Table -->
      <div class="table-container">
        <h2 class="section-title">All Drivers</h2>
        <div class="table-responsive">
          <table>
            <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Phone</th>
              <th>NIC</th>
              <th>License</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
              java.util.List<?> drivers = (java.util.List<?>) request.getAttribute("drivers");
              if (drivers == null || drivers.isEmpty()) {
            %>
            <tr>
              <td colspan="7" style="text-align: center;">No drivers found.</td>
            </tr>
            <%
            } else {
              for (Object obj : drivers) {
                com.example.megacitycab.model.Driver driver = (com.example.megacitycab.model.Driver) obj;
            %>
            <tr>
              <td><%= driver.getDriverId() %></td>
              <td><%= driver.getFirstName() + " " + driver.getLastName() %></td>
              <td><%= driver.getPhoneNumber() %></td>
              <td><%= driver.getNic() %></td>
              <td><%= driver.getLicenseNumber() %></td>
              <td>
                  <span class="status-badge <%= driver.getStatus().equals("active") ? "active" : "inactive" %>">
                    <%= driver.getStatus() %>
                  </span>
              </td>
              <td>
                <div class="action-buttons">
                  <button class="action-btn edit-btn" onclick="openEditModal(<%= driver.getDriverId() %>, '<%= driver.getFirstName() %>', '<%= driver.getLastName() %>', '<%= driver.getPhoneNumber() %>', '<%= driver.getNic() %>', '<%= driver.getLicenseNumber() %>', '<%= driver.getEmail() %>', '<%= driver.getAddress() %>', '<%= driver.getStatus() %>')">
                    <i class="fas fa-edit"></i> Edit
                  </button>
                  <a href="manage-driver?action=delete&driverId=<%= driver.getDriverId() %>" class="action-btn delete-btn" onclick="return confirm('Are you sure you want to delete this driver?')">
                    <i class="fas fa-trash"></i> Delete
                  </a>
                </div>
              </td>
            </tr>
            <%
                }
              }
            %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Edit Modal -->
<div id="editModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2 class="modal-title">Edit Driver</h2>
      <span class="close" onclick="closeEditModal()">&times;</span>
    </div>

    <form id="editForm" method="post" action="manage-driver">
      <input type="hidden" id="editDriverId" name="driverId">
      <input type="hidden" name="action" value="update">

      <div class="input-group input-group-icon">
        <input type="text" id="editFirstName" name="firstName" placeholder="First Name" required>
        <div class="input-icon">
          <i class="fas fa-user"></i>
        </div>
      </div>

      <div class="input-group input-group-icon">
        <input type="text" id="editLastName" name="lastName" placeholder="Last Name" required>
        <div class="input-icon">
          <i class="fas fa-user"></i>
        </div>
      </div>

      <div class="input-group input-group-icon">
        <input type="tel" id="editPhoneNumber" name="phoneNumber" placeholder="Phone Number" required>
        <div class="input-icon">
          <i class="fas fa-phone"></i>
        </div>
      </div>

      <div class="input-group input-group-icon">
        <input type="text" id="editNic" name="nic" placeholder="NIC" required>
        <div class="input-icon">
          <i class="fas fa-id-card"></i>
        </div>
      </div>

      <div class="input-group input-group-icon">
        <input type="text" id="editLicenseNumber" name="licenseNumber" placeholder="License Number" required>
        <div class="input-icon">
          <i class="fas fa-id-badge"></i>
        </div>
      </div>

      <div class="input-group input-group-icon">
        <input type="email" id="editEmail" name="email" placeholder="Email Address">
        <div class="input-icon">
          <i class="fas fa-envelope"></i>
        </div>
      </div>

      <div class="input-group input-group-icon">
        <textarea id="editAddress" name="address" placeholder="Address"></textarea>
        <div class="input-icon">
          <i class="fas fa-home"></i>
        </div>
      </div>

      <div class="input-group input-group-icon">
        <select id="editStatus" name="status" required>
          <option value="active">Active</option>
          <option value="inactive">Inactive</option>
        </select>
        <div class="input-icon">
          <i class="fas fa-user-check"></i>
        </div>
      </div>

      <button type="submit" class="submit-btn">
        <i class="fas fa-save"></i> Update Driver
      </button>
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

  // Counter Animation
  document.addEventListener('DOMContentLoaded', function() {
    const counters = document.querySelectorAll('.counter-anim');

    counters.forEach(counter => {
      const target = parseInt(counter.getAttribute('data-count'));
      const duration = 2000; // 2 seconds
      const steps = 50;
      const stepTime = duration / steps;
      const increment = target / steps;
      let current = 0;

      const timer = setInterval(() => {
        current += increment;
        counter.textContent = Math.floor(current);

        if (current >= target) {
          counter.textContent = target;
          clearInterval(timer);
        }
      }, stepTime);
    });
  });

  // Modal Functions
  function openEditModal(driverId, firstName, lastName, phoneNumber, nic, licenseNumber, email, address, status) {
    document.getElementById("editDriverId").value = driverId;
    document.getElementById("editFirstName").value = firstName;
    document.getElementById("editLastName").value = lastName;
    document.getElementById("editPhoneNumber").value = phoneNumber;
    document.getElementById("editNic").value = nic;
    document.getElementById("editLicenseNumber").value = licenseNumber;
    document.getElementById("editEmail").value = email;
    document.getElementById("editAddress").value = address;
    document.getElementById("editStatus").value = status;
    document.getElementById("editModal").style.display = "block";
  }

  function closeEditModal() {
    document.getElementById("editModal").style.display = "none";
  }

  window.onclick = function(event) {
    var modal = document.getElementById("editModal");
    if (event.target == modal) {
      modal.style.display = "none";
    }
  };
</script>
</body>
</html>