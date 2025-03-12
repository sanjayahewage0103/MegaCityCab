package com.example.megacitycab.dao;

import com.example.megacitycab.model.Booking;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private Connection connection;

    public BookingDAO() throws SQLException {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Add a new booking
    public void addBooking(Booking booking) throws SQLException {
        String query = "INSERT INTO bookings (customer_id, vehicle_type, pickup_location, drop_location, total_distance, date, time, num_passengers, promo_code_used, base_price, tax_amount, discount_amount, final_amount, payment_method, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, booking.getCustomerId());
            stmt.setString(2, booking.getVehicleType());
            stmt.setString(3, booking.getPickupLocation());
            stmt.setString(4, booking.getDropLocation());
            stmt.setDouble(5, booking.getTotalDistance());
            stmt.setString(6, booking.getDate());
            stmt.setString(7, booking.getTime());
            stmt.setInt(8, booking.getNumPassengers());
            stmt.setString(9, booking.getPromoCodeUsed());
            stmt.setDouble(10, booking.getBasePrice());
            stmt.setDouble(11, booking.getTaxAmount());
            stmt.setDouble(12, booking.getDiscountAmount());
            stmt.setDouble(13, booking.getFinalAmount());
            stmt.setString(14, booking.getPaymentMethod());
            stmt.setString(15, booking.getStatus());
            stmt.executeUpdate();

            // Retrieve the generated booking ID
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                booking.setBookingId(rs.getInt(1));
            }
        }
    }

    // Get all bookings
    public List<Booking> getAllBookings() throws SQLException {
        String query = "SELECT * FROM bookings";
        List<Booking> bookings = new ArrayList<>();
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
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
                bookings.add(booking);
            }
        }
        return bookings;
    }

    // Delete a booking
    public void deleteBooking(int bookingId) throws SQLException {
        String query = "DELETE FROM bookings WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            stmt.executeUpdate();
        }
    }

    // Method to retrieve a booking by its ID
    public Booking getBookingById(int bookingId) throws SQLException {
        String query = "SELECT * FROM bookings WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
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

    // Fetch completed bookings with details
    public List<Booking> getCompletedBookingsWithDetails() throws SQLException {
        String query = """
        SELECT b.booking_id, b.customer_id, va.driver_id, p.payment_id, p.payment_method,
               b.date, b.time, c.first_name AS customer_name, d.first_name AS driver_name,
               v.vehicle_number, v.type AS vehicle_type, b.pickup_location, b.drop_location,
               b.total_distance, b.final_amount
        FROM bookings b
        LEFT JOIN payments p ON b.booking_id = p.booking_id
        LEFT JOIN vehicle_assignments va ON b.booking_id = va.booking_id
        LEFT JOIN vehicle v ON va.vehicle_id = v.vehicle_id
        LEFT JOIN drivers d ON va.driver_id = d.driver_id
        LEFT JOIN customers c ON b.customer_id = c.customer_id
        WHERE b.status = 'Completed'
    """;
        System.out.println("Executing query: " + query); // Log the query
        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerId(rs.getInt("customer_id"));
                booking.setDriverId(rs.getInt("driver_id"));
                booking.setPaymentId(rs.getInt("payment_id"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                booking.setDate(rs.getString("date"));
                booking.setTime(rs.getString("time"));
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setDriverName(rs.getString("driver_name"));
                booking.setVehicleNumber(rs.getString("vehicle_number"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setTotalDistance(rs.getDouble("total_distance"));
                booking.setFinalAmount(rs.getDouble("final_amount"));
                bookings.add(booking);
            }
            System.out.println("Fetched " + bookings.size() + " completed bookings."); // Log the result
        } catch (SQLException e) {
            System.out.println("Error executing query: " + e.getMessage()); // Log errors
            throw e;
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

}