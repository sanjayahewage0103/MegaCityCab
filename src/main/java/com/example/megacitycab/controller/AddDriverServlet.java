package com.example.megacitycab.controller;

import com.example.megacitycab.model.Driver;
import com.example.megacitycab.service.DriverService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class AddDriverServlet extends HttpServlet {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
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
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("/add-driver.jsp").forward(request, response);
    }
}