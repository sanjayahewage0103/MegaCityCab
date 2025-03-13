package com.example.megacitycab.controller;

import com.example.megacitycab.dao.*;
import com.example.megacitycab.model.Booking;
import com.example.megacitycab.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class CustomerBookingManageServlet extends HttpServlet {
    private BookingService bookingService;

    @Override
    public void init() throws ServletException {
        try {
            BookingDAO bookingDAO = new BookingDAO();
            VehicleDAO vehicleDAO = new VehicleDAO();
            PromoCodeDAO promoCodeDAO = new PromoCodeDAO();
            DiscountDAO discountDAO = new DiscountDAO();
            PricingDAO pricingDAO = new PricingDAO();

            bookingService = new BookingService(bookingDAO, vehicleDAO, promoCodeDAO, discountDAO, pricingDAO);
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize DAO objects", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int customerId = (int) request.getSession().getAttribute("customerId");

            List<Booking> pendingBookingsList = bookingService.getPendingBookings(customerId);
            request.setAttribute("pendingBookingsList", pendingBookingsList);

            List<Booking> confirmedBookingsList = bookingService.getConfirmedBookings(customerId);
            request.setAttribute("confirmedBookingsList", confirmedBookingsList);

            List<Booking> cancelledBookingsList = bookingService.getCancelledBookings(customerId);
            request.setAttribute("cancelledBookingsList", cancelledBookingsList);

            List<Booking> completedBookingsList = bookingService.getCompletedBookings(customerId);
            request.setAttribute("completedBookingsList", completedBookingsList);

            List<Booking> allBookingsList = bookingService.getAllBookingsForCustomer(customerId);
            request.setAttribute("allBookingsList", allBookingsList);

            request.getRequestDispatcher("customer-booking-manage.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp?message=Database error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            if ("updatePaymentMethod".equals(action)) {
                String paymentMethod = request.getParameter("paymentMethod");
                bookingService.updatePaymentMethod(bookingId, paymentMethod);
                response.sendRedirect("customer-booking-manage?message=Payment method updated successfully.");
            } else if ("makePayment".equals(action)) {
                response.sendRedirect("make-payment.jsp?bookingId=" + bookingId);
            } else if ("viewDetails".equals(action)) {
                Booking bookingDetails = bookingService.getCompletedBookingDetails(bookingId);
                request.setAttribute("bookingDetails", bookingDetails);
                request.getRequestDispatcher("modal-completed-details.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp?message=Database error occurred.");
        }
    }
}