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
        return null; // Return null if no booking is found
    }


    // Insert into vehicle_assignments table
    public void assignVehicleAndDriver(int bookingId, int vehicleId, int driverId) throws SQLException {
        String query = "INSERT INTO vehicle_assignments (booking_id, vehicle_id, driver_id, status) VALUES (?, ?, ?, 'Assigned')";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            stmt.setInt(2, vehicleId);
            stmt.setInt(3, driverId);
            stmt.executeUpdate();
        }
    }

}