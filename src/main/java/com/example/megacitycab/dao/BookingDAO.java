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

    // Update booking status
    public void updateBookingStatus(int bookingId, String status) throws SQLException {
        String query = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
            stmt.executeUpdate();
        }
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

    public void saveBooking(Booking booking) throws SQLException {
        String query = "INSERT INTO bookings (customer_id, vehicle_type, pickup_location, drop_location, total_distance, " +
                "date, time, num_passengers, promo_code_used, base_price, tax_amount, discount_amount, final_amount, " +
                "payment_method, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

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
            System.out.println("Booking saved successfully.");
        } catch (SQLException e) {
            System.err.println("Error saving booking: " + e.getMessage());
            throw e; // Re-throw the exception for handling in the servlet
        }
    }
}