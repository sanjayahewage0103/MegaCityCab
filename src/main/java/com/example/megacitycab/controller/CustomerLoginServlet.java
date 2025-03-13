package com.example.megacitycab.controller;

import com.example.megacitycab.service.AuthenticationService;
import com.example.megacitycab.dao.CustomerDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class CustomerLoginServlet extends HttpServlet {
    private AuthenticationService authenticationService;
    private CustomerDAO customerDAO;

    public CustomerLoginServlet() {
        this.authenticationService = new AuthenticationService();
        this.customerDAO = new CustomerDAO(); // Initialize the CustomerDAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean isAuthenticated = authenticationService.authenticateCustomer(email, password);

        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("email", email); // Store email in session

            int customerId = customerDAO.getCustomerIdByEmail(email);
            session.setAttribute("customerId", customerId);

            response.sendRedirect("customer-dashboard?message=Login successful!");
        } else {
            response.sendRedirect("login.jsp?error=Invalid email or password.");
        }
    }
}