<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Vehicles</title>
</head>
<body>
<!-- Success/Error Messages -->
<% if (request.getAttribute("message") != null) { %>
<div style="color: green;"><%= request.getAttribute("message") %></div>
<% } %>
<% if (request.getAttribute("error") != null) { %>
<div style="color: red;"><%= request.getAttribute("error") %></div>
<% } %>

<!-- Search Bar -->
<form method="get" action="manage-vehicle">
  <input type="text" name="search" placeholder="Search by type or registration number">
  <button type="submit">Search</button>
</form>

<!-- Add New Vehicle Form -->
<h2>Add New Vehicle</h2>
<form method="post" action="manage-vehicle">
  <input type="hidden" name="action" value="add">
  Vehicle Number: <input type="text" name="vehicleNumber" required><br>
  Color: <input type="text" name="color"><br>
  Register Number: <input type="text" name="registerNumber" required><br>
  Model: <input type="text" name="model" required><br>
  Type:
  <select name="type" required>
    <option value="SUV">SUV</option>
    <option value="Sedan">Sedan</option>
    <option value="Van">Van</option>
  </select><br>
  Seating Capacity: <input type="number" name="seatingCapacity" required><br>
  Status:
  <select name="status" required>
    <option value="Available">Available</option>
    <option value="Ongoing">Ongoing</option>
    <option value="Service">Service</option>
  </select><br><br>
  <button type="submit">Add Vehicle</button>
</form>

<!-- Vehicle Table -->
<h2>All Vehicles</h2>
<table border="1">
  <tr>
    <th>ID</th>
    <th>Vehicle Number</th>
    <th>Color</th>
    <th>Register Number</th>
    <th>Model</th>
    <th>Type</th>
    <th>Seating Capacity</th>
    <th>Status</th>
    <th>Actions</th>
  </tr>
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
    <td><%= vehicle.getStatus() %></td>
    <td>
      <a href="#" onclick="openEditModal(<%= vehicle.getVehicleId() %>, '<%= vehicle.getVehicleNumber() %>', '<%= vehicle.getColor() %>', '<%= vehicle.getRegisterNumber() %>', '<%= vehicle.getModel() %>', '<%= vehicle.getType() %>', <%= vehicle.getSeatingCapacity() %>, '<%= vehicle.getStatus() %>')">Edit</a>
      <a href="manage-vehicle?action=delete&vehicleId=<%= vehicle.getVehicleId() %>" onclick="return confirm('Are you sure?')">Delete</a>
    </td>
  </tr>
  <%
      }
    }
  %>
</table>

<!-- Edit Modal -->
<div id="editModal" style="display: none;">
  <form method="post" action="manage-vehicle">
    <input type="hidden" id="editVehicleId" name="vehicleId">
    <input type="hidden" name="action" value="update">
    Vehicle Number: <input type="text" id="editVehicleNumber" name="vehicleNumber" required><br>
    Color: <input type="text" id="editColor" name="color"><br>
    Register Number: <input type="text" id="editRegisterNumber" name="registerNumber" required><br>
    Model: <input type="text" id="editModel" name="model" required><br>
    Type:
    <select id="editType" name="type" required>
      <option value="SUV">SUV</option>
      <option value="Sedan">Sedan</option>
      <option value="Van">Van</option>
    </select><br>
    Seating Capacity: <input type="number" id="editSeatingCapacity" name="seatingCapacity" required><br>
    Status:
    <select id="editStatus" name="status" required>
      <option value="Available">Available</option>
      <option value="Ongoing">Ongoing</option>
      <option value="Service">Service</option>
    </select><br><br>
    <button type="submit">Update</button>
  </form>
</div>

<script>
  function openEditModal(vehicleId, vehicleNumber, color, registerNumber, model, type, seatingCapacity, status) {
    document.getElementById("editVehicleId").value = vehicleId;
    document.getElementById("editVehicleNumber").value = vehicleNumber;
    document.getElementById("editColor").value = color;
    document.getElementById("editRegisterNumber").value = registerNumber;
    document.getElementById("editModel").value = model;
    document.getElementById("editType").value = type;
    document.getElementById("editSeatingCapacity").value = seatingCapacity;
    document.getElementById("editStatus").value = status;
    document.getElementById("editModal").style.display = "block";
  }
</script>
</body>
</html>