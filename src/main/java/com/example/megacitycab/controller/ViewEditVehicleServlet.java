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

public class ViewEditVehicleServlet extends HttpServlet {

    private final VehicleService vehicleService;

    public ViewEditVehicleServlet() {
        this.vehicleService = new VehicleService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("delete".equals(action)) {
                // Delete a vehicle by ID
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
            request.setAttribute("vehicles", vehicles);

            // Forward to the view-vehicle.jsp page
            request.getRequestDispatcher("/view-vehicle.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/view-vehicle.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("update".equals(action)) {
                // Update an existing vehicle
                Vehicle vehicle = new Vehicle();
                vehicle.setVehicleId(Integer.parseInt(request.getParameter("vehicleId")));
                vehicle.setVehicleNumber(request.getParameter("vehicleNumber"));
                vehicle.setColor(request.getParameter("color"));
                vehicle.setRegisterNumber(request.getParameter("registerNumber"));
                vehicle.setModel(request.getParameter("model"));
                vehicle.setType(request.getParameter("type"));
                vehicle.setSeatingCapacity(Integer.parseInt(request.getParameter("seatingCapacity")));
                vehicle.setStatus(request.getParameter("status"));

                boolean isUpdated = vehicleService.updateVehicle(vehicle);
                if (isUpdated) {
                    request.setAttribute("message", "Vehicle updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update the vehicle.");
                }
            }

            // Redirect back to the view-vehicle page
            response.sendRedirect("view-edit-vehicle?action=view");
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/view-vehicle.jsp").forward(request, response);
        }
    }
}