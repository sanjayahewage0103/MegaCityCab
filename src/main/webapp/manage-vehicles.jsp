<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Vehicles</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css">
  <style>
    :root {
      --primary: #4361ee;
      --secondary: #3f37c9;
      --light: #f8f9fa;
      --dark: #212529;
      --success: #4cc9f0;
      --danger: #f72585;
      --warning: #f9c74f;
      --info: #4895ef;
      --border-radius: 8px;
      --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      --transition: all 0.3s ease;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }

    body {
      background-color: #f5f7fb;
      color: var(--dark);
    }

    .grid-container {
      display: grid;
      grid-template-columns: repeat(6, 1fr);
      grid-template-rows: auto repeat(6, minmax(0, 1fr));
      gap: 20px;
      padding: 20px;
      height: 100vh;
      max-width: 1400px;
      margin: 0 auto;
    }

    .header {
      grid-column: span 6;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 15px 20px;
      background-color: white;
      border-radius: var(--border-radius);
      box-shadow: var(--box-shadow);
    }

    .header h1 {
      font-size: 1.5rem;
      color: var(--primary);
      margin: 0;
    }

    .header-left {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .back-btn {
      color: var(--primary);
      font-size: 1.5rem;
      cursor: pointer;
    }

    .search-form {
      display: flex;
      max-width: 400px;
    }

    .search-form input {
      border: 1px solid #ddd;
      border-radius: var(--border-radius) 0 0 var(--border-radius);
      padding: 8px 15px;
      width: 100%;
      outline: none;
    }

    .search-form button {
      background-color: var(--primary);
      color: white;
      border: none;
      padding: 8px 15px;
      border-radius: 0 var(--border-radius) var(--border-radius) 0;
      cursor: pointer;
      transition: var(--transition);
    }

    .search-form button:hover {
      background-color: var(--secondary);
    }

    .add-vehicle {
      grid-column: 1 / span 2;
      grid-row: 2 / span 6;
      background-color: white;
      border-radius: var(--border-radius);
      padding: 20px;
      box-shadow: var(--box-shadow);
      overflow-y: auto;
    }

    .add-vehicle h2 {
      font-size: 1.3rem;
      margin-bottom: 20px;
      color: var(--primary);
      padding-bottom: 10px;
      border-bottom: 2px solid #eee;
    }

    .form-group {
      margin-bottom: 15px;
    }

    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: 500;
      font-size: 0.9rem;
    }

    .form-control {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: var(--border-radius);
      outline: none;
      transition: var(--transition);
    }

    .form-control:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 2px rgba(67, 97, 238, 0.2);
    }

    .btn {
      padding: 10px 15px;
      border: none;
      border-radius: var(--border-radius);
      cursor: pointer;
      font-weight: 500;
      transition: var(--transition);
    }

    .btn-primary {
      background-color: var(--primary);
      color: white;
      width: 100%;
    }

    .btn-primary:hover {
      background-color: var(--secondary);
    }

    .stats-card {
      background-color: white;
      border-radius: var(--border-radius);
      padding: 20px;
      text-align: center;
      box-shadow: var(--box-shadow);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    }

    .stats-icon {
      font-size: 2rem;
      color: var(--primary);
      margin-bottom: 10px;
    }

    .stats-title {
      font-size: 0.9rem;
      color: #666;
      margin-bottom: 5px;
    }

    .stats-value {
      font-size: 1.8rem;
      font-weight: bold;
      color: var(--dark);
    }

    .vehicle-table {
      grid-column: 3 / span 4;
      grid-row: 3 / span 5;
      background-color: white;
      border-radius: var(--border-radius);
      padding: 20px;
      box-shadow: var(--box-shadow);
      overflow-y: auto;
    }

    .vehicle-table h2 {
      font-size: 1.3rem;
      margin-bottom: 20px;
      color: var(--primary);
      padding-bottom: 10px;
      border-bottom: 2px solid #eee;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid #eee;
    }

    th {
      font-weight: 600;
      color: #555;
      background-color: #f9f9f9;
    }

    tr:hover {
      background-color: #f5f5f5;
    }

    .action-links a {
      margin-right: 10px;
      text-decoration: none;
      color: var(--primary);
      font-weight: 500;
      transition: var(--transition);
    }

    .action-links a:hover {
      color: var(--secondary);
      text-decoration: underline;
    }

    .alert {
      padding: 10px 15px;
      border-radius: var(--border-radius);
      margin-bottom: 20px;
    }

    .alert-success {
      background-color: rgba(76, 201, 240, 0.2);
      border-left: 4px solid var(--success);
      color: #0077b6;
    }

    .alert-danger {
      background-color: rgba(247, 37, 133, 0.2);
      border-left: 4px solid var(--danger);
      color: #d00000;
    }

    /* Modal styles */
    .modal {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 1000;
      align-items: center;
      justify-content: center;
    }

    .modal-content {
      background-color: white;
      padding: 25px;
      border-radius: var(--border-radius);
      width: 90%;
      max-width: 600px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    .modal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #eee;
      padding-bottom: 15px;
      margin-bottom: 20px;
    }

    .modal-header h3 {
      margin: 0;
      color: var(--primary);
    }

    .close-btn {
      background: none;
      border: none;
      font-size: 1.5rem;
      cursor: pointer;
      color: #999;
    }

    .close-btn:hover {
      color: var(--danger);
    }
  </style>
</head>
<body>
<div class="grid-container">
  <!-- Header (1) -->
  <div class="header">
    <div class="header-left">
      <i class="fas fa-arrow-left back-btn"></i>
      <h1>Vehicle Management Dashboard</h1>
    </div>
    <form method="get" action="manage-vehicle" class="search-form">
      <input type="text" name="search" id="searchBar" placeholder="Search by type or registration number">
      <button type="submit"><i class="fas fa-search"></i></button>
    </form>
  </div>

  <!-- Add Vehicle Form (2) -->
  <div class="add-vehicle">
    <h2>Add New Vehicle</h2>
    <form method="post" action="manage-vehicle">
      <input type="hidden" name="action" value="add">

      <div class="form-group">
        <label for="vehicleNumber">Vehicle Number</label>
        <input type="text" id="vehicleNumber" name="vehicleNumber" class="form-control" required>
      </div>

      <div class="form-group">
        <label for="color">Color</label>
        <input type="text" id="color" name="color" class="form-control">
      </div>

      <div class="form-group">
        <label for="registerNumber">Register Number</label>
        <input type="text" id="registerNumber" name="registerNumber" class="form-control" required>
      </div>

      <div class="form-group">
        <label for="model">Model</label>
        <input type="text" id="model" name="model" class="form-control" required>
      </div>

      <div class="form-group">
        <label for="type">Type</label>
        <select id="type" name="type" class="form-control" required>
          <option value="SUV">SUV</option>
          <option value="Sedan">Sedan</option>
          <option value="Van">Van</option>
        </select>
      </div>

      <div class="form-group">
        <label for="seatingCapacity">Seating Capacity</label>
        <input type="number" id="seatingCapacity" name="seatingCapacity" class="form-control" required>
      </div>

      <div class="form-group">
        <label for="status">Status</label>
        <select id="status" name="status" class="form-control" required>
          <option value="Available">Available</option>
          <option value="Ongoing">Ongoing</option>
          <option value="Service">Service</option>
        </select>
      </div>

      <button type="submit" class="btn btn-primary">Add Vehicle</button>
    </form>
  </div>

  <!-- Stats Cards (3,4,5,6) -->
  <div class="stats-card" style="grid-column: 3; grid-row: 2;" data-aos="fade-up" data-aos-delay="100">
    <i class="fas fa-car stats-icon"></i>
    <div class="stats-title">Total Vehicles</div>
    <div class="stats-value"><%= request.getAttribute("totalVehicles") %></div>
  </div>

  <div class="stats-card" style="grid-column: 4; grid-row: 2;" data-aos="fade-up" data-aos-delay="200">
    <i class="fas fa-check-circle stats-icon"></i>
    <div class="stats-title">Available Vehicles</div>
    <div class="stats-value"><%= request.getAttribute("availableVehicles") %></div>
  </div>

  <div class="stats-card" style="grid-column: 5; grid-row: 2;" data-aos="fade-up" data-aos-delay="300">
    <i class="fas fa-road stats-icon"></i>
    <div class="stats-title">Ongoing Vehicles</div>
    <div class="stats-value"><%= request.getAttribute("ongoingVehicles") %></div>
  </div>

  <div class="stats-card" style="grid-column: 6; grid-row: 2;" data-aos="fade-up" data-aos-delay="400">
    <i class="fas fa-wrench stats-icon"></i>
    <div class="stats-title">Maintenance Vehicles</div>
    <div class="stats-value"><%= request.getAttribute("maintenanceVehicles") %></div>
  </div>

  <!-- Vehicle Table (7) -->
  <div class="vehicle-table">
    <!-- Success/Error Messages -->
    <% if (request.getAttribute("message") != null) { %>
    <div class="alert alert-success"><%= request.getAttribute("message") %></div>
    <% } %>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <h2>All Vehicles</h2>

    <table>
      <thead>
      <tr>
        <th>ID</th>
        <th>Vehicle Number</th>
        <th>Color</th>
        <th>Register Number</th>
        <th>Model</th>
        <th>Type</th>
        <th>Seating</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <%
        java.util.List<?> vehicles = (java.util.List<?>) request.getAttribute("vehicles");
        if (vehicles == null || vehicles.isEmpty()) {
      %>
      <tr>
        <td colspan="9">No vehicles found.</td>
      </tr>
      <%
      } else {
        for (Object obj : vehicles) {
          com.example.megacitycab.model.Vehicle vehicle = (com.example.megacitycab.model.Vehicle) obj;
      %>
      <tr>
        <td><%= vehicle.getVehicleId() %></td>
        <td><%= vehicle.getVehicleNumber() %></td>
        <td><%= vehicle.getColor() %></td>
        <td><%= vehicle.getRegisterNumber() %></td>
        <td><%= vehicle.getModel() %></td>
        <td><%= vehicle.getType() %></td>
        <td><%= vehicle.getSeatingCapacity() %></td>
        <td><span class="status-badge <%= vehicle.getStatus().toLowerCase() %>"><%= vehicle.getStatus() %></span></td>
        <td class="action-links">
          <a href="#" onclick="openEditModal(<%= vehicle.getVehicleId() %>, '<%= vehicle.getVehicleNumber() %>', '<%= vehicle.getColor() %>', '<%= vehicle.getRegisterNumber() %>', '<%= vehicle.getModel() %>', '<%= vehicle.getType() %>', <%= vehicle.getSeatingCapacity() %>, '<%= vehicle.getStatus() %>')">
            <i class="fas fa-edit"></i> Edit
          </a>
          <a href="manage-vehicle?action=delete&vehicleId=<%= vehicle.getVehicleId() %>" onclick="return confirm('Are you sure you want to delete this vehicle?')">
            <i class="fas fa-trash"></i> Delete
          </a>
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

<!-- Edit Modal -->
<div id="editModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h3>Edit Vehicle</h3>
      <button class="close-btn" onclick="closeEditModal()">&times;</button>
    </div>

    <form method="post" action="manage-vehicle">
      <input type="hidden" id="editVehicleId" name="vehicleId">
      <input type="hidden" name="action" value="update">

      <div class="form-group">
        <label for="editVehicleNumber">Vehicle Number</label>
        <input type="text" id="editVehicleNumber" name="vehicleNumber" class="form-control" required>
      </div>

      <div class="form-group">
        <label for="editColor">Color</label>
        <input type="text" id="editColor" name="color" class="form-control">
      </div>

      <div class="form-group">
        <label for="editRegisterNumber">Register Number</label>
        <input type="text" id="editRegisterNumber" name="registerNumber" class="form-control" required>
      </div>

      <div class="form-group">
        <label for="editModel">Model</label>
        <input type="text" id="editModel" name="model" class="form-control" required>
      </div>

      <div class="form-group">
        <label for="editType">Type</label>
        <select id="editType" name="type" class="form-control" required>
          <option value="SUV">SUV</option>
          <option value="Sedan">Sedan</option>
          <option value="Van">Van</option>
        </select>
      </div>

      <div class="form-group">
        <label for="editSeatingCapacity">Seating Capacity</label>
        <input type="number" id="editSeatingCapacity" name="seatingCapacity" class="form-control" required>
      </div>

      <div class="form-group">
        <label for="editStatus">Status</label>
        <select id="editStatus" name="status" class="form-control" required>
          <option value="Available">Available</option>
          <option value="Ongoing">Ongoing</option>
          <option value="Service">Service</option>
        </select>
      </div>

      <button type="submit" class="btn btn-primary">Update Vehicle</button>
    </form>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
  // Initialize AOS
  AOS.init({
    duration: 800,
    easing: 'ease-in-out',
    once: true
  });

  // Edit modal functions
  function openEditModal(vehicleId, vehicleNumber, color, registerNumber, model, type, seatingCapacity, status) {
    document.getElementById("editVehicleId").value = vehicleId;
    document.getElementById("editVehicleNumber").value = vehicleNumber;
    document.getElementById("editColor").value = color;
    document.getElementById("editRegisterNumber").value = registerNumber;
    document.getElementById("editModel").value = model;
    document.getElementById("editType").value = type;
    document.getElementById("editSeatingCapacity").value = seatingCapacity;
    document.getElementById("editStatus").value = status;

    const modal = document.getElementById("editModal");
    modal.style.display = "flex";
  }

  function closeEditModal() {
    document.getElementById("editModal").style.display = "none";
  }

  // Close modal when clicking outside the modal content
  window.onclick = function(event) {
    const modal = document.getElementById("editModal");
    if (event.target === modal) {
      modal.style.display = "none";
    }
  }
</script>
</body>
</html>