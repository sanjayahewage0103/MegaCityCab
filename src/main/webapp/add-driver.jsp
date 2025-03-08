<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Add Driver</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    form {
      max-width: 500px;
      margin: auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    input[type="text"], input[type="email"], input[type="tel"] {
      width: 100%;
      padding: 8px;
      margin: 5px 0 10px 0;
      box-sizing: border-box;
    }
    button {
      background-color: #4CAF50;
      color: white;
      padding: 10px 15px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
    button:hover {
      background-color: #45a049;
    }
    .error {
      color: red;
    }
    .message {
      color: green;
    }
  </style>
</head>
<body>
<h1>Add New Driver</h1>

<!-- Display Error or Success Message -->
<% if (request.getAttribute("error") != null) { %>
<div class="error"><%= request.getAttribute("error") %></div>
<% } %>

<% if (request.getAttribute("message") != null) { %>
<div class="message"><%= request.getAttribute("message") %></div>
<% } %>

<form method="post" action="add-driver">
  First Name: <input type="text" name="firstName" required><br>
  Last Name: <input type="text" name="lastName" required><br>
  Phone Number: <input type="tel" name="phoneNumber" required><br>
  NIC: <input type="text" name="nic" required><br>
  License Number: <input type="text" name="licenseNumber" required><br>
  Email: <input type="email" name="email"><br>
  Address: <textarea name="address" rows="3" cols="40"></textarea><br>
  Status:
  <select name="status" required>
    <option value="active">Active</option>
    <option value="inactive">Inactive</option>
  </select><br><br>
  <button type="submit">Add Driver</button>
</form>
</body>
</html>