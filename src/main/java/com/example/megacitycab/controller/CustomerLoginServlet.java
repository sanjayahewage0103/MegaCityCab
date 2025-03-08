package com.example.megacitycab.controller;

import com.example.megacitycab.service.AuthenticationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class CustomerLoginServlet extends HttpServlet {
    private AuthenticationService authenticationService;

    public CustomerLoginServlet() {
        this.authenticationService = new AuthenticationService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Authenticate the user
        boolean isAuthenticated = authenticationService.authenticateCustomer(email, password);

        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("email", email); // Store email in session
            response.sendRedirect("dashboard.jsp?message=Login successful!");
        } else {
            response.sendRedirect("login.jsp?error=Invalid email or password.");
        }
    }
}