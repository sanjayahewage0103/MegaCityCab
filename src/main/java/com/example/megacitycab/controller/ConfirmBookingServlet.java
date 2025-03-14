package com.example.megacitycab.controller;

import com.example.megacitycab.dao.BookingDAO;
import com.example.megacitycab.dao.PaymentDAO;
import com.example.megacitycab.model.Booking;

import com.example.megacitycab.model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class ConfirmBookingServlet extends HttpServlet {
    private BookingDAO bookingDAO;
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        try {
            bookingDAO = new BookingDAO();
            paymentDAO = new PaymentDAO();

        } catch (SQLException e) {
            throw new ServletException("Failed to initialize BookingDAO", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve booking details from the form
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String pickupLocation = request.getParameter("pickupLocation");
            String dropLocation = request.getParameter("dropLocation");
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            int numPassengers = Integer.parseInt(request.getParameter("numPassengers"));
            String vehicleType = request.getParameter("vehicleType");
            double totalDistance = Double.parseDouble(request.getParameter("totalDistance"));
            double basePrice = Double.parseDouble(request.getParameter("basePrice"));
            double taxAmount = Double.parseDouble(request.getParameter("taxAmount"));
            double discountAmount = Double.parseDouble(request.getParameter("discountAmount"));
            double finalFare = Double.parseDouble(request.getParameter("finalFare"));
            String paymentMethod = request.getParameter("paymentMethod");

            // Create a Booking object
            Booking booking = new Booking();
            booking.setCustomerId(customerId);
            booking.setPickupLocation(pickupLocation);
            booking.setDropLocation(dropLocation);
            booking.setDate(date);
            booking.setTime(time);
            booking.setNumPassengers(numPassengers);
            booking.setVehicleType(vehicleType);
            booking.setTotalDistance(totalDistance);
            booking.setBasePrice(basePrice);
            booking.setTaxAmount(taxAmount);
            booking.setDiscountAmount(discountAmount);
            booking.setFinalAmount(finalFare);
            booking.setPaymentMethod(paymentMethod);
            booking.setStatus("Pending");

            int bookingId = bookingDAO.saveBookingAndGetId(booking);

            // Create a Payment object
            Payment payment = new Payment();
            payment.setBookingId(bookingId);
            payment.setAmountPaid(finalFare); // Amount paid is the final fare
            payment.setPaymentMethod(paymentMethod);
            payment.setPaymentStatus("Pending"); // Payment status is initially "Pending"

            paymentDAO.savePayment(payment);

            // Redirect to the confirmation page
            response.sendRedirect("booking-confirmation.jsp?message=Booking confirmed successfully! Awaiting admin approval.");
        } catch (SQLException e) {
            System.err.println("Database error occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Failed to confirm booking. Please try again later.");
        }
    }
}