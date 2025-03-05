package com.example.megacitycab.controller;

import com.example.megacitycab.services.AdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AdminLoginServlet extends HttpServlet {
    private AdminService adminService;

    public AdminLoginServlet() {
        this.adminService = new AdminService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Authenticate admin using the service layer
        boolean isAuthenticated = adminService.authenticateAdmin(username, password);

        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", username); // Store admin username in session
            response.sendRedirect("admin-dashboard.jsp?message=Admin login successful!");
        } else {
            // Redirect back to the login page with an error message
            response.sendRedirect("admin-login.jsp?error=Invalid admin credentials.");
        }
    }
}