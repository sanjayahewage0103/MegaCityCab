package com.example.megacitycab.dao;

import com.example.megacitycab.model.Discount;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiscountDAO {
    private Connection connection;

    public DiscountDAO() throws SQLException {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    public List<Discount> getAllDiscounts() throws SQLException {
        String query = "SELECT * FROM discount";
        List<Discount> discounts = new ArrayList<>();
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Discount discount = new Discount();
                discount.setDiscountId(rs.getInt("discount_id"));
                discount.setVehicleType(rs.getString("vehicle_type"));
                discount.setKmRangeStart(rs.getInt("km_range_start"));
                discount.setKmRangeEnd(rs.getInt("km_range_end"));
                discount.setDiscountPercentage(rs.getDouble("discount_percentage"));
                discount.setStatus(rs.getString("status"));
                discount.setCreatedAt(rs.getTimestamp("created_at"));
                discount.setUpdatedAt(rs.getTimestamp("updated_at"));
                discounts.add(discount);
            }
        }
        return discounts;
    }

    public void addDiscount(Discount discount) throws SQLException {
        String query = "INSERT INTO discount (vehicle_type, km_range_start, km_range_end, discount_percentage, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, discount.getVehicleType());
            stmt.setInt(2, discount.getKmRangeStart());
            stmt.setInt(3, discount.getKmRangeEnd());
            stmt.setDouble(4, discount.getDiscountPercentage());
            stmt.setString(5, discount.getStatus());
            stmt.executeUpdate();
        }
    }

    public void updateDiscount(Discount discount) throws SQLException {
        String query = "UPDATE discount SET vehicle_type = ?, km_range_start = ?, km_range_end = ?, discount_percentage = ?, status = ? WHERE discount_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, discount.getVehicleType());
            stmt.setInt(2, discount.getKmRangeStart());
            stmt.setInt(3, discount.getKmRangeEnd());
            stmt.setDouble(4, discount.getDiscountPercentage());
            stmt.setString(5, discount.getStatus());
            stmt.setInt(6, discount.getDiscountId());
            stmt.executeUpdate();
        }
    }

    public void deleteDiscount(int discountId) throws SQLException {
        String query = "DELETE FROM discount WHERE discount_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, discountId);
            System.out.println("[DEBUG] Executing query: " + query + " with ID: " + discountId);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("[WARNING] No rows deleted. Check if the ID exists in the database.");
            } else {
                System.out.println("[INFO] Rows deleted: " + rowsAffected);
            }
        }
    }
    public int getActiveDiscountCount() throws SQLException {
        String query = "SELECT COUNT(*) AS count FROM discount WHERE status = 'Active'";
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        }
        return 0;
    }

    public int getInactiveDiscountCount() throws SQLException {
        String query = "SELECT COUNT(*) AS count FROM discount WHERE status = 'Inactive'";
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        }
        return 0;
    }
}