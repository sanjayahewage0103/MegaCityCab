package com.example.megacitycab.dao;

import com.example.megacitycab.model.Distance;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DistanceDAO {
    private Connection connection;

    public DistanceDAO() throws SQLException {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Add a new distance record
    public void addDistance(Distance distance) throws SQLException {
        String query = "INSERT INTO distances (location_from, location_to, distance_km) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, distance.getLocationFrom());
            stmt.setString(2, distance.getLocationTo());
            stmt.setDouble(3, distance.getDistanceKm());
            stmt.executeUpdate();
        }
    }

    // Get all distances
    public List<Distance> getAllDistances() throws SQLException {
        String query = "SELECT * FROM distances";
        List<Distance> distances = new ArrayList<>();
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Distance distance = new Distance();
                distance.setId(rs.getInt("id"));
                distance.setLocationFrom(rs.getString("location_from"));
                distance.setLocationTo(rs.getString("location_to"));
                distance.setDistanceKm(rs.getDouble("distance_km"));
                distances.add(distance);
            }
        }
        return distances;
    }

    // Get distance between two locations
    public double getDistance(String locationFrom, String locationTo) throws SQLException {
        String query = "SELECT distance_km FROM distances WHERE location_from = ? AND location_to = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, locationFrom);
            stmt.setString(2, locationTo);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("distance_km");
            }
        }
        return 0; // Return 0 if no distance is found
    }

    // Update distance
    public void updateDistance(int id, double distanceKm) throws SQLException {
        String query = "UPDATE distances SET distance_km = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setDouble(1, distanceKm);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        }
    }

    // Delete a distance record
    public void deleteDistance(int id) throws SQLException {
        String query = "DELETE FROM distances WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}