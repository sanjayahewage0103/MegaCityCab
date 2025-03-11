package com.example.megacitycab.service;

import com.example.megacitycab.dao.*;
import com.example.megacitycab.model.*;
import jakarta.servlet.ServletException;

import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.List;

public class BookingService {

    private final BookingDAO bookingDAO;
    private final VehicleDAO vehicleDAO;
    private final PromoCodeDAO promoCodeDAO;
    private final DiscountDAO discountDAO;
    private final PricingDAO pricingDAO;

    public BookingService(BookingDAO bookingDAO, VehicleDAO vehicleDAO, PromoCodeDAO promoCodeDAO,
                          DiscountDAO discountDAO, PricingDAO pricingDAO) {
        this.bookingDAO = bookingDAO;
        this.vehicleDAO = vehicleDAO;
        this.promoCodeDAO = promoCodeDAO;
        this.discountDAO = discountDAO;
        this.pricingDAO = pricingDAO;
    }

    public void createBooking(Booking booking) throws SQLException {
        Vehicle vehicle = vehicleDAO.getVehicleByType(booking.getVehicleType());
        if (booking.getNumPassengers() > vehicle.getSeatingCapacity()) {
            throw new IllegalArgumentException("Number of passengers exceeds seating capacity. Please select another vehicle type.");
        }

        double totalDistance = booking.getTotalDistance();
        if (totalDistance <= 0) {
            throw new IllegalArgumentException("Invalid distance. Please check pickup and drop locations.");
        }

        double finalFare = calculateFare(booking.getVehicleType(), totalDistance, booking.getPromoCodeUsed());

        booking.setBasePrice(finalFare);
        booking.setTaxAmount(finalFare * 0.2); // Assuming 20% tax
        booking.setDiscountAmount(0); // Adjust as needed
        booking.setFinalAmount(finalFare);

        bookingDAO.addBooking(booking);
    }

    public List<Booking> getAllBookings() throws SQLException {
        return bookingDAO.getAllBookings();
    }

    public Booking getBookingDetails(int bookingId) throws SQLException {
        return bookingDAO.getBookingById(bookingId);
    }

    public void updateBookingStatus(int bookingId, String status) throws SQLException {
        bookingDAO.updateBookingStatus(bookingId, status);
    }

    public void cancelBooking(int bookingId) throws SQLException {
        updateBookingStatus(bookingId, "Cancelled");
    }

    public double calculateFare(String vehicleType, double totalDistance, String promoCode) throws SQLException {
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

        double taxAmount = basePrice * (pricing.getTaxPercentage() / 100);
        double finalFare = basePrice + taxAmount;

        if (promoCode != null && !promoCode.isEmpty()) {
            PromoCode promo = promoCodeDAO.getValidPromoCode(promoCode);
            if (promo == null || !promo.getStatus().equals("Active")) {
                throw new IllegalArgumentException("Invalid or expired promo code.");
            }
            double promoDiscount = finalFare * (promo.getDiscountPercentage() / 100);
            finalFare -= promoDiscount;
        }

        Discount discount = discountDAO.getActiveDiscountForRange(vehicleType, totalDistance);
        if (discount != null) {
            double megaCabDiscount = finalFare * (discount.getDiscountPercentage() / 100);
            finalFare -= megaCabDiscount;
        }

        return finalFare;
    }
}