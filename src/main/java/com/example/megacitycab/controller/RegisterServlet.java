package com.example.megacitycab.controller;

import com.example.megacitycab.services.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    private CustomerService customerService;

    public RegisterServlet() {
        this.customerService = new CustomerService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String contact = request.getParameter("contact");
        String nic = request.getParameter("nic");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate password and confirm password match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=Password and Confirm Password do not match.");
            return;
        }

        String result = customerService.registerCustomer(name, email, address, contact, nic, password);

        if (result.equals("Registration successful!")) {
            response.sendRedirect("login.jsp?message=" + result);
        } else {
            response.sendRedirect("register.jsp?error=" + result);
        }
    }
}