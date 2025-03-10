<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.megacitycab.model.PromoCode" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Promo Codes</title>
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
    .message {
      color: green;
      margin-bottom: 10px;
    }
    .error {
      color: red;
      margin-bottom: 10px;
    }
    form {
      margin-bottom: 20px;
    }
    input[type="text"], select {
      padding: 5px;
      margin: 5px 0;
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
      z-index: 1000;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
    }
    .modal-content {
      background-color: white;
      margin: 10% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 50%;
      max-width: 600px;
      border-radius: 10px;
    }
    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
    }
    .close:hover {
      color: black;
    }
  </style>
</head>
<body>
<h1>Manage Promo Codes</h1>

<!-- Success/Error Messages -->
<% if (request.getParameter("message") != null) { %>
<div class="message"><%= request.getParameter("message") %></div>
<% } %>

<% if (request.getParameter("error") != null) { %>
<div class="error"><%= request.getParameter("error") %></div>
<% } %>

<!-- Promo Code Statistics -->
<div>
  <p><strong>Total Promo Codes:</strong> ${totalPromoCodes}</p>
  <p><strong>Active Promo Codes:</strong> ${activePromoCodes}</p>
  <p><strong>Expired Promo Codes:</strong> ${expiredPromoCodes}</p>
</div>

<!-- Search Bar -->
<form method="get" action="promo-code-servlet">
  <input type="hidden" name="action" value="search">
  <input type="text" name="search" placeholder="Search by promo code or status">
  <button type="submit">Search</button>
</form>

<!-- Add Promo Code Form -->
<h2>Add New Promo Code</h2>
<form method="post" action="promo-code-servlet">
  <input type="hidden" name="action" value="add">
  Promo Code: <input type="text" name="promoCode" required><br>
  Discount Percentage: <input type="number" step="0.01" name="discountPercentage" required><br>
  Valid From: <input type="date" name="validFrom" required><br>
  Valid Until: <input type="date" name="validUntil" required><br>
  Status:
  <select name="status" required>
    <option value="Active">Active</option>
    <option value="Inactive">Inactive</option>
  </select><br><br>
  <button type="submit">Add Promo Code</button>
</form>

<!-- Promo Code Table -->
<h2>All Promo Codes</h2>
<table border="1">
  <tr>
    <th>Promo Code</th>
    <th>Discount Percentage</th>
    <th>Valid From</th>
    <th>Valid Until</th>
    <th>Status</th>
    <th>Actions</th>
  </tr>
  <%
    List<PromoCode> promoCodes = (List<PromoCode>) request.getAttribute("promoCodes");
    if (promoCodes == null || promoCodes.isEmpty()) {
  %>
  <tr>
    <td colspan="6">No promo codes found.</td>
  </tr>
  <%
  } else {
    for (PromoCode promoCode : promoCodes) {
  %>
  <tr>
    <td><%= promoCode.getPromoCode() %></td>
    <td><%= promoCode.getDiscountPercentage() %>%</td>
    <td><%= promoCode.getValidFrom() %></td>
    <td><%= promoCode.getValidUntil() %></td>
    <td><%= promoCode.getStatus() %></td>
    <td>
      <button onclick="openEditModal(<%= promoCode.getId() %>, '<%= promoCode.getPromoCode() %>', <%= promoCode.getDiscountPercentage() %>, '<%= promoCode.getValidFrom() %>', '<%= promoCode.getValidUntil() %>', '<%= promoCode.getStatus() %>')">Edit</button>
      <a href="promo-code-servlet?action=delete&id=<%= promoCode.getId() %>" onclick="return confirm('Are you sure you want to delete this promo code?')">Delete</a>
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
    <h2>Edit Promo Code</h2>
    <form id="editForm" method="post" action="promo-code-servlet">
      <input type="hidden" id="editId" name="id">
      Promo Code: <input type="text" id="editPromoCode" name="promoCode" required><br>
      Discount Percentage: <input type="number" step="0.01" id="editDiscountPercentage" name="discountPercentage" required><br>
      Valid From: <input type="date" id="editValidFrom" name="validFrom" required><br>
      Valid Until: <input type="date" id="editValidUntil" name="validUntil" required><br>
      Status:
      <select id="editStatus" name="status" required>
        <option value="Active">Active</option>
        <option value="Inactive">Inactive</option>
      </select><br><br>
      <input type="hidden" name="action" value="update">
      <button type="submit">Update Promo Code</button>
    </form>
  </div>
</div>

<script>
  function openEditModal(id, promoCode, discountPercentage, validFrom, validUntil, status) {
    document.getElementById("editId").value = id;
    document.getElementById("editPromoCode").value = promoCode;
    document.getElementById("editDiscountPercentage").value = discountPercentage;
    document.getElementById("editValidFrom").value = validFrom;
    document.getElementById("editValidUntil").value = validUntil;
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