package com.example.megacitycab.controller;

import com.example.megacitycab.dao.*;
import com.example.megacitycab.model.Booking;
import com.example.megacitycab.model.Driver;
import com.example.megacitycab.model.Vehicle;
import com.example.megacitycab.service.BookingService;
import com.example.megacitycab.service.DriverService;
import com.example.megacitycab.service.VehicleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ManageBookingServlet extends HttpServlet {
    private BookingService bookingService;
    private DriverService driverService;
    private VehicleService vehicleService;

    @Override
    public void init() throws ServletException {
        try {
            BookingDAO bookingDAO = new BookingDAO();
            VehicleDAO vehicleDAO = new VehicleDAO();
            PromoCodeDAO promoCodeDAO = new PromoCodeDAO();
            DiscountDAO discountDAO = new DiscountDAO();
            PricingDAO pricingDAO = new PricingDAO();
            DriverDAO driverDAO = new DriverDAO();

            bookingService = new BookingService(bookingDAO, vehicleDAO, promoCodeDAO, discountDAO, pricingDAO);
            driverService = new DriverService(driverDAO);
            vehicleService = new VehicleService(vehicleDAO); // Use the new constructor
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize DAO objects", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int totalBookings = bookingService.getTotalBookingCount();
            int pendingBookings = bookingService.getPendingBookingCount();
            int confirmedBookings = bookingService.getConfirmedBookingCount();
            int cancelledBookings = bookingService.getCancelledBookingCount();

            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("pendingBookings", pendingBookings);
            request.setAttribute("confirmedBookings", confirmedBookings);
            request.setAttribute("cancelledBookings", cancelledBookings);

            List<Booking> pendingBookingsList = bookingService.getAllBookingsByStatus("Pending");
            request.setAttribute("pendingBookingsList", pendingBookingsList);

            List<Driver> availableDriversList = driverService.getAvailableDrivers();
            String vehicleTypeFilter = request.getParameter("vehicleTypeFilter");
            List<Vehicle> availableVehiclesList = vehicleService.getAvailableVehicles(vehicleTypeFilter);

            request.setAttribute("availableDriversList", availableDriversList);
            request.setAttribute("availableVehiclesList", availableVehiclesList);

            List<Booking> confirmedBookingsList = bookingService.getConfirmedBookingsWithDetails();
            request.setAttribute("confirmedBookingsList", confirmedBookingsList);

            List<Booking> cancelledBookingsList = bookingService.getCancelledBookingsWithDetails();
            request.setAttribute("cancelledBookingsList", cancelledBookingsList);

            // Fetch completed bookings
            List<Booking> completedBookingsList = bookingService.getCompletedBookings();
            request.setAttribute("completedBookingsList", completedBookingsList);

            request.getRequestDispatcher("manage-bookings.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp?message=Database error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            Booking activityDetails = bookingService.getActivityDetails(bookingId);
            request.setAttribute("activityDetails", activityDetails);

            request.getRequestDispatcher("modal-activity.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp?message=Database error occurred.");
        }
    }
}