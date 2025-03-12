package com.example.megacitycab.dao;

import com.example.megacitycab.model.Driver;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {
    private Connection connection;

    public DriverDAO() throws SQLException {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    public List<Driver> getAllDrivers() throws SQLException {
        List<Driver> drivers = new ArrayList<>();
        String query = "SELECT * FROM Drivers";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                drivers.add(new Driver(
                        rs.getInt("driver_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("phone_number"),
                        rs.getString("nic"),
                        rs.getString("license_number"),
                        rs.getString("email"),
                        rs.getString("address"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                ));
            }
        }
        return drivers;
    }

    public boolean isNICExists(String nic) throws SQLException {
        String query = "SELECT COUNT(*) FROM Drivers WHERE nic = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, nic);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public void addDriver(Driver driver) throws SQLException {
        String query = "INSERT INTO Drivers (first_name, last_name, phone_number, nic, license_number, email, address, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, driver.getFirstName());
            stmt.setString(2, driver.getLastName());
            stmt.setString(3, driver.getPhoneNumber());
            stmt.setString(4, driver.getNic());
            stmt.setString(5, driver.getLicenseNumber());
            stmt.setString(6, driver.getEmail());
            stmt.setString(7, driver.getAddress());
            stmt.setString(8, driver.getStatus());
            stmt.executeUpdate();
        }
    }

    public void updateDriver(Driver driver) throws SQLException {
        String query = "UPDATE Drivers SET first_name = ?, last_name = ?, phone_number = ?, nic = ?, license_number = ?, email = ?, address = ?, status = ?, updated_at = NOW() WHERE driver_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, driver.getFirstName());
            stmt.setString(2, driver.getLastName());
            stmt.setString(3, driver.getPhoneNumber());
            stmt.setString(4, driver.getNic());
            stmt.setString(5, driver.getLicenseNumber());
            stmt.setString(6, driver.getEmail());
            stmt.setString(7, driver.getAddress());
            stmt.setString(8, driver.getStatus());
            stmt.setInt(9, driver.getDriverId());
            stmt.executeUpdate();
        }
    }

    public void deleteDriver(int driverId) throws SQLException {
        String query = "DELETE FROM Drivers WHERE driver_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            stmt.executeUpdate();
        }
    }

    public int getTotalDriverCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM Drivers";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public int getActiveDriverCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM Drivers WHERE status = 'active'";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public int getInactiveDriverCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM Drivers WHERE status = 'inactive'";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<Driver> searchDrivers(String query) throws SQLException {
        List<Driver> drivers = new ArrayList<>();
        String sql = "SELECT * FROM Drivers WHERE first_name LIKE ? OR last_name LIKE ? OR nic LIKE ? OR license_number LIKE ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchTerm = "%" + query + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);
            stmt.setString(4, searchTerm);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                drivers.add(new Driver(
                        rs.getInt("driver_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("phone_number"),
                        rs.getString("nic"),
                        rs.getString("license_number"),
                        rs.getString("email"),
                        rs.getString("address"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                ));
            }
        }
        return drivers;
    }


    public List<Driver> getAvailableDrivers() throws SQLException {
        String query = "SELECT * FROM drivers WHERE status = 'Available'";
        List<Driver> drivers = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Driver driver = new Driver();
                driver.setDriverId(rs.getInt("driver_id"));
                driver.setFirstName(rs.getString("first_name"));
                driver.setLastName(rs.getString("last_name"));
                driver.setPhoneNumber(rs.getString("phone_number"));
                drivers.add(driver);
            }
        }
        return drivers;
    }
}