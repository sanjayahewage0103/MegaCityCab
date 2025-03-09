package com.example.megacitycab.controller;

import com.example.megacitycab.model.Vehicle;
import com.example.megacitycab.service.VehicleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ManageVehicleServlet extends HttpServlet {

    private final VehicleService vehicleService;

    public ManageVehicleServlet() {
        this.vehicleService = new VehicleService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("delete".equals(action)) {
                // Handle Delete Action
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                boolean isDeleted = vehicleService.deleteVehicle(vehicleId);
                if (isDeleted) {
                    request.setAttribute("message", "Vehicle deleted successfully!");
                } else {
                    request.setAttribute("error", "Failed to delete the vehicle.");
                }
            }

            // Fetch all vehicles
            List<Vehicle> vehicles = vehicleService.getAllVehicles();

            // Calculate counts for each status
            int totalVehicles = vehicles.size();
            int availableVehicles = 0;
            int ongoingVehicles = 0;
            int maintenanceVehicles = 0;

            for (Vehicle vehicle : vehicles) {
                switch (vehicle.getStatus()) {
                    case "Available":
                        availableVehicles++;
                        break;
                    case "Ongoing":
                        ongoingVehicles++;
                        break;
                    case "Service":
                        maintenanceVehicles++;
                        break;
                }
            }

            // Set counts as request attributes
            request.setAttribute("totalVehicles", totalVehicles);
            request.setAttribute("availableVehicles", availableVehicles);
            request.setAttribute("ongoingVehicles", ongoingVehicles);
            request.setAttribute("maintenanceVehicles", maintenanceVehicles);

            // Handle Search Query
            String searchQuery = request.getParameter("search");
            if (searchQuery != null && !searchQuery.isEmpty()) {
                vehicles = vehicleService.searchVehicles(searchQuery);
            }

            // Set vehicles as request attribute
            request.setAttribute("vehicles", vehicles);

            // Forward to JSP
            request.getRequestDispatcher("/manage-vehicles.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/manage-vehicles.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            Vehicle vehicle = new Vehicle();
            vehicle.setVehicleNumber(request.getParameter("vehicleNumber"));
            vehicle.setColor(request.getParameter("color"));
            vehicle.setRegisterNumber(request.getParameter("registerNumber"));
            vehicle.setModel(request.getParameter("model"));
            vehicle.setType(request.getParameter("type"));
            vehicle.setSeatingCapacity(Integer.parseInt(request.getParameter("seatingCapacity")));
            vehicle.setStatus(request.getParameter("status"));

            if ("add".equals(action)) {
                // Add New Vehicle
                boolean isAdded = vehicleService.addVehicle(vehicle);
                if (isAdded) {
                    request.setAttribute("message", "Vehicle added successfully!");
                } else {
                    request.setAttribute("error", "Failed to add the vehicle.");
                }
            } else if ("update".equals(action)) {
                // Update Existing Vehicle
                vehicle.setVehicleId(Integer.parseInt(request.getParameter("vehicleId")));
                boolean isUpdated = vehicleService.updateVehicle(vehicle);
                if (isUpdated) {
                    request.setAttribute("message", "Vehicle updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update the vehicle.");
                }
            }

            // Redirect to the same page to refresh data
            response.sendRedirect("manage-vehicle?action=view");
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/manage-vehicles.jsp").forward(request, response);
        }
    }
}