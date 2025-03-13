package com.example.megacitycab.service;

import com.example.megacitycab.dao.CustomerDAO;
import com.example.megacitycab.model.Customer;
import com.example.megacitycab.factory.UserFactory;
import com.example.megacitycab.util.PasswordHasher;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class CustomerService {
    private CustomerDAO customerDAO;

    // Constructor that accepts a CustomerDAO object
    public CustomerService(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    // Default constructor (if needed for other use cases)
    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }

    public String registerCustomer(String name, String email, String address, String contact, String nic, String password) {
        // Validate inputs
        if (name == null || name.trim().isEmpty()) {
            return "Name is required.";
        }
        if (!isValidEmail(email)) {
            return "Invalid email format.";
        }
        if (address == null || address.trim().isEmpty()) {
            return "Address is required.";
        }
        if (!isValidContact(contact)) {
            return "Invalid contact number. Must be numeric and 10 digits long.";
        }
        if (!isValidNic(nic)) {
            return "Invalid NIC. Must be unique and follow the correct format.";
        }
        if (!isValidPassword(password)) {
            return "Password must be at least 6 characters long.";
        }

        // Check if NIC already exists
        if (customerDAO.isNicExists(nic)) {
            return "NIC already registered.";
        }

        // Hash the password before storing it
        String hashedPassword = PasswordHasher.hashPassword(password);

        // Create and register the customer
        Customer customer = UserFactory.createCustomer(name, email, address, contact, nic, hashedPassword);
        boolean isRegistered = customerDAO.registerCustomer(customer);

        return isRegistered ? "Registration successful!" : "Registration failed. Please try again.";
    }

    // Email validation
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email != null && email.matches(emailRegex);
    }

    // Contact validation
    private boolean isValidContact(String contact) {
        return contact != null && contact.matches("\\d{10}");
    }

    // NIC validation
    private boolean isValidNic(String nic) {
        return nic != null && nic.length() >= 10; // Example: NIC should be at least 10 characters
    }

    // Password validation
    private boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    public int getTotalRides(int customerId) throws SQLException {
        return customerDAO.getTotalRides(customerId);
    }

    // Fetch total distance traveled for a specific customer
    public double getTotalDistance(int customerId) throws SQLException {
        return customerDAO.getTotalDistance(customerId);
    }

    // Fetch total savings with promos for a specific customer
    public double getTotalSavings(int customerId) throws SQLException {
        return customerDAO.getTotalSavings(customerId);
    }

    public List<Map<String, Object>> getRecentBookings(int customerId) throws SQLException {
        return customerDAO.getRecentBookings(customerId);
    }
}