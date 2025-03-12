package com.example.megacitycab.dao;

import com.example.megacitycab.model.Payment;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;

public class PaymentDAO {
    public int savePayment(Payment payment) throws SQLException {
        String query = "INSERT INTO payments (booking_id, amount_paid, payment_method, payment_status) VALUES (?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, payment.getBookingId());
            stmt.setDouble(2, payment.getAmountPaid());
            stmt.setString(3, payment.getPaymentMethod());
            stmt.setString(4, payment.getPaymentStatus());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Return the generated payment_id
            }
        }
        throw new SQLException("Failed to retrieve payment ID after insertion.");
    }
}