package com.example.megacitycab.controller;

import com.example.megacitycab.dao.*;
import com.example.megacitycab.model.Booking;
import com.example.megacitycab.model.Driver;
import com.example.megacitycab.model.Vehicle;
import com.example.megacitycab.service.BookingService;
import com.example.megacitycab.service.DriverService;
import com.example.megacitycab.service.VehicleAssignmentService;
import com.example.megacitycab.service.VehicleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class AssignBookingServlet extends HttpServlet {
    private BookingService bookingService;
    private DriverService driverService;
    private VehicleService vehicleService;
    private VehicleAssignmentService vehicleAssignmentService;

    @Override
    public void init() throws ServletException {
        try {
            // Initialize DAO objects
            BookingDAO bookingDAO = new BookingDAO();
            VehicleDAO vehicleDAO = new VehicleDAO();
            PromoCodeDAO promoCodeDAO = new PromoCodeDAO();
            DiscountDAO discountDAO = new DiscountDAO();
            PricingDAO pricingDAO = new PricingDAO();
            DriverDAO driverDAO = new DriverDAO();
            VehicleAssignmentDAO vehicleAssignmentDAO = new VehicleAssignmentDAO();

            // Pass all required DAO objects to BookingService
            bookingService = new BookingService(bookingDAO, vehicleDAO, promoCodeDAO, discountDAO, pricingDAO);
            driverService = new DriverService(driverDAO);
            vehicleService = new VehicleService(vehicleDAO);
            vehicleAssignmentService = new VehicleAssignmentService(vehicleAssignmentDAO);
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize DAO objects", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            Booking bookingDetails = bookingService.getBookingDetailsById(bookingId);

            if (bookingDetails != null) {
                request.setAttribute("bookingId", bookingDetails.getBookingId());
                request.setAttribute("customerId", bookingDetails.getCustomerId());
                request.setAttribute("vehicleType", bookingDetails.getVehicleType());
                request.setAttribute("pickupLocation", bookingDetails.getPickupLocation());
                request.setAttribute("dropLocation", bookingDetails.getDropLocation());
                request.setAttribute("date", bookingDetails.getDate());
                request.setAttribute("time", bookingDetails.getTime());

                List<Driver> availableDriversList = driverService.getAvailableDrivers();
                List<Vehicle> availableVehiclesList = vehicleService.getAvailableVehicles(bookingDetails.getVehicleType());

                request.setAttribute("availableDriversList", availableDriversList);
                request.setAttribute("availableVehiclesList", availableVehiclesList);

                request.getRequestDispatcher("assign-booking.jsp").forward(request, response);
            } else {
                response.sendRedirect("/error.jsp?message=Booking not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp?message=Database error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            int driverId = Integer.parseInt(request.getParameter("driverId"));

            vehicleAssignmentService.assignVehicleAndDriver(bookingId, vehicleId, driverId);
            bookingService.updateBookingStatus(bookingId, "Confirmed");
            vehicleService.updateVehicleStatus(vehicleId, "Ongoing");
            driverService.updateDriverStatus(driverId, "Inactive");

            response.sendRedirect("manage-bookings?message=Booking assigned successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp?message=Database error occurred.");
        }
    }
}