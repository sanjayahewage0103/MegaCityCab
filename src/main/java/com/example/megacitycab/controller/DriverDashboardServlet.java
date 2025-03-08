package com.example.megacitycab.controller;

import com.example.megacitycab.model.Driver;
import com.example.megacitycab.service.DriverService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class DriverDashboardServlet extends HttpServlet {
    private DriverService driverService;

    @Override
    public void init() throws ServletException {
        try {
            driverService = new DriverService();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize DriverService", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Handle search query
            String searchQuery = request.getParameter("search");
            List<Driver> drivers;

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                drivers = driverService.searchDrivers(searchQuery);
            } else {
                drivers = driverService.getAllDrivers();
            }

            // Fetch counts
            int totalDrivers = driverService.getTotalDriverCount();
            int activeDrivers = driverService.getActiveDriverCount();
            int inactiveDrivers = driverService.getInactiveDriverCount();

            // Set attributes for JSP
            request.setAttribute("totalDrivers", totalDrivers);
            request.setAttribute("activeDrivers", activeDrivers);
            request.setAttribute("inactiveDrivers", inactiveDrivers);
            request.setAttribute("drivers", drivers);

            // Forward to the JSP
            request.getRequestDispatcher("/driver-dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/driver-dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                // Add new driver
                Driver driver = new Driver();
                driver.setFirstName(request.getParameter("firstName"));
                driver.setLastName(request.getParameter("lastName"));
                driver.setPhoneNumber(request.getParameter("phoneNumber"));
                driver.setNic(request.getParameter("nic"));
                driver.setLicenseNumber(request.getParameter("licenseNumber"));
                driver.setEmail(request.getParameter("email"));
                driver.setAddress(request.getParameter("address"));
                driver.setStatus(request.getParameter("status"));

                driverService.addDriver(driver);
                request.setAttribute("message", "Driver added successfully!");
            }

            // Redirect back to the dashboard with the success message
            doGet(request, response); // Reuse doGet to refresh the page
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            doGet(request, response); // Reuse doGet to refresh the page
        }
    }
}