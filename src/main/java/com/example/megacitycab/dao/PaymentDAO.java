package com.example.megacitycab.dao;

import com.example.megacitycab.model.Booking;
import com.example.megacitycab.model.Payment;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    public List<Payment> getPendingPayments(int customerId) throws SQLException {
        String query = """
        SELECT b.booking_id, b.vehicle_type, b.pickup_location, b.drop_location,
               b.date, b.time, b.final_amount, p.payment_method, p.payment_status
        FROM bookings b
        LEFT JOIN payments p ON b.booking_id = p.booking_id
        WHERE b.customer_id = ? AND p.payment_status = 'Pending'
    """;
        List<Payment> payments = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setVehicleType(rs.getString("vehicle_type")); // Fetch vehicle type
                payment.setPickupLocation(rs.getString("pickup_location"));
                payment.setDropLocation(rs.getString("drop_location"));
                payment.setDate(rs.getString("date"));
                payment.setTime(rs.getString("time"));
                payment.setFinalAmount(rs.getDouble("final_amount"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payments.add(payment);
            }
        }
        return payments;
    }

    public void updatePaymentMethod(int bookingId, String paymentMethod) throws SQLException {
        String query = "UPDATE payments SET payment_method = ? WHERE booking_id = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, paymentMethod);
            stmt.setInt(2, bookingId);
            stmt.executeUpdate();
        }
    }

    public void processPayment(int bookingId, String encryptedCardDetails, String transactionId) throws SQLException {
        String insertQuery = "INSERT INTO encrypted_card_details (booking_id, encrypted_details) VALUES (?, ?)";
        String updateQuery = "UPDATE payments SET payment_status = 'Success', transaction_id = ? WHERE booking_id = ?";

        try (Connection connection = DatabaseConnection.getInstance().getConnection()) {
            connection.setAutoCommit(false);

            // Insert encrypted card details
            try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
                insertStmt.setInt(1, bookingId);
                insertStmt.setString(2, encryptedCardDetails);
                insertStmt.executeUpdate();
            }

            // Update payment status with the generated transaction ID
            try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                updateStmt.setString(1, transactionId); // Save the generated transaction ID
                updateStmt.setInt(2, bookingId);
                updateStmt.executeUpdate();
            }

            connection.commit();
        } catch (SQLException e) {
            throw e;
        }
    }


    public List<Payment> getAllPaymentHistory(int customerId) throws SQLException {
        String query = """
        SELECT b.booking_id, b.vehicle_type, b.pickup_location, b.drop_location,
               b.date, b.time, b.final_amount, p.payment_method, p.payment_status,
               e.encrypted_details, p.transaction_id
        FROM bookings b
        LEFT JOIN payments p ON b.booking_id = p.booking_id
        LEFT JOIN encrypted_card_details e ON b.booking_id = e.booking_id
        WHERE b.customer_id = ?
    """;
        List<Payment> paymentHistory = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setVehicleType(rs.getString("vehicle_type"));
                payment.setPickupLocation(rs.getString("pickup_location"));
                payment.setDropLocation(rs.getString("drop_location"));
                payment.setDate(rs.getString("date"));
                payment.setTime(rs.getString("time"));
                payment.setFinalAmount(rs.getDouble("final_amount"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setEncryptedDetails(rs.getString("encrypted_details"));
                payment.setTransactionId(rs.getString("transaction_id")); // Fetch transaction ID
                paymentHistory.add(payment);
            }
        }
        return paymentHistory;
    }

    public Booking getCompletedBookingDetails(int bookingId) throws SQLException {
        String query = """
            SELECT c.name AS customer_name, c.contact AS customer_mobile,
                   b.date, b.time, b.pickup_location, b.drop_location, b.total_distance,
                   b.base_price, b.tax_amount, b.discount_amount, b.final_amount,
                   b.vehicle_type, b.num_passengers, d.first_name, d.last_name,
                   v.vehicle_number, v.color, p.payment_method, p.transaction_id
            FROM bookings b
            LEFT JOIN customer c ON b.customer_id = c.customer_id
            LEFT JOIN vehicle_assignments va ON b.booking_id = va.booking_id
            LEFT JOIN drivers d ON va.driver_id = d.driver_id
            LEFT JOIN vehicle v ON va.vehicle_id = v.vehicle_id
            LEFT JOIN payments p ON b.booking_id = p.booking_id
            WHERE b.booking_id = ?
        """;
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(bookingId);
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setCustomerMobile(rs.getString("customer_mobile"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setTotalDistance(rs.getDouble("total_distance"));
                booking.setBasePrice(rs.getDouble("base_price"));
                booking.setTaxAmount(rs.getDouble("tax_amount"));
                booking.setDiscountAmount(rs.getDouble("discount_amount"));
                booking.setFinalAmount(rs.getDouble("final_amount"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setNumPassengers(rs.getInt("num_passengers"));
                booking.setDriverName(rs.getString("first_name") + " " + rs.getString("last_name"));
                booking.setVehicleNumber(rs.getString("vehicle_number"));
                booking.setVehicleColor(rs.getString("color"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                booking.setTransactionId(rs.getString("transaction_id"));
                return booking;
            }
        }
        return null;
    }

    public List<Payment> getCompletedPayments(int customerId) throws SQLException {
        String query = """
            SELECT b.booking_id, b.pickup_location, b.drop_location, b.date, b.time,
                   b.final_amount, p.payment_method, p.transaction_id
            FROM bookings b
            LEFT JOIN payments p ON b.booking_id = p.booking_id
            WHERE b.customer_id = ? AND p.payment_status = 'Success'
        """;
        List<Payment> completedPayments = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setPickupLocation(rs.getString("pickup_location"));
                payment.setDropLocation(rs.getString("drop_location"));
                payment.setDate(rs.getString("date"));
                payment.setTime(rs.getString("time"));
                payment.setFinalAmount(rs.getDouble("final_amount"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setTransactionId(rs.getString("transaction_id"));
                completedPayments.add(payment);
            }
        }
        return completedPayments;
    }

    public List<Payment> getAllPayments() throws SQLException {
        String query = """
            SELECT b.booking_id, c.customer_id, b.vehicle_type, b.final_amount,
                   p.payment_method, p.payment_status, p.transaction_id, e.encrypted_details
            FROM bookings b
            LEFT JOIN customer c ON b.customer_id = c.customer_id
            LEFT JOIN payments p ON b.booking_id = p.booking_id
            LEFT JOIN encrypted_card_details e ON b.booking_id = e.booking_id
        """;
        List<Payment> payments = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setCustomerId(rs.getInt("customer_id"));
                payment.setVehicleType(rs.getString("vehicle_type"));
                payment.setFinalAmount(rs.getDouble("final_amount"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setTransactionId(rs.getString("transaction_id"));
                payment.setEncryptedDetails(rs.getString("encrypted_details"));
                payments.add(payment);
            }
        }
        return payments;
    }

    // Fetch detailed payment information for a specific booking
    public Payment getPaymentDetails(int bookingId) throws SQLException {
        String query = """
            SELECT b.booking_id, c.customer_id, c.name AS customer_name,
                   b.vehicle_type, b.pickup_location, b.drop_location, b.date, b.time,
                   b.final_amount, p.payment_method, p.payment_status, p.transaction_id,
                   e.encrypted_details, d.first_name AS driver_first_name, d.last_name AS driver_last_name,
                   v.vehicle_number
            FROM bookings b
            LEFT JOIN customer c ON b.customer_id = c.customer_id
            LEFT JOIN payments p ON b.booking_id = p.booking_id
            LEFT JOIN encrypted_card_details e ON b.booking_id = e.booking_id
            LEFT JOIN vehicle_assignments va ON b.booking_id = va.booking_id
            LEFT JOIN drivers d ON va.driver_id = d.driver_id
            LEFT JOIN vehicle v ON va.vehicle_id = v.vehicle_id
            WHERE b.booking_id = ?
        """;
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Payment payment = new Payment();
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setCustomerId(rs.getInt("customer_id"));
                payment.setCustomerName(rs.getString("customer_name"));
                payment.setVehicleType(rs.getString("vehicle_type"));
                payment.setPickupLocation(rs.getString("pickup_location"));
                payment.setDropLocation(rs.getString("drop_location"));
                payment.setDate(rs.getString("date"));
                payment.setTime(rs.getString("time"));
                payment.setFinalAmount(rs.getDouble("final_amount"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setTransactionId(rs.getString("transaction_id"));
                payment.setEncryptedDetails(rs.getString("encrypted_details"));
                payment.setDriverName(rs.getString("driver_first_name") + " " + rs.getString("driver_last_name"));
                payment.setVehicleNumber(rs.getString("vehicle_number"));
                return payment;
            }
        }
        return null;
    }
    public List<Payment> getPendingPayments() throws SQLException {
        String query = """
        SELECT b.booking_id, c.name AS customer_name, b.vehicle_type,
               b.pickup_location, b.drop_location, b.date, b.time, b.final_amount
        FROM bookings b
        LEFT JOIN customer c ON b.customer_id = c.customer_id
        LEFT JOIN payments p ON b.booking_id = p.booking_id
        WHERE p.payment_status = 'Pending'
    """;
        List<Payment> pendingPayments = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setCustomerName(rs.getString("customer_name"));
                payment.setVehicleType(rs.getString("vehicle_type"));
                payment.setPickupLocation(rs.getString("pickup_location"));
                payment.setDropLocation(rs.getString("drop_location"));
                payment.setDate(rs.getString("date"));
                payment.setTime(rs.getString("time"));
                payment.setFinalAmount(rs.getDouble("final_amount"));
                pendingPayments.add(payment);
            }
        }
        return pendingPayments;
    }

    public List<Payment> getCompletedPayments() throws SQLException {
        String query = """
        SELECT b.booking_id, c.customer_id, b.vehicle_type, b.final_amount,
               p.payment_method, p.payment_status, p.transaction_id, e.encrypted_details
        FROM bookings b
        LEFT JOIN customer c ON b.customer_id = c.customer_id
        LEFT JOIN payments p ON b.booking_id = p.booking_id
        LEFT JOIN encrypted_card_details e ON b.booking_id = e.booking_id
        WHERE p.payment_status = 'Success'
    """;
        List<Payment> completedPayments = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setCustomerId(rs.getInt("customer_id"));
                payment.setVehicleType(rs.getString("vehicle_type"));
                payment.setFinalAmount(rs.getDouble("final_amount"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setTransactionId(rs.getString("transaction_id"));
                payment.setEncryptedDetails(rs.getString("encrypted_details"));
                completedPayments.add(payment);
            }
        }
        return completedPayments;
    }

    public double getTotalIncome() throws SQLException {
        String query = """
        SELECT SUM(final_amount) AS total_income
        FROM bookings
    """;
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total_income");
            }
        }
        return 0.0;
    }

    public double getTotalPendingIncome() throws SQLException {
        String query = """
        SELECT SUM(final_amount) AS pending_income
        FROM bookings b
        LEFT JOIN payments p ON b.booking_id = p.booking_id
        WHERE p.payment_status = 'Pending'
    """;
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("pending_income");
            }
        }
        return 0.0;
    }

    public double getTotalCompletedIncome() throws SQLException {
        String query = """
        SELECT SUM(final_amount) AS completed_income
        FROM bookings b
        LEFT JOIN payments p ON b.booking_id = p.booking_id
        WHERE p.payment_status = 'Success'
    """;
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("completed_income");
            }
        }
        return 0.0;
    }
}