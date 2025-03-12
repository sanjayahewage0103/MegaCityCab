package com.example.megacitycab.dao;

import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;

public class VehicleAssignmentDAO {
    // Assign vehicle and driver to a booking
    public void assignVehicleAndDriver(int bookingId, int vehicleId, int driverId) throws SQLException {
        String query = "INSERT INTO vehicle_assignments (booking_id, vehicle_id, driver_id) VALUES (?, ?, ?)";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            stmt.setInt(2, vehicleId);
            stmt.setInt(3, driverId);
            stmt.executeUpdate();
        }
    }
}