package com.example.megacitycab.controller;

import com.example.megacitycab.dao.*;
import com.example.megacitycab.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DecimalFormat;

public class BookingServlet extends HttpServlet {
    private BookingDAO bookingDAO;
    private DistanceDAO distanceDAO;
    private PricingDAO pricingDAO;
    private PromoCodeDAO promoCodeDAO;
    private DiscountDAO discountDAO;

    @Override
    public void init() throws ServletException {
        try {
            bookingDAO = new BookingDAO();
            distanceDAO = new DistanceDAO();
            pricingDAO = new PricingDAO();
            promoCodeDAO = new PromoCodeDAO();
            discountDAO = new DiscountDAO();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize DAOs", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("book".equals(action)) {
                // Step 1: Get user inputs
                String vehicleType = request.getParameter("vehicleType");
                String pickupLocation = request.getParameter("pickupLocation");
                String dropLocation = request.getParameter("dropLocation");
                String date = request.getParameter("date");
                String time = request.getParameter("time");
                int numPassengers = Integer.parseInt(request.getParameter("numPassengers"));
                String promoCode = request.getParameter("promoCode");

                // Step 2: Validate seating capacity
                VehicleDAO vehicleDAO = new VehicleDAO();
                Vehicle vehicle = vehicleDAO.getVehicleByType(vehicleType);
                if (numPassengers > vehicle.getSeatingCapacity()) {
                    request.setAttribute("error", "Number of passengers exceeds seating capacity. Please select another vehicle type.");
                    request.getRequestDispatcher("booking.jsp").forward(request, response);
                    return;
                }

                // Step 3: Calculate total distance
                double totalDistance = distanceDAO.getDistance(pickupLocation, dropLocation);
                if (totalDistance == 0) {
                    request.setAttribute("error", "Invalid pickup or drop location. Please select valid locations.");
                    request.getRequestDispatcher("booking.jsp").forward(request, response);
                    return;
                }

                // Step 4: Calculate fare
                double finalFare = calculateFare(vehicleType, totalDistance, promoCode);

                // Step 5: Save booking details
                Booking booking = new Booking();
                booking.setCustomerId((int) request.getSession().getAttribute("customerId")); // Assume customer ID is stored in session
                booking.setVehicleType(vehicleType);
                booking.setPickupLocation(pickupLocation);
                booking.setDropLocation(dropLocation);
                booking.setTotalDistance(totalDistance);
                booking.setDate(date);
                booking.setTime(time);
                booking.setNumPassengers(numPassengers);
                booking.setPromoCodeUsed(promoCode);
                booking.setBasePrice(finalFare); // Base price before discounts
                booking.setTaxAmount(finalFare * 0.2); // Example tax rate (20%)
                booking.setDiscountAmount(finalFare - calculateFare(vehicleType, totalDistance, null)); // Promo + MegaCab discount
                booking.setFinalAmount(finalFare);
                booking.setPaymentMethod("Pending"); // Payment method not selected yet
                booking.setStatus("Pending");
                bookingDAO.addBooking(booking);

                // Step 6: Display success message
                request.setAttribute("success", "Booking successful! Your final amount is LKR " + new DecimalFormat("#.##").format(finalFare));
                request.getRequestDispatcher("booking-success.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private double calculateFare(String vehicleType, double totalDistance, String promoCode) throws SQLException {
        Pricing pricing = pricingDAO.getPricingByVehicleType(vehicleType);

        double basePrice = 0;

        // Calculate base price based on distance segments
        if (totalDistance <= 10) {
            basePrice += totalDistance * pricing.getPricePerKmBelow10();
        } else if (totalDistance <= 20) {
            basePrice += 10 * pricing.getPricePerKmBelow10();
            basePrice += (totalDistance - 10) * pricing.getPricePerKm10To20();
        } else if (totalDistance <= 50) {
            basePrice += 10 * pricing.getPricePerKmBelow10();
            basePrice += 10 * pricing.getPricePerKm10To20();
            basePrice += (totalDistance - 20) * pricing.getPricePerKm20To50();
        } else {
            basePrice += 10 * pricing.getPricePerKmBelow10();
            basePrice += 10 * pricing.getPricePerKm10To20();
            basePrice += 30 * pricing.getPricePerKm20To50();
            basePrice += (totalDistance - 50) * pricing.getPricePerKmAbove50();
        }

        // Apply tax
        double taxAmount = basePrice * (pricing.getTaxPercentage() / 100);
        double finalFare = basePrice + taxAmount;

        // Apply promo code discount
        if (promoCode != null && !promoCode.isEmpty()) {
            PromoCode promo = promoCodeDAO.getValidPromoCode(promoCode);
            if (promo != null) {
                double promoDiscount = finalFare * (promo.getDiscountPercentage() / 100);
                finalFare -= promoDiscount;
            }
        }

        // Apply MegaCab discount
        Discount discount = discountDAO.getActiveDiscountForRange(vehicleType, totalDistance);
        if (discount != null) {
            double megaCabDiscount = finalFare * (discount.getDiscountPercentage() / 100);
            finalFare -= megaCabDiscount;
        }

        return finalFare;
    }
}