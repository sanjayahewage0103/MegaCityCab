package com.example.megacitycab.controller;

import com.example.megacitycab.dao.BookingDAO;
import com.example.megacitycab.dao.DriverDAO;
import com.example.megacitycab.dao.VehicleDAO;
import com.example.megacitycab.dao.VehicleAssignmentDAO;
import com.example.megacitycab.service.DriverService;
import com.example.megacitycab.service.VehicleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class CompleteBookingServlet extends HttpServlet {
    private BookingDAO bookingDAO;
    private DriverDAO driverDAO;
    private VehicleDAO vehicleDAO;
    private VehicleAssignmentDAO vehicleAssignmentDAO;

    @Override
    public void init() throws ServletException {
        try {
            bookingDAO = new BookingDAO();
            driverDAO = new DriverDAO();
            vehicleDAO = new VehicleDAO();
            vehicleAssignmentDAO = new VehicleAssignmentDAO();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize DAO objects", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            // Fetch vehicle_id and driver_id from vehicle_assignments
            int[] assignmentDetails = vehicleAssignmentDAO.getAssignmentDetailsByBookingId(bookingId);
            int vehicleId = assignmentDetails[0];
            int driverId = assignmentDetails[1];

            // Update booking status to "Completed"
            bookingDAO.updateBookingStatus(bookingId, "Completed");

            // Update driver status to "Active"
            driverDAO.updateDriverStatus(driverId, "Active");

            // Update vehicle status to "Available"
            vehicleDAO.updateVehicleStatus(vehicleId, "Available");

            // Redirect with success message
            response.sendRedirect("manage-bookings?message=Booking marked as completed.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp?message=Database error occurred.");
        }
    }
}