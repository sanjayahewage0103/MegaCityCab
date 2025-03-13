package com.example.megacitycab.dao;

import com.example.megacitycab.model.Booking;
import com.example.megacitycab.model.Payment;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private Connection connection;

    public BookingDAO() throws SQLException {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }



    public int saveBookingAndGetId(Booking booking) throws SQLException {
        String query = "INSERT INTO bookings (customer_id, pickup_location, drop_location, total_distance, date, time, num_passengers, vehicle_type, base_price, tax_amount, discount_amount, final_amount, payment_method, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // Use Statement.RETURN_GENERATED_KEYS to retrieve the generated booking ID
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            // Set parameters for the query
            stmt.setInt(1, booking.getCustomerId());
            stmt.setString(2, booking.getPickupLocation());
            stmt.setString(3, booking.getDropLocation());
            stmt.setDouble(4, booking.getTotalDistance());
            stmt.setString(5, booking.getDate());
            stmt.setString(6, booking.getTime());
            stmt.setInt(7, booking.getNumPassengers());
            stmt.setString(8, booking.getVehicleType());
            stmt.setDouble(9, booking.getBasePrice());
            stmt.setDouble(10, booking.getTaxAmount());
            stmt.setDouble(11, booking.getDiscountAmount());
            stmt.setDouble(12, booking.getFinalAmount());
            stmt.setString(13, booking.getPaymentMethod());
            stmt.setString(14, booking.getStatus());

            // Execute the query
            stmt.executeUpdate();

            // Retrieve the generated booking ID
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Return the generated booking ID
            }
        }

        throw new SQLException("Failed to retrieve booking ID after insertion.");
    }

    public List<Booking> getAllBookingsByStatus(String status) throws SQLException {
        String query = "SELECT * FROM bookings WHERE status = ?";
        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setFinalAmount(rs.getDouble("final_amount"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        }
        return bookings;
    }

    public int getTotalBookingCount() throws SQLException {
        String query = "SELECT COUNT(*) AS total FROM bookings";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    public int getPendingBookingCount() throws SQLException {
        String query = "SELECT COUNT(*) AS total FROM bookings WHERE status = 'Pending'";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    public int getConfirmedBookingCount() throws SQLException {
        String query = "SELECT COUNT(*) AS total FROM bookings WHERE status = 'Confirmed'";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    public int getCancelledBookingCount() throws SQLException {
        String query = "SELECT COUNT(*) AS total FROM bookings WHERE status = 'Cancelled'";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    public void updateBookingStatus(int bookingId, String status) throws SQLException {
        String query = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
            stmt.executeUpdate();
        }
    }

    // Fetch booking details by I
    public Booking getBookingDetailsById(int bookingId) throws SQLException {
        String query = "SELECT * FROM bookings WHERE booking_id = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setTotalDistance(rs.getDouble("total_distance"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setNumPassengers(rs.getInt("num_passengers"));
                booking.setPromoCodeUsed(rs.getString("promo_code_used"));
                booking.setBasePrice(rs.getDouble("base_price"));
                booking.setTaxAmount(rs.getDouble("tax_amount"));
                booking.setDiscountAmount(rs.getDouble("discount_amount"));
                booking.setFinalAmount(rs.getDouble("final_amount"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                booking.setStatus(rs.getString("status"));
                booking.setCreatedAt(rs.getTimestamp("created_at"));
                booking.setUpdatedAt(rs.getTimestamp("updated_at"));
                return booking;
            }
        }
        return null;
    }

    public List<Booking> getConfirmedBookingsWithDetails() throws SQLException {
        String query = """
            SELECT b.booking_id, b.customer_id, b.vehicle_type, b.pickup_location, b.drop_location,
                   b.date, b.time, b.final_amount, b.payment_method,
                   p.payment_status, va.vehicle_id, v.vehicle_number, d.first_name, d.last_name
            FROM bookings b
            LEFT JOIN payments p ON b.booking_id = p.booking_id
            LEFT JOIN vehicle_assignments va ON b.booking_id = va.booking_id
            LEFT JOIN vehicle v ON va.vehicle_id = v.vehicle_id
            LEFT JOIN drivers d ON va.driver_id = d.driver_id
            WHERE b.status = 'Confirmed'
            """;

        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setDate(rs.getDate("date").toString()); // Separate date
                booking.setTime(rs.getTime("time").toString()); // Separate time
                booking.setFinalAmount(rs.getDouble("final_amount"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                booking.setPaymentStatus(rs.getString("payment_status")); // Fetch payment status
                booking.setVehicleNumber(rs.getString("vehicle_number"));
                booking.setDriverName(rs.getString("first_name") + " " + rs.getString("last_name"));

                bookings.add(booking);
            }
        }
        return bookings;
    }

    // Fetch cancelled bookings with additional details
    public List<Booking> getCancelledBookingsWithDetails() throws SQLException {
        String query = """
            SELECT b.booking_id, b.customer_id, b.vehicle_type, b.pickup_location, b.drop_location,
                   b.date, b.time, b.final_amount, b.payment_method,
                   p.payment_status, v.vehicle_number, d.first_name, d.last_name
            FROM bookings b
            LEFT JOIN payments p ON b.booking_id = p.booking_id
            LEFT JOIN vehicle_assignments va ON b.booking_id = va.booking_id
            LEFT JOIN vehicle v ON va.vehicle_id = v.vehicle_id
            LEFT JOIN drivers d ON va.driver_id = d.driver_id
            WHERE b.status = 'Cancelled'
        """;
        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setFinalAmount(rs.getDouble("final_amount"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                booking.setPaymentStatus(rs.getString("payment_status"));
                booking.setVehicleNumber(rs.getString("vehicle_number"));
                booking.setDriverName(rs.getString("first_name") + " " + rs.getString("last_name"));
                bookings.add(booking);
            }
        }
        return bookings;
    }


    // Fetch completed bookings
    public List<Booking> getCompletedBookings() throws SQLException {
        String query = """
            SELECT b.booking_id, b.customer_id, va.vehicle_id, va.driver_id, p.payment_id,
                   p.payment_method, b.date, b.time
            FROM bookings b
            LEFT JOIN vehicle_assignments va ON b.booking_id = va.booking_id
            LEFT JOIN payments p ON b.booking_id = p.booking_id
            WHERE b.status = 'completed'
        """;
        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setVehicleId(rs.getInt("vehicle_id"));
                booking.setDriverId(rs.getInt("driver_id"));
                booking.setPaymentId(rs.getInt("payment_id"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                bookings.add(booking);
            }
        }
        return bookings;
    }

    // Fetch detailed activity data for a specific booking
    public Booking getActivityDetails(int bookingId) throws SQLException {
        String query = """
            SELECT c.name AS customer_name, d.first_name AS driver_first_name, d.last_name AS driver_last_name,
                   v.vehicle_number, v.type AS vehicle_type, b.pickup_location, b.drop_location,
                   b.date, b.time, b.payment_method, b.total_distance, b.final_amount
            FROM bookings b
            LEFT JOIN customer c ON b.customer_id = c.customer_id
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
                Booking booking = new Booking();
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setDriverName(rs.getString("driver_first_name") + " " + rs.getString("driver_last_name"));
                booking.setVehicleNumber(rs.getString("vehicle_number"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                booking.setTotalDistance(rs.getDouble("total_distance"));
                booking.setFinalAmount(rs.getDouble("final_amount"));
                return booking;
            }
        }
        return null;
    }

    public List<Booking> getAllBookings() throws SQLException {
        String query = """
            SELECT booking_id, customer_id, vehicle_type, pickup_location, drop_location,
                   date, time, status
            FROM bookings
        """;
        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        }
        return bookings;
    }

    public List<Booking> getPendingBookings(int customerId) throws SQLException {
        String query = """
            SELECT booking_id, vehicle_type, pickup_location, drop_location, date, time,
                   final_amount, payment_method
            FROM bookings
            WHERE customer_id = ? AND status = 'Pending'
        """;
        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setFinalAmount(rs.getDouble("final_amount"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                bookings.add(booking);
            }
        }
        return bookings;
    }

    public List<Booking> getConfirmedBookings(int customerId) throws SQLException {
        String query = """
            SELECT b.booking_id, b.vehicle_type, b.pickup_location, b.drop_location,
                   b.date, b.time, b.final_amount, b.payment_method, p.payment_status,
                   v.vehicle_number, d.first_name, d.last_name
            FROM bookings b
            LEFT JOIN payments p ON b.booking_id = p.booking_id
            LEFT JOIN vehicle_assignments va ON b.booking_id = va.booking_id
            LEFT JOIN vehicle v ON va.vehicle_id = v.vehicle_id
            LEFT JOIN drivers d ON va.driver_id = d.driver_id
            WHERE b.customer_id = ? AND b.status = 'Confirmed'
        """;
        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setFinalAmount(rs.getDouble("final_amount"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                booking.setPaymentStatus(rs.getString("payment_status"));
                booking.setVehicleNumber(rs.getString("vehicle_number"));
                booking.setDriverName(rs.getString("first_name") + " " + rs.getString("last_name"));
                bookings.add(booking);
            }
        }
        return bookings;
    }

    public void updatePaymentMethod(int bookingId, String paymentMethod) throws SQLException {
        String query = "UPDATE bookings SET payment_method = ? WHERE booking_id = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, paymentMethod);
            stmt.setInt(2, bookingId);
            stmt.executeUpdate();
        }
    }

    public List<Booking> getCancelledBookings(int customerId) throws SQLException {
        String query = """
            SELECT b.booking_id, b.vehicle_type, b.pickup_location, b.drop_location,
                   b.date, b.time, b.final_amount, b.payment_method, p.payment_status,
                   v.vehicle_number, d.first_name, d.last_name
            FROM bookings b
            LEFT JOIN payments p ON b.booking_id = p.booking_id
            LEFT JOIN vehicle_assignments va ON b.booking_id = va.booking_id
            LEFT JOIN vehicle v ON va.vehicle_id = v.vehicle_id
            LEFT JOIN drivers d ON va.driver_id = d.driver_id
            WHERE b.customer_id = ? AND b.status = 'Cancelled'
        """;
        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setFinalAmount(rs.getDouble("final_amount"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                booking.setPaymentStatus(rs.getString("payment_status"));
                booking.setVehicleNumber(rs.getString("vehicle_number"));
                booking.setDriverName(rs.getString("first_name") + " " + rs.getString("last_name"));
                bookings.add(booking);
            }
        }
        return bookings;
    }

    public List<Booking> getCompletedBookings(int customerId) throws SQLException {
        String query = """
            SELECT b.booking_id, p.payment_id, b.date, b.time, b.status,
                   b.pickup_location, b.drop_location, b.final_amount
            FROM bookings b
            LEFT JOIN payments p ON b.booking_id = p.booking_id
            WHERE b.customer_id = ? AND b.status = 'Completed'
        """;
        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setPaymentId(rs.getInt("payment_id"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setStatus(rs.getString("status"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setFinalAmount(rs.getDouble("final_amount"));
                bookings.add(booking);
            }
        }
        return bookings;
    }

    // Fetch detailed booking information
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

    public List<Booking> getAllBookingsForCustomer(int customerId) throws SQLException {
        String query = """
            SELECT b.booking_id, b.vehicle_type, b.pickup_location, b.drop_location,
                   b.date, b.time, b.status, p.payment_status
            FROM bookings b
            LEFT JOIN payments p ON b.booking_id = p.booking_id
            WHERE b.customer_id = ?
        """;
        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setStatus(rs.getString("status"));
                booking.setPaymentStatus(rs.getString("payment_status"));
                bookings.add(booking);
            }
        }
        return bookings;
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
}