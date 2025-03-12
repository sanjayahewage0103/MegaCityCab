package com.example.megacitycab.dao;

import com.example.megacitycab.model.Distance;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.HashSet;
import java.util.Set;

public class DistanceDAO {
    private Connection connection;

    public DistanceDAO() throws SQLException {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Get distance between two locations
    public double getDistance(String locationFrom, String locationTo) throws SQLException {
        String query = "SELECT distance_km FROM distances WHERE location_from = ? AND location_to = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, locationFrom);
            stmt.setString(2, locationTo);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("distance_km");
            }
        }
        return 0;
    }

    // Fetch all unique locations (from and to)
    public Set<String> getAllUniqueLocations() throws SQLException {
        String query = "SELECT DISTINCT location_from FROM distances UNION SELECT DISTINCT location_to FROM distances";
        Set<String> locations = new HashSet<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                locations.add(rs.getString(1));
            }
        }
        return locations;
    }
}