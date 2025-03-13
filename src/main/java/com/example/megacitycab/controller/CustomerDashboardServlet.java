package com.example.megacitycab.controller;

import com.example.megacitycab.dao.CustomerDAO;
import com.example.megacitycab.service.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class CustomerDashboardServlet extends HttpServlet {
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        CustomerDAO customerDAO = new CustomerDAO();
        customerService = new CustomerService(customerDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp?error=You must log in to access the dashboard.");
            return;
        }

        // Retrieve customer ID from session
        int customerId = (int) session.getAttribute("customerId");

        try {
            // Fetch customer statistics
            int totalRides = customerService.getTotalRides(customerId);
            double totalDistance = customerService.getTotalDistance(customerId);
            double totalSavings = customerService.getTotalSavings(customerId);

            // Fetch recent bookings
            List<Map<String, Object>> recentBookings = customerService.getRecentBookings(customerId);

            // Set attributes for the JSP
            request.setAttribute("totalRides", totalRides);
            request.setAttribute("totalDistance", totalDistance);
            request.setAttribute("totalSavings", totalSavings);
            request.setAttribute("recentBookings", recentBookings);

            // Forward to the customer dashboard JSP
            request.getRequestDispatcher("customer-dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Database error occurred while fetching customer data.");
        }
    }
}