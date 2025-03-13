<%@ page import="com.example.megacitycab.model.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MegaCity Cab - Booking Details</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #ff7e00;
            --secondary: #3a4d6d;
            --light-bg: #f7f9fc;
            --border-radius: 8px;
        }

        .modal-header {
            background-color: var(--primary);
            color: white;
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        .modal-content {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .detail-card {
            background-color: var(--light-bg);
            padding: 20px;
            border-radius: var(--border-radius);
            margin-bottom: 15px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            color: var(--secondary);
        }

        .detail-item i {
            color: var(--primary);
            width: 25px;
            margin-right: 12px;
        }

        .detail-value {
            font-weight: 500;
            margin-left: 5px;
        }

        .section-title {
            color: var(--secondary);
            font-size: 1.2rem;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .bill-highlight {
            background-color: var(--primary);
            color: white;
            padding: 15px;
            border-radius: var(--border-radius);
            font-size: 1.2rem;
            text-align: center;
            font-weight: bold;
        }

        .taxi-logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .taxi-logo i {
            font-size: 2.5rem;
            color: var(--primary);
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: var(--secondary);
        }
    </style>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="activityModal" tabindex="-1" aria-labelledby="activityModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="activityModalLabel">
                    <i class="fas fa-receipt me-2"></i> Trip Receipt
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <%
                    Booking activityDetails = (Booking) request.getAttribute("activityDetails");
                    if (activityDetails != null) {
                %>
                <div class="taxi-logo">
                    <i class="fas fa-taxi"></i>
                    <h4 class="mt-2">MegaCity Cab</h4>
                </div>

                <div class="detail-card">
                    <h6 class="section-title"><i class="fas fa-info-circle me-2"></i>Ride Information</h6>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="detail-item">
                                <i class="fas fa-user"></i>
                                <span>Customer:</span>
                                <span class="detail-value"><%= activityDetails.getCustomerName() %></span>
                            </div>

                            <div class="detail-item">
                                <i class="fas fa-id-card"></i>
                                <span>Driver:</span>
                                <span class="detail-value"><%= activityDetails.getDriverName() %></span>
                            </div>

                            <div class="detail-item">
                                <i class="fas fa-car"></i>
                                <span>Vehicle:</span>
                                <span class="detail-value"><%= activityDetails.getVehicleNumber() %></span>
                            </div>

                            <div class="detail-item">
                                <i class="fas fa-taxi"></i>
                                <span>Type:</span>
                                <span class="detail-value"><%= activityDetails.getVehicleType() %></span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="detail-item">
                                <i class="fas fa-calendar"></i>
                                <span>Date:</span>
                                <span class="detail-value"><%= activityDetails.getDate() %></span>
                            </div>

                            <div class="detail-item">
                                <i class="fas fa-clock"></i>
                                <span>Time:</span>
                                <span class="detail-value"><%= activityDetails.getTime() %></span>
                            </div>

                            <div class="detail-item">
                                <i class="fas fa-credit-card"></i>
                                <span>Payment:</span>
                                <span class="detail-value"><%= activityDetails.getPaymentMethod() %></span>
                            </div>

                            <div class="detail-item">
                                <i class="fas fa-route"></i>
                                <span>Distance:</span>
                                <span class="detail-value"><%= activityDetails.getTotalDistance() %> km</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="detail-card">
                    <h6 class="section-title"><i class="fas fa-map-marker-alt me-2"></i>Trip Details</h6>

                    <div class="detail-item">
                        <i class="fas fa-map-pin"></i>
                        <span>From:</span>
                        <span class="detail-value"><%= activityDetails.getPickupLocation() %></span>
                    </div>

                    <div class="detail-item">
                        <i class="fas fa-map-marker"></i>
                        <span>To:</span>
                        <span class="detail-value"><%= activityDetails.getDropLocation() %></span>
                    </div>
                </div>

                <div class="bill-highlight mt-4">
                    <i class="fas fa-dollar-sign me-2"></i> Total Fare: $<%= activityDetails.getFinalAmount() %>
                </div>

                <div class="text-center mt-4">
                    <p class="text-muted small">Thank you for choosing MegaCity Cab!</p>
                </div>

                <% } else { %>
                <div class="empty-state">
                    <i class="fas fa-exclamation-circle" style="font-size: 3rem; color: var(--primary);"></i>
                    <h5 class="mt-3">No activity details found</h5>
                    <p class="text-muted">The requested booking information is not available.</p>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>