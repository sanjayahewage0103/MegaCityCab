<%@ page import="com.example.megacitycab.model.Payment" %>
<%@ page import="java.util.List" %>
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
    <title>Manage Payments | MegaCab</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #FF4500; /* Intense Orange-Red */
            --primary-dark: #C43E00; /* Darker shade */
            --secondary: #2C3E50;
            --accent: #FF6347; /* Tomato Red */
            --dark-bg: #f9fafb;
            --dark-text: #1A1A1A;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--dark-bg);
            color: var(--dark-text);
            line-height: 1.6;
        }
        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 15px 0;
        }
        .navbar-brand {
            font-family: 'Poppins', sans-serif;
            font-weight: 700;
            color: var(--secondary);
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
        .nav-pills .nav-link {
            color: var(--secondary);
            font-weight: 500;
            border-radius: 50px;
            margin-right: 10px;
        }
        .nav-pills .nav-link.active {
            background-color: var(--primary);
            color: white;
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
            color: var(--dark-text);
            vertical-align: middle;
        }
        table tr:hover {
            background-color: rgba(244, 246, 249, 0.5);
        }
        .status-active {
            background-color: rgba(46, 204, 113, 0.15);
            color: #2ecc71;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-block;
        }
        .status-inactive {
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
        .summary-card {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            overflow: hidden;
            margin-bottom: 20px;
        }
        .summary-card .card-body {
            text-align: center;
            padding: 25px;
        }
        .summary-card i {
            color: var(--primary);
            margin-bottom: 15px;
        }
        .summary-card .card-title {
            color: var(--dark-text);
            font-weight: 600;
            margin-bottom: 10px;
        }
        .summary-card .card-text {
            color: var(--accent);
            font-size: 1.5rem;
            font-weight: 700;
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
        <h1 class="container-title">Manage Payments</h1>
        <ul class="nav nav-pills">
            <li class="nav-item">
                <a class="nav-link active" href="#" onclick="showFragment('all')">All Payments</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" onclick="showFragment('pending')">Pending Payments</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" onclick="showFragment('completed')">Completed Payments</a>
            </li>
        </ul>
    </div>
    <div class="container-body">
        <!-- Summary Statistics Section -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="summary-card">
                    <div class="card-body">
                        <i class="fas fa-dollar-sign fa-3x mb-3"></i>
                        <h5 class="card-title">Total Income</h5>
                        <p class="card-text">$<%= request.getAttribute("totalIncome") %></p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-card">
                    <div class="card-body">
                        <i class="fas fa-clock fa-3x mb-3"></i>
                        <h5 class="card-title">Total Pending Income</h5>
                        <p class="card-text">$<%= request.getAttribute("totalPendingIncome") %></p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-card">
                    <div class="card-body">
                        <i class="fas fa-check-circle fa-3x mb-3"></i>
                        <h5 class="card-title">Total Completed Income</h5>
                        <p class="card-text">$<%= request.getAttribute("totalCompletedIncome") %></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Payment Fragments -->
        <div id="payment-fragments">
            <!-- All Payments Fragment -->
            <div id="all-payments" class="fragment">
                <h4 class="mb-3">All Payments</h4>
                <div class="table-container">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Customer ID</th>
                            <th>Vehicle Type</th>
                            <th>Final Amount</th>
                            <th>Payment Method</th>
                            <th>Payment Status</th>
                            <th>Transaction ID</th>
                            <th>Encrypted Details</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Payment> allPayments = (List<Payment>) request.getAttribute("allPayments");
                            if (allPayments != null && !allPayments.isEmpty()) {
                                for (Payment payment : allPayments) {
                        %>
                        <tr>
                            <td><%= payment.getBookingId() %></td>
                            <td><%= payment.getCustomerId() %></td>
                            <td><%= payment.getVehicleType() %></td>
                            <td>$<%= payment.getFinalAmount() %></td>
                            <td><%= payment.getPaymentMethod() %></td>
                            <td>
                                <% if ("Success".equalsIgnoreCase(payment.getPaymentStatus())) { %>
                                <span class="status-active">Completed</span>
                                <% } else { %>
                                <span class="status-inactive">Pending</span>
                                <% } %>
                            </td>
                            <td><%= payment.getTransactionId() %></td>
                            <td><%= payment.getEncryptedDetails() %></td>
                            <td>
                                <form action="admin-manage-payments" method="get" style="display:inline;">
                                    <input type="hidden" name="action" value="viewDetails">
                                    <input type="hidden" name="bookingId" value="<%= payment.getBookingId() %>">
                                    <button type="submit" class="btn btn-primary btn-sm">View Details</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="9" class="text-center">No payments found.</td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Pending Payments Fragment -->
            <div id="pending-payments" class="fragment" style="display:none;">
                <h4 class="mb-3">Pending Payments</h4>
                <div class="table-container">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Customer Name</th>
                            <th>Vehicle Type</th>
                            <th>Pickup Location</th>
                            <th>Drop Location</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Final Amount</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Payment> pendingPayments = (List<Payment>) request.getAttribute("pendingPayments");
                            if (pendingPayments != null && !pendingPayments.isEmpty()) {
                                for (Payment payment : pendingPayments) {
                        %>
                        <tr>
                            <td><%= payment.getBookingId() %></td>
                            <td><%= payment.getCustomerName() %></td>
                            <td><%= payment.getVehicleType() %></td>
                            <td><%= payment.getPickupLocation() %></td>
                            <td><%= payment.getDropLocation() %></td>
                            <td><%= payment.getDate() %></td>
                            <td><%= payment.getTime() %></td>
                            <td>$<%= payment.getFinalAmount() %></td>
                            <td>
                                <form action="admin-manage-payments" method="get" style="display:inline;">
                                    <input type="hidden" name="action" value="viewDetails">
                                    <input type="hidden" name="bookingId" value="<%= payment.getBookingId() %>">
                                    <button type="submit" class="btn btn-primary btn-sm">View Details</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="9" class="text-center">No pending payments found.</td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Completed Payments Fragment -->
            <div id="completed-payments" class="fragment" style="display:none;">
                <h4 class="mb-3">Completed Payments</h4>
                <div class="table-container">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Customer ID</th>
                            <th>Vehicle Type</th>
                            <th>Final Amount</th>
                            <th>Payment Method</th>
                            <th>Payment Status</th>
                            <th>Transaction ID</th>
                            <th>Encrypted Details</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                            <%
                            List<Payment> completedPayments = (List<Payment>) request.getAttribute("completedPayments");
                            if (completedPayments != null && !completedPayments.isEmpty()) {
                                for (Payment payment : completedPayments) {
                        %>
                        <tr>
                            <td><%= payment.getBookingId() %></td>
                            <td><%= payment.getCustomerId() %></td>
                            <td><%= payment.getVehicleType() %></td>
                            <td>$<%= payment.getFinalAmount() %></td>
                            <td><%= payment.getPaymentMethod() %></td>
                            <td><%= payment.getPaymentStatus() %></td>
                            <td><%= payment.getTransactionId() %></td>
                            <td><%= payment.getEncryptedDetails() %></td>
                            <td>
                                <form action="admin-manage-payments" method="get" style="display:inline;">
                                    <input type="hidden" name="action" value="viewDetails">
                                    <input type="hidden" name="bookingId" value="<%= payment.getBookingId() %>">
                                    <button type="submit" class="btn btn-primary btn-sm">View Details</button>
                                </form>
                            </td>
                        </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="9" class="text-center">No completed payments found.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript for Fragment Navigation -->
<script>
    function showFragment(fragment) {
        // Hide all fragments
        document.querySelectorAll('.fragment').forEach(function (element) {
            element.style.display = 'none';
        });

        // Show the selected fragment
        document.getElementById(fragment + '-payments').style.display = 'block';

        // Update active navigation link
        document.querySelectorAll('.nav-pills .nav-link').forEach(function (link) {
            link.classList.remove('active');
        });
        document.querySelector(`.nav-pills .nav-link[href="#"][onclick*="showFragment('${fragment}')"]`).classList.add('active');
    }

    // Initialize the default fragment
    document.addEventListener('DOMContentLoaded', function () {
        showFragment('all'); // Default to "All Payments"
    });
</script>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>        <