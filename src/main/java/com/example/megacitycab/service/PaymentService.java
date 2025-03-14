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


    public void processPayment(int bookingId, String cardDetails) throws SQLException {
        if (cardDetails == null || cardDetails.isEmpty()) {
            throw new IllegalArgumentException("Card details cannot be null or empty.");
        }
        String transactionId = generateUniqueTransactionId();
        String encryptedCardDetails = Base64.getEncoder().encodeToString(cardDetails.getBytes());
        paymentDAO.processPayment(bookingId, encryptedCardDetails, transactionId);
    }

    private String generateUniqueTransactionId() {
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

    public List<Payment> getAllPayments() throws SQLException {
        return paymentDAO.getAllPayments();
    }

    // Fetch detailed payment information for a specific booking
    public Payment getPaymentDetails(int bookingId) throws SQLException {
        return paymentDAO.getPaymentDetails(bookingId);
    }
    public List<Payment> getPendingPayments() throws SQLException {
        return paymentDAO.getPendingPayments();
    }
    public List<Payment> getCompletedPayments() throws SQLException {
        return paymentDAO.getCompletedPayments();
    }

    public double getTotalIncome() throws SQLException {
        return paymentDAO.getTotalIncome();
    }

    public double getTotalPendingIncome() throws SQLException {
        return paymentDAO.getTotalPendingIncome();
    }

    public double getTotalCompletedIncome() throws SQLException {
        return paymentDAO.getTotalCompletedIncome();
    }
}
