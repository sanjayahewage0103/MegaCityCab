<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View and Edit Vehicles</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .card {
            margin-bottom: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
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
        }
        .modal-content {
            background-color: #fff;
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
<!-- Success/Error Messages -->
<% if (request.getAttribute("message") != null) { %>
<div class="alert alert-success"><%= request.getAttribute("message") %></div>
<% } %>

<% if (request.getAttribute("error") != null) { %>
<div class="alert alert-danger"><%= request.getAttribute("error") %></div>
<% } %>

<!-- Search Bar -->
<form method="get" action="view-edit-vehicle">
    <input type="text" name="search" placeholder="Search by type or registration number">
    <button type="submit">Search</button>
</form>

<!-- Vehicle Table -->
<div class="card">
    <div class="card-body">
        <h5 class="card-title">Vehicle Management</h5>
        <table class="table table-bordered">
            <thead>
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
                <td><%= vehicle.getStatus() %></td>
                <td>
                    <a href="#" onclick="openEditModal(<%= vehicle.getVehicleId() %>, '<%= vehicle.getVehicleNumber() %>', '<%= vehicle.getColor() %>', '<%= vehicle.getRegisterNumber() %>', '<%= vehicle.getModel() %>', '<%= vehicle.getType() %>', <%= vehicle.getSeatingCapacity() %>, '<%= vehicle.getStatus() %>')">Edit</a>
                    <a href="view-edit-vehicle?action=delete&vehicleId=<%= vehicle.getVehicleId() %>" onclick="return confirm('Are you sure?')">Delete</a>
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
        <span class="close" onclick="closeEditModal()">&times;</span>
        <h2>Edit Vehicle</h2>
        <form method="post" action="view-edit-vehicle">
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