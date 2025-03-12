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

    // Fetch vehicle_id and driver_id by booking_id
    public int[] getAssignmentDetailsByBookingId(int bookingId) throws SQLException {
        String query = "SELECT vehicle_id, driver_id FROM vehicle_assignments WHERE booking_id = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int vehicleId = rs.getInt("vehicle_id");
                int driverId = rs.getInt("driver_id");
                return new int[]{vehicleId, driverId};
            }
        }
        throw new SQLException("No vehicle assignment found for booking ID: " + bookingId);
    }
}