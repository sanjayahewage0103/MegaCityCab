<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Drivers</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }
    th {
      background-color: #f2f2f2;
    }
    tr:nth-child(even) {
      background-color: #f9f9f9;
    }
    tr:hover {
      background-color: #f1f1f1;
    }
    .error {
      color: red;
    }
    .message {
      color: green;
    }
    form {
      margin-bottom: 10px;
    }
    input[type="text"], select, textarea {
      padding: 5px;
      margin: 5px 0;
      width: 100%;
      box-sizing: border-box;
    }
    button {
      background-color: #4CAF50;
      color: white;
      padding: 8px 12px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
    button:hover {
      background-color: #45a049;
    }
    a {
      color: #4CAF50;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
    /* Modal Styles */
    .modal {
      display: none;
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0, 0, 0, 0.5);
    }
    .modal-content {
      background-color: #fefefe;
      margin: 10% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 50%;
    }
    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }
    .close:hover,
    .close:focus {
      color: black;
      text-decoration: none;
      cursor: pointer;
    }
  </style>
</head>
<body>
<h1>Manage Drivers</h1>

<!-- Add Driver Button -->
<a href="add-driver.jsp" style="display: inline-block; margin-bottom: 20px;">
  <button>Add Driver</button>
</a>

<!-- Display Error or Success Message -->
<% if (request.getAttribute("error") != null) { %>
<div class="error"><%= request.getAttribute("error") %></div>
<% } %>

<% if (request.getAttribute("message") != null) { %>
<div class="message"><%= request.getAttribute("message") %></div>
<% } %>

<!-- Driver Table -->
<h2>View All Drivers</h2>
<table>
  <tr>
    <th>ID</th>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Phone Number</th>
    <th>NIC</th>
    <th>License Number</th>
    <th>Email</th>
    <th>Address</th>
    <th>Status</th>
    <th>Actions</th>
  </tr>
  <%
    java.util.List<?> drivers = (java.util.List<?>) request.getAttribute("drivers");
    if (drivers == null || drivers.isEmpty()) {
  %>
  <tr>
    <td colspan="10">No drivers found.</td>
  </tr>
  <%
  } else {
    for (Object obj : drivers) {
      com.example.megacitycab.model.Driver driver = (com.example.megacitycab.model.Driver) obj;
  %>
  <tr>
    <td><%= driver.getDriverId() %></td>
    <td><%= driver.getFirstName() %></td>
    <td><%= driver.getLastName() %></td>
    <td><%= driver.getPhoneNumber() %></td>
    <td><%= driver.getNic() %></td>
    <td><%= driver.getLicenseNumber() %></td>
    <td><%= driver.getEmail() %></td>
    <td><%= driver.getAddress() %></td>
    <td><%= driver.getStatus() %></td>
    <td>
      <button onclick="openEditModal(<%= driver.getDriverId() %>, '<%= driver.getFirstName() %>', '<%= driver.getLastName() %>', '<%= driver.getPhoneNumber() %>', '<%= driver.getNic() %>', '<%= driver.getLicenseNumber() %>', '<%= driver.getEmail() %>', '<%= driver.getAddress() %>', '<%= driver.getStatus() %>')">Edit</button>
      <a href="manage-driver?action=delete&driverId=<%= driver.getDriverId() %>" onclick="return confirm('Are you sure you want to delete this driver?')">Delete</a>
    </td>
  </tr>
  <%
      }
    }
  %>
</table>

<!-- Edit Modal -->
<div id="editModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeEditModal()">&times;</span>
    <h2>Edit Driver</h2>
    <form id="editForm" method="post" action="manage-driver">
      <input type="hidden" id="editDriverId" name="driverId">
      <input type="hidden" name="action" value="update">
      First Name: <input type="text" id="editFirstName" name="firstName" required><br>
      Last Name: <input type="text" id="editLastName" name="lastName" required><br>
      Phone Number: <input type="tel" id="editPhoneNumber" name="phoneNumber" required><br>
      NIC: <input type="text" id="editNic" name="nic" required><br>
      License Number: <input type="text" id="editLicenseNumber" name="licenseNumber" required><br>
      Email: <input type="email" id="editEmail" name="email"><br>
      Address: <textarea id="editAddress" name="address" rows="3" cols="40"></textarea><br>
      Status:
      <select id="editStatus" name="status" required>
        <option value="active">Active</option>
        <option value="inactive">Inactive</option>
      </select><br><br>
      <button type="submit">Update</button>
    </form>
  </div>
</div>

<script>
  // Open Edit Modal
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

  // Close Edit Modal
  function closeEditModal() {
    document.getElementById("editModal").style.display = "none";
  }

  // Close Modal on Outside Click
  window.onclick = function(event) {
    var modal = document.getElementById("editModal");
    if (event.target == modal) {
      modal.style.display = "none";
    }
  };
</script>
</body>
</html>