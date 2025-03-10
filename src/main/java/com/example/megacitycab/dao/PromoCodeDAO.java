package com.example.megacitycab.dao;

import com.example.megacitycab.model.PromoCode;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PromoCodeDAO {
    private Connection connection;

    public PromoCodeDAO() throws SQLException {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    public void addPromoCode(PromoCode promoCode) throws SQLException {
        String query = "INSERT INTO promo_codes (promo_code, discount_percentage, valid_from, valid_until, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, promoCode.getPromoCode());
            stmt.setDouble(2, promoCode.getDiscountPercentage());
            stmt.setDate(3, promoCode.getValidFrom());
            stmt.setDate(4, promoCode.getValidUntil());
            stmt.setString(5, promoCode.getStatus());
            stmt.executeUpdate();
        }
    }

    public List<PromoCode> getAllPromoCodes() throws SQLException {
        String query = "SELECT * FROM promo_codes";
        List<PromoCode> promoCodes = new ArrayList<>();
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                PromoCode promoCode = new PromoCode();
                promoCode.setId(rs.getInt("id"));
                promoCode.setPromoCode(rs.getString("promo_code"));
                promoCode.setDiscountPercentage(rs.getDouble("discount_percentage"));
                promoCode.setValidFrom(rs.getDate("valid_from"));
                promoCode.setValidUntil(rs.getDate("valid_until"));
                promoCode.setStatus(rs.getString("status"));
                promoCodes.add(promoCode);
            }
        }
        return promoCodes;
    }

    public List<PromoCode> searchPromoCodes(String searchTerm) throws SQLException {
        String query = "SELECT * FROM promo_codes WHERE promo_code LIKE ? OR status LIKE ?";
        List<PromoCode> promoCodes = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, "%" + searchTerm + "%");
            stmt.setString(2, "%" + searchTerm + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                PromoCode promoCode = new PromoCode();
                promoCode.setId(rs.getInt("id"));
                promoCode.setPromoCode(rs.getString("promo_code"));
                promoCode.setDiscountPercentage(rs.getDouble("discount_percentage"));
                promoCode.setValidFrom(rs.getDate("valid_from"));
                promoCode.setValidUntil(rs.getDate("valid_until"));
                promoCode.setStatus(rs.getString("status"));
                promoCodes.add(promoCode);
            }
        }
        return promoCodes;
    }

    public void updatePromoCode(PromoCode promoCode) throws SQLException {
        String query = "UPDATE promo_codes SET promo_code = ?, discount_percentage = ?, valid_from = ?, valid_until = ?, status = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, promoCode.getPromoCode());
            stmt.setDouble(2, promoCode.getDiscountPercentage());
            stmt.setDate(3, promoCode.getValidFrom());
            stmt.setDate(4, promoCode.getValidUntil());
            stmt.setString(5, promoCode.getStatus());
            stmt.setInt(6, promoCode.getId());
            stmt.executeUpdate();
        }
    }

    public void deletePromoCode(int id) throws SQLException {
        String query = "DELETE FROM promo_codes WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public int getTotalPromoCodes() throws SQLException {
        String query = "SELECT COUNT(*) AS total FROM promo_codes";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    public int getActivePromoCodes() throws SQLException {
        String query = "SELECT COUNT(*) AS active FROM promo_codes WHERE status = 'Active' AND valid_until >= CURDATE()";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("active");
            }
        }
        return 0;
    }

    public int getExpiredPromoCodes() throws SQLException {
        String query = "SELECT COUNT(*) AS expired FROM promo_codes WHERE valid_until < CURDATE()";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("expired");
            }
        }
        return 0;
    }
}