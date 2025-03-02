package com.example.megacitycab.dao;

import com.example.megacitycab.model.Customer;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAO {
    // Method to register a new customer
    public boolean registerCustomer(Customer customer) {
        String query = "INSERT INTO customer (name, email, address, contact, nic, password) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            // Set parameters for the prepared statement
            statement.setString(1, customer.getName());
            statement.setString(2, customer.getEmail());
            statement.setString(3, customer.getAddress());
            statement.setString(4, customer.getContact());
            statement.setString(5, customer.getNic());
            statement.setString(6, customer.getPassword());

            // Execute the query and check the result
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error executing SQL query: " + e.getMessage());
            return false;
        }
    }

    // Method to check if NIC already exists
    public boolean isNicExists(String nic) {
        String query = "SELECT COUNT(*) FROM customer WHERE nic = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, nic);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.err.println("Error checking NIC existence: " + e.getMessage());
        }
        return false;
    }

    // Method to retrieve hashed password by email
    public String getHashedPasswordByEmail(String email) {
        String query = "SELECT password FROM customer WHERE email = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getString("password");
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving hashed password: " + e.getMessage());
        }
        return null; // Email not found
    }

}