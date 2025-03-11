package com.example.megacitycab.dao;

import com.example.megacitycab.model.VehicleAssignment;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleAssignmentDAO {
    private Connection connection;

    public VehicleAssignmentDAO() throws SQLException {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Add a new vehicle assignment
    public void addVehicleAssignment(VehicleAssignment assignment) throws SQLException {
        String query = "INSERT INTO vehicle_assignments (booking_id, vehicle_id, driver_id, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, assignment.getBookingId());
            stmt.setInt(2, assignment.getVehicleId());
            stmt.setInt(3, assignment.getDriverId());
            stmt.setString(4, assignment.getStatus());
            stmt.executeUpdate();
        }
    }

    // Get all vehicle assignments
    public List<VehicleAssignment> getAllAssignments() throws SQLException {
        String query = "SELECT * FROM vehicle_assignments";
        List<VehicleAssignment> assignments = new ArrayList<>();
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                VehicleAssignment assignment = new VehicleAssignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setBookingId(rs.getInt("booking_id"));
                assignment.setVehicleId(rs.getInt("vehicle_id"));
                assignment.setDriverId(rs.getInt("driver_id"));
                assignment.setAssignedAt(rs.getTimestamp("assigned_at"));
                assignment.setStatus(rs.getString("status"));
                assignments.add(assignment);
            }
        }
        return assignments;
    }

    // Update assignment status
    public void updateAssignmentStatus(int assignmentId, String status) throws SQLException {
        String query = "UPDATE vehicle_assignments SET status = ? WHERE assignment_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, assignmentId);
            stmt.executeUpdate();
        }
    }

    // Delete an assignment
    public void deleteAssignment(int assignmentId) throws SQLException {
        String query = "DELETE FROM vehicle_assignments WHERE assignment_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, assignmentId);
            stmt.executeUpdate();
        }
    }
}