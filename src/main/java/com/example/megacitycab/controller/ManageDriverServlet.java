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

public class ManageDriverServlet extends HttpServlet {
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
        String action = request.getParameter("action");

        try {
            if ("delete".equals(action)) {
                // Handle delete action
                int driverId = Integer.parseInt(request.getParameter("driverId"));
                driverService.deleteDriver(driverId);
            }

            // Fetch all drivers from the database
            List<Driver> drivers = driverService.getAllDrivers();
            request.setAttribute("drivers", drivers);

            // Forward the request to the JSP
            request.getRequestDispatcher("/manage-drivers.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/manage-drivers.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("update".equals(action)) {
                // Handle update action
                Driver driver = new Driver();
                driver.setDriverId(Integer.parseInt(request.getParameter("driverId")));
                driver.setFirstName(request.getParameter("firstName"));
                driver.setLastName(request.getParameter("lastName"));
                driver.setPhoneNumber(request.getParameter("phoneNumber"));
                driver.setNic(request.getParameter("nic"));
                driver.setLicenseNumber(request.getParameter("licenseNumber"));
                driver.setEmail(request.getParameter("email"));
                driver.setAddress(request.getParameter("address"));
                driver.setStatus(request.getParameter("status"));

                driverService.updateDriver(driver);
                request.setAttribute("message", "Driver updated successfully!");
            }

            // Redirect back to the doGet method to refresh the page
            response.sendRedirect(request.getContextPath() + "/manage-driver");
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/manage-drivers.jsp").forward(request, response);
        }
    }
}