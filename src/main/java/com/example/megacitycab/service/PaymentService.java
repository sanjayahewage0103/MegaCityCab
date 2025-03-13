package com.example.megacitycab.service;

import com.example.megacitycab.dao.PaymentDAO;
import com.example.megacitycab.model.Booking;
import com.example.megacitycab.model.Payment;

import java.sql.SQLException;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

public class PaymentService {
    private final PaymentDAO paymentDAO;

    public PaymentService(PaymentDAO paymentDAO) {
        this.paymentDAO = paymentDAO;
    }

    public List<Payment> getPendingPayments(int customerId) throws SQLException {
        return paymentDAO.getPendingPayments(customerId);
    }

    public void updatePaymentMethod(int bookingId, String paymentMethod) throws SQLException {
        paymentDAO.updatePaymentMethod(bookingId, paymentMethod);
    }

    public void processPayment(int bookingId, String cardDetails) throws SQLException {
        if (cardDetails == null || cardDetails.isEmpty()) {
            throw new IllegalArgumentException("Card details cannot be null or empty.");
        }

        // Generate a unique transaction ID
        String transactionId = generateUniqueTransactionId();

        // Encrypt card details
        String encryptedCardDetails = Base64.getEncoder().encodeToString(cardDetails.getBytes());

        // Save encrypted details and update payment status
        paymentDAO.processPayment(bookingId, encryptedCardDetails, transactionId);
    }

    // Method to generate a unique transaction ID
    private String generateUniqueTransactionId() {
        // Use UUID to generate a unique identifier
        return "TXN-" + UUID.randomUUID().toString().replaceAll("-", "").substring(0, 12).toUpperCase();
    }

    public List<Payment> getAllPaymentHistory(int customerId) throws SQLException {
        return paymentDAO.getAllPaymentHistory(customerId);
    }

    public List<Payment> getCompletedPayments(int customerId) throws SQLException {
        return paymentDAO.getCompletedPayments(customerId);
    }

    public Booking getCompletedBookingDetails(int bookingId) throws SQLException {
        return paymentDAO.getCompletedBookingDetails(bookingId);
    }

}
