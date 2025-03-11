package com.example.megacitycab.dao;

import com.example.megacitycab.model.Payment;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    private Connection connection;

    public PaymentDAO() throws SQLException {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Add a new payment
    public void addPayment(Payment payment) throws SQLException {
        String query = "INSERT INTO payments (booking_id, amount_paid, payment_method, transaction_id, payment_status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, payment.getBookingId());
            stmt.setDouble(2, payment.getAmountPaid());
            stmt.setString(3, payment.getPaymentMethod());
            stmt.setString(4, payment.getTransactionId());
            stmt.setString(5, payment.getPaymentStatus());
            stmt.executeUpdate();
        }
    }

    // Get all payments
    public List<Payment> getAllPayments() throws SQLException {
        String query = "SELECT * FROM payments";
        List<Payment> payments = new ArrayList<>();
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setAmountPaid(rs.getDouble("amount_paid"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setTransactionId(rs.getString("transaction_id"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setCreatedAt(rs.getTimestamp("created_at"));
                payment.setUpdatedAt(rs.getTimestamp("updated_at"));
                payments.add(payment);
            }
        }
        return payments;
    }

    // Update payment status
    public void updatePaymentStatus(int paymentId, String status) throws SQLException {
        String query = "UPDATE payments SET payment_status = ? WHERE payment_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, paymentId);
            stmt.executeUpdate();
        }
    }

    // Delete a payment
    public void deletePayment(int paymentId) throws SQLException {
        String query = "DELETE FROM payments WHERE payment_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, paymentId);
            stmt.executeUpdate();
        }
    }
}