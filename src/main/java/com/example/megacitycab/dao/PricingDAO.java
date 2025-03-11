package com.example.megacitycab.dao;

import com.example.megacitycab.model.Pricing;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PricingDAO {
    private Connection connection;

    public PricingDAO() throws SQLException {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    public List<Pricing> getAllPricings() throws SQLException {
        String query = "SELECT * FROM pricing";
        List<Pricing> pricings = new ArrayList<>();
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Pricing pricing = new Pricing();
                pricing.setPricingId(rs.getInt("pricing_id"));
                pricing.setVehicleType(rs.getString("vehicle_type"));
                pricing.setTaxPercentage(rs.getDouble("tax_percentage"));
                pricing.setPricePerKmBelow10(rs.getDouble("price_per_km_below_10"));
                pricing.setPricePerKm10To20(rs.getDouble("price_per_km_10_to_20"));
                pricing.setPricePerKm20To50(rs.getDouble("price_per_km_20_to_50"));
                pricing.setPricePerKmAbove50(rs.getDouble("price_per_km_above_50"));
                pricing.setCreatedAt(rs.getTimestamp("created_at"));
                pricing.setUpdatedAt(rs.getTimestamp("updated_at"));
                pricings.add(pricing);
            }
        }
        return pricings;
    }

    public void updatePricing(Pricing pricing) throws SQLException {
        String query = "UPDATE pricing SET tax_percentage = ?, price_per_km_below_10 = ?, price_per_km_10_to_20 = ?, price_per_km_20_to_50 = ?, price_per_km_above_50 = ? WHERE pricing_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setDouble(1, pricing.getTaxPercentage());
            stmt.setDouble(2, pricing.getPricePerKmBelow10());
            stmt.setDouble(3, pricing.getPricePerKm10To20());
            stmt.setDouble(4, pricing.getPricePerKm20To50());
            stmt.setDouble(5, pricing.getPricePerKmAbove50());
            stmt.setInt(6, pricing.getPricingId());
            stmt.executeUpdate();
        }
    }

    // Fetch pricing rule by vehicle type
    public Pricing getPricingByVehicleType(String vehicleType) throws SQLException {
        String query = "SELECT * FROM pricing WHERE vehicle_type = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, vehicleType);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Pricing pricing = new Pricing();
                pricing.setPricingId(rs.getInt("pricing_id"));
                pricing.setVehicleType(rs.getString("vehicle_type"));
                pricing.setTaxPercentage(rs.getDouble("tax_percentage"));
                pricing.setPricePerKmBelow10(rs.getDouble("price_per_km_below_10"));
                pricing.setPricePerKm10To20(rs.getDouble("price_per_km_10_to_20"));
                pricing.setPricePerKm20To50(rs.getDouble("price_per_km_20_to_50"));
                pricing.setPricePerKmAbove50(rs.getDouble("price_per_km_above_50"));
                return pricing;
            }
        }
        return null; // Return null if no pricing is found
    }
}