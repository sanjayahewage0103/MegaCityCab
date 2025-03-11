package com.example.megacitycab.controller;

import com.example.megacitycab.dao.*;
import com.example.megacitycab.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

public class BookingServlet extends HttpServlet {
    private PricingDAO pricingDAO;
    private PromoCodeDAO promoCodeDAO;
    private DiscountDAO discountDAO;
    private DistanceDAO distanceDAO;
    private VehicleDAO vehicleDAO;

    @Override
    public void init() throws ServletException {
        try {
            System.out.println("Initializing DAOs...");
            pricingDAO = new PricingDAO();
            promoCodeDAO = new PromoCodeDAO();
            discountDAO = new DiscountDAO();
            distanceDAO = new DistanceDAO();
            vehicleDAO = new VehicleDAO();
            System.out.println("DAOs initialized successfully.");
        } catch (SQLException e) {
            System.err.println("Failed to initialize DAOs: " + e.getMessage());
            throw new ServletException("Failed to initialize DAOs", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("calculate-fare".equals(action)) {
            try {
                HttpSession session = request.getSession(false);
                if (session == null || session.getAttribute("customerId") == null) {
                    response.sendRedirect("login.jsp?error=You must log in to make a booking.");
                    return;
                }

                int customerId = (int) session.getAttribute("customerId");
                String vehicleType = request.getParameter("vehicleType");
                String pickupLocation = request.getParameter("pickupLocation");
                String dropLocation = request.getParameter("dropLocation");
                String date = request.getParameter("date");
                String time = request.getParameter("time");
                int numPassengers = Integer.parseInt(request.getParameter("numPassengers"));
                String promoCode = request.getParameter("promoCode");

                // Validate seating capacity
                Vehicle vehicle = vehicleDAO.getVehicleByType(vehicleType);
                if (numPassengers > vehicle.getSeatingCapacity()) {
                    request.setAttribute("error", "Number of passengers exceeds seating capacity.");
                    request.getRequestDispatcher("make-booking.jsp").forward(request, response);
                    return;
                }

                // Calculate distance
                double totalDistance = distanceDAO.getDistance(pickupLocation, dropLocation);
                if (totalDistance == 0) {
                    request.setAttribute("error", "Invalid pickup or drop location.");
                    request.getRequestDispatcher("make-booking.jsp").forward(request, response);
                    return;
                }

                // Calculate fare
                FareDetails fareDetails = calculateFare(vehicleType, totalDistance, promoCode);

                // Set attributes for payment JSP
                request.setAttribute("customerId", customerId);
                request.setAttribute("pickupLocation", pickupLocation);
                request.setAttribute("dropLocation", dropLocation);
                request.setAttribute("date", date);
                request.setAttribute("time", time);
                request.setAttribute("numPassengers", numPassengers);
                request.setAttribute("vehicleType", vehicleType);
                request.setAttribute("totalDistance", totalDistance);
                request.setAttribute("basePrice", fareDetails.getBasePrice());
                request.setAttribute("taxAmount", fareDetails.getTaxAmount());
                request.setAttribute("discountAmount", fareDetails.getDiscountAmount());
                request.setAttribute("finalFare", fareDetails.getFinalFare());

                request.getRequestDispatcher("payment-details.jsp").forward(request, response);

            } catch (SQLException e) {
                System.err.println("Database error occurred: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "Database error occurred. Please try again later.");
                request.getRequestDispatcher("make-booking.jsp").forward(request, response);
            }
        }
    }

    private FareDetails calculateFare(String vehicleType, double totalDistance, String promoCode) throws SQLException {
        System.out.println("Fetching pricing rules for vehicle type: " + vehicleType);
        Pricing pricing = pricingDAO.getPricingByVehicleType(vehicleType);
        if (pricing == null) {
            System.err.println("Pricing rules not found for vehicle type: " + vehicleType);
            throw new SQLException("Pricing rules not found for vehicle type: " + vehicleType);
        }

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
        double discountAmount = 0;
        if (promoCode != null && !promoCode.isEmpty()) {
            System.out.println("Checking validity of promo code: " + promoCode);
            PromoCode promo = promoCodeDAO.getValidPromoCode(promoCode);
            if (promo != null) {
                discountAmount = finalFare * (promo.getDiscountPercentage() / 100);
                finalFare -= discountAmount;
                System.out.println("Promo code applied. Discount: " + discountAmount);
            } else {
                System.out.println("Invalid or expired promo code: " + promoCode);
            }
        }

        // Apply MegaCab discount
        System.out.println("Checking for MegaCab discounts...");
        Discount discount = discountDAO.getActiveDiscountForRange(vehicleType, totalDistance);
        if (discount != null) {
            double megaCabDiscount = finalFare * (discount.getDiscountPercentage() / 100);
            discountAmount += megaCabDiscount;
            finalFare -= megaCabDiscount;
            System.out.println("MegaCab discount applied. Discount: " + megaCabDiscount);
        }

        System.out.println("Final fare calculated: " + finalFare);
        return new FareDetails(basePrice, taxAmount, discountAmount, finalFare);
    }

    private static class FareDetails {
        private double basePrice;
        private double taxAmount;
        private double discountAmount;
        private double finalFare;

        public FareDetails(double basePrice, double taxAmount, double discountAmount, double finalFare) {
            this.basePrice = basePrice;
            this.taxAmount = taxAmount;
            this.discountAmount = discountAmount;
            this.finalFare = finalFare;
        }

        public double getBasePrice() {
            return basePrice;
        }

        public double getTaxAmount() {
            return taxAmount;
        }

        public double getDiscountAmount() {
            return discountAmount;
        }

        public double getFinalFare() {
            return finalFare;
        }
    }
}