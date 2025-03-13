package com.example.megacitycab.dao;

import com.example.megacitycab.model.Customer;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        return null;
    }

    public int getCustomerIdByEmail(String email) {
        String query = "SELECT customer_id FROM customer WHERE email = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("customer_id");
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving customerId: " + e.getMessage());
        }
        return -1;
    }


    public int getTotalRides(int customerId) throws SQLException {
        String query = """
            SELECT COUNT(*) AS total_rides
            FROM bookings
            WHERE customer_id = ? AND status = 'Confirmed'
        """;
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("total_rides");
            }
        }
        return 0;
    }

    // Fetch total distance traveled for a specific customer
    public double getTotalDistance(int customerId) throws SQLException {
        String query = """
            SELECT SUM(total_distance) AS total_distance
            FROM bookings
            WHERE customer_id = ? AND status = 'Confirmed'
        """;
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("total_distance");
            }
        }
        return 0.0;
    }

    // Fetch total savings with promos for a specific customer
    public double getTotalSavings(int customerId) throws SQLException {
        String query = """
            SELECT SUM(discount_amount) AS total_savings
            FROM bookings
            WHERE customer_id = ? AND promo_code_used IS NOT NULL
        """;
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("total_savings");
            }
        }
        return 0.0;
    }

    public List<Map<String, Object>> getRecentBookings(int customerId) throws SQLException {
        String query = """
        SELECT 
            date, 
            pickup_location AS from_location, 
            drop_location AS to_location, 
            final_amount, 
            status 
        FROM 
            bookings 
        WHERE 
            customer_id = ? 
        ORDER BY 
            date DESC 
        LIMIT 5
    """;
        List<Map<String, Object>> recentBookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("date", rs.getDate("date"));
                booking.put("fromLocation", rs.getString("from_location"));
                booking.put("toLocation", rs.getString("to_location"));
                booking.put("amount", rs.getDouble("final_amount"));
                booking.put("status", rs.getString("status"));
                recentBookings.add(booking);
            }
        }
        return recentBookings;
    }

}