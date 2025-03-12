package com.example.megacitycab.controller;

import com.example.megacitycab.dao.*;
import com.example.megacitycab.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class CancelBookingServlet extends HttpServlet {
    private BookingService bookingService;

    @Override
    public void init() throws ServletException {
        try {
            // Initialize DAO objects
            BookingDAO bookingDAO = new BookingDAO();
            VehicleDAO vehicleDAO = new VehicleDAO();
            PromoCodeDAO promoCodeDAO = new PromoCodeDAO();
            DiscountDAO discountDAO = new DiscountDAO();
            PricingDAO pricingDAO = new PricingDAO();

            // Pass DAO objects to BookingService
            bookingService = new BookingService(bookingDAO, vehicleDAO, promoCodeDAO, discountDAO, pricingDAO);
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize DAO objects", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the booking ID from the request parameters
        String bookingIdParam = request.getParameter("bookingId");

        if (bookingIdParam == null || bookingIdParam.isEmpty()) {
            response.sendRedirect("/admin/manage-bookings?error=Invalid booking ID.");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdParam);

            // Cancel the booking
            bookingService.cancelBooking(bookingId);

            // Redirect back to the manage bookings page with a success message
            response.sendRedirect("/admin/manage-bookings?message=Booking cancelled successfully.");
        } catch (NumberFormatException e) {
            response.sendRedirect("/admin/manage-bookings?error=Invalid booking ID format.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/admin/manage-bookings?error=Database error occurred while cancelling the booking.");
        }
    }
}