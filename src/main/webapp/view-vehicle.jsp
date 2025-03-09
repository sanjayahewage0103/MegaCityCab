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
<html>
<head>
    <title>Manage Vehicles | MegaCab</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #FF6B00;
            --primary-dark: #E55A00;
            --secondary: #2C3E50;
            --light: #F8F9FA;
            --dark: #1A1A1A;
            --gray: #6C757D;
        }

        body {
            font-family: 'Poppins', sans-serif;
            color: var(--dark);
            background-color: #f4f6f9;
            overflow-x: hidden;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
        }

        .navbar {
            background-color: #FFFFFF;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
        }

        .navbar-brand {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            color: var(--secondary) !important;
            display: flex;
            align-items: center;
        }

        .navbar-brand img {
            height: 40px;
            margin-right: 10px;
        }

        .navbar-brand span {
            color: var(--primary);
        }

        .back-link {
            display: flex;
            align-items: center;
            color: var(--secondary);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            color: var(--primary);
        }

        .back-link i {
            margin-right: 8px;
            font-size: 1.2rem;
        }

        .main-container {
            max-width: 1200px;
            margin: 40px auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            padding: 0;
        }

        .container-header {
            background-color: #f9fafb;
            padding: 20px 30px;
            border-bottom: 1px solid #e1e5ea;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .container-title {
            margin: 0;
            color: var(--secondary);
            font-size: 1.75rem;
        }

        .container-body {
            padding: 30px;
        }

        .table-container {
            max-height: 500px;
            overflow-y: auto;
            margin-top: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.03);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        table th {
            position: sticky;
            top: 0;
            background-color: #f9fafb;
            border-bottom: 2px solid #e1e5ea;
            color: var(--secondary);
            font-weight: 600;
            padding: 15px;
            text-align: left;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        table td {
            padding: 15px;
            border-bottom: 1px solid #e1e5ea;
            color: var(--dark);
            vertical-align: middle;
        }

        table tr:hover {
            background-color: rgba(244, 246, 249, 0.5);
        }

        .status-available {
            background-color: rgba(46, 204, 113, 0.15);
            color: #2ecc71;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-block;
        }

        .status-ongoing {
            background-color: rgba(52, 152, 219, 0.15);
            color: #3498db;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-block;
        }

        .status-service {
            background-color: rgba(231, 76, 60, 0.15);
            color: #e74c3c;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-block;
        }

        .btn-primary {
            background-color: var(--primary);
            border: none;
            color: white;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 50px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 107, 0, 0.2);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-action {
            width: 36px;
            height: 36px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin-right: 5px;
            transition: all 0.3s ease;
        }

        .btn-edit {
            background-color: rgba(52, 152, 219, 0.15);
            color: #3498db;
        }

        .btn-edit:hover {
            background-color: #3498db;
            color: white;
        }

        .btn-delete {
            background-color: rgba(231, 76, 60, 0.15);
            color: #e74c3c;
        }

        .btn-delete:hover {
            background-color: #e74c3c;
            color: white;
        }

        .error {
            background-color: rgba(231, 76, 60, 0.15);
            color: #e74c3c;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .message {
            background-color: rgba(46, 204, 113, 0.15);
            color: #2ecc71;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 500;
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
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.3s ease-in-out;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            width: 600px;
            max-width: 90%;
            overflow: hidden;
            animation: slideIn 0.4s ease-in-out;
        }

        .modal-header {
            padding: 20px 30px;
            background-color: #f9fafb;
            border-bottom: 1px solid #e1e5ea;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .modal-title {
            margin: 0;
            color: var(--secondary);
            font-size: 1.5rem;
        }

        .close {
            color: var(--gray);
            font-size: 28px;
            font-weight: 300;
            cursor: pointer;
            transition: all 0.2s ease;
            background: none;
            border: none;
            line-height: 1;
        }

        .close:hover {
            color: var(--dark);
        }

        .modal-body {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--secondary);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border-radius: 10px;
            border: 1px solid #e1e5ea;
            background-color: #f9fafb;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            background-color: white;
            box-shadow: 0 0 0 4px rgba(255, 107, 0, 0.1);
        }

        .modal-footer {
            padding: 20px 30px;
            background-color: #f9fafb;
            border-top: 1px solid #e1e5ea;
            text-align: right;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .container-title {
                font-size: 1.5rem;
            }

            .table-responsive {
                width: 100%;
                overflow-x: auto;
            }

            .search-container {
                flex-direction: column;
            }

            .search-input {
                border-radius: 10px;
                margin-bottom: 10px;
            }

            .search-button {
                border-radius: 10px;
                width: 100%;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <div class="container">
        <a class="back-link" href="admin-dashboard.jsp">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
        <a class="navbar-brand" href="#">
            <img src="Assets/images/megacab-logo.svg" alt="MegaCab Logo" onerror="this.src='/api/placeholder/80/40'; this.onerror=null;">
            Mega<span>Cab</span>
        </a>
        <div>
            <span class="fw-bold">Admin: <%= adminUsername %></span>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container main-container">
    <div class="container-header">
        <h1 class="container-title">Manage Vehicles</h1>
        <a href="add-vehicle.jsp" class="btn btn-primary">
            <i class="fas fa-plus me-2"></i>Add Vehicle
        </a>
    </div>

    <div class="container-body">
        <!-- Notifications -->
        <% if (request.getAttribute("error") != null) { %>
        <div class="error">
            <i class="fas fa-exclamation-circle me-2"></i>
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <% if (request.getAttribute("message") != null) { %>
        <div class="message">
            <i class="fas fa-check-circle me-2"></i>
            <%= request.getAttribute("message") %>
        </div>
        <% } %>


        <!-- Vehicle Table -->
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Vehicle Number</th>
                    <th>Color</th>
                    <th>Register Number</th>
                    <th>Model</th>
                    <th>Type</th>
                    <th>Seats</th>
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
                    <td colspan="9" class="text-center py-4">No vehicles found.</td>
                </tr>
                <%
                } else {
                    for (Object obj : vehicles) {
                        com.example.megacitycab.model.Vehicle vehicle = (com.example.megacitycab.model.Vehicle) obj;
                %>
                <tr>
                    <td><%= vehicle.getVehicleId() %></td>
                    <td><%= vehicle.getVehicleNumber() %></td>
                    <td><div style="display: flex; align-items: center;">
                        <span style="display: inline-block; width: 16px; height: 16px; border-radius: 50%; background-color: <%= vehicle.getColor() %>; margin-right: 8px;"></span>
                        <%= vehicle.getColor() %>
                    </div></td>
                    <td><%= vehicle.getRegisterNumber() %></td>
                    <td><%= vehicle.getModel() %></td>
                    <td><%= vehicle.getType() %></td>
                    <td><%= vehicle.getSeatingCapacity() %></td>
                    <td>
                        <% if ("Available".equalsIgnoreCase(vehicle.getStatus())) { %>
                        <span class="status-available">Available</span>
                        <% } else if ("Ongoing".equalsIgnoreCase(vehicle.getStatus())) { %>
                        <span class="status-ongoing">Ongoing</span>
                        <% } else { %>
                        <span class="status-service">Service</span>
                        <% } %>
                    </td>
                    <td>
                        <button class="btn btn-action btn-edit" onclick="openEditModal(<%= vehicle.getVehicleId() %>, '<%= vehicle.getVehicleNumber() %>', '<%= vehicle.getColor() %>', '<%= vehicle.getRegisterNumber() %>', '<%= vehicle.getModel() %>', '<%= vehicle.getType() %>', <%= vehicle.getSeatingCapacity() %>, '<%= vehicle.getStatus() %>')">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-action btn-delete" onclick="confirmDelete(<%= vehicle.getVehicleId() %>)">
                            <i class="fas fa-trash-alt"></i>
                        </button>
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

<!-- Edit Modal -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title"><i class="fas fa-car me-2"></i>Edit Vehicle</h3>
            <button type="button" class="close" onclick="closeEditModal()">&times;</button>
        </div>
        <form id="editForm" method="post" action="view-edit-vehicle">
            <div class="modal-body">
                <input type="hidden" id="editVehicleId" name="vehicleId">
                <input type="hidden" name="action" value="update">

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editVehicleNumber" class="form-label">Vehicle Number</label>
                            <input type="text" id="editVehicleNumber" name="vehicleNumber" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editRegisterNumber" class="form-label">Register Number</label>
                            <input type="text" id="editRegisterNumber" name="registerNumber" class="form-control" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editModel" class="form-label">Model</label>
                            <input type="text" id="editModel" name="model" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editColor" class="form-label">Color</label>
                            <input type="text" id="editColor" name="color" class="form-control">
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editType" class="form-label">Type</label>
                            <select id="editType" name="type" class="form-control" required>
                                <option value="SUV">SUV</option>
                                <option value="Sedan">Sedan</option>
                                <option value="Van">Van</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editSeatingCapacity" class="form-label">Seating Capacity</label>
                            <input type="number" id="editSeatingCapacity" name="seatingCapacity" class="form-control" required>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="editStatus" class="form-label">Status</label>
                    <select id="editStatus" name="status" class="form-control" required>
                        <option value="Available">Available</option>
                        <option value="Ongoing">Ongoing</option>
                        <option value="Service">Service</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Cancel</button>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save me-2"></i>Update Vehicle
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="modal">
    <div class="modal-content" style="max-width: 500px;">
        <div class="modal-header">
            <h3 class="modal-title"><i class="fas fa-exclamation-triangle me-2 text-danger"></i>Confirm Delete</h3>
            <button type="button" class="close" onclick="closeDeleteModal()">&times;</button>
        </div>
        <div class="modal-body text-center py-4">
            <p class="mb-1">Are you sure you want to delete this vehicle?</p>
            <p class="text-muted small">This action cannot be undone.</p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">Cancel</button>
            <a id="deleteLink" href="#" class="btn btn-danger">
                <i class="fas fa-trash-alt me-2"></i>Delete Vehicle
            </a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Edit Modal Functions
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

    // Delete Modal Functions
    function confirmDelete(vehicleId) {
        document.getElementById("deleteLink").href = "view-edit-vehicle?action=delete&vehicleId=" + vehicleId;
        document.getElementById("deleteModal").style.display = "block";
    }

    function closeDeleteModal() {
        document.getElementById("deleteModal").style.display = "none";
    }

    // Close Modal on Outside Click
    window.onclick = function(event) {
        var editModal = document.getElementById("editModal");
        var deleteModal = document.getElementById("deleteModal");

        if (event.target == editModal) {
            editModal.style.display = "none";
        }

        if (event.target == deleteModal) {
            deleteModal.style.display = "none";
        }
    };
</script>
</body>
</html>