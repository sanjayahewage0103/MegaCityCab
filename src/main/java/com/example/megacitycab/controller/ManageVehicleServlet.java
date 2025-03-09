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
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                vehicleService.deleteVehicle(vehicleId);
                request.setAttribute("message", "Vehicle deleted successfully!");
            }

            String searchQuery = request.getParameter("search");
            List<Vehicle> vehicles = (searchQuery != null && !searchQuery.isEmpty())
                    ? vehicleService.searchVehicles(searchQuery)
                    : vehicleService.getAllVehicles();
            request.setAttribute("vehicles", vehicles);

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
                vehicleService.addVehicle(vehicle);
                request.setAttribute("message", "Vehicle added successfully!");
            } else if ("update".equals(action)) {
                vehicle.setVehicleId(Integer.parseInt(request.getParameter("vehicleId")));
                vehicleService.updateVehicle(vehicle);
                request.setAttribute("message", "Vehicle updated successfully!");
            }

            response.sendRedirect("manage-vehicle?action=view");
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/manage-vehicles.jsp").forward(request, response);
        }
    }
}