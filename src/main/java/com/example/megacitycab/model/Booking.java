package com.example.megacitycab.model;

import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private int customerId;
    private String vehicleType;
    private String pickupLocation;
    private String dropLocation;
    private double totalDistance;
    private String date;
    private String time;
    private int numPassengers;
    private String promoCodeUsed;
    private double basePrice;
    private double taxAmount;
    private double discountAmount;
    private double finalAmount;
    private String paymentMethod;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt; // Add this line to declare the updatedAt field
    private String paymentStatus;
    private String vehicleNumber;
    private String driverName;
    private int driverId;
    private int paymentId;
    private String customerName;
    private int vehicleId;
    private String CustomerMobile;
    private String vehicleColor;
    private String transactionId;

    public Booking() {}

    public Booking(int customerId, String vehicleType, String pickupLocation, String dropLocation, double totalDistance,
                   String date, String time, int numPassengers, String promoCodeUsed, double basePrice,
                   double taxAmount, double discountAmount, double finalAmount, String paymentMethod, String status,
                   String CustomerMobile, String vehicleColor, String transactionId) {
        this.customerId = customerId;
        this.vehicleType = vehicleType;
        this.pickupLocation = pickupLocation;
        this.dropLocation = dropLocation;
        this.totalDistance = totalDistance;
        this.date = date;
        this.time = time;
        this.numPassengers = numPassengers;
        this.promoCodeUsed = promoCodeUsed;
        this.basePrice = basePrice;
        this.taxAmount = taxAmount;
        this.discountAmount = discountAmount;
        this.finalAmount = finalAmount;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.CustomerMobile = CustomerMobile;
        this.vehicleColor = vehicleColor;
        this.transactionId = transactionId;
    }


    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getDropLocation() {
        return dropLocation;
    }

    public void setDropLocation(String dropLocation) {
        this.dropLocation = dropLocation;
    }

    public double getTotalDistance() {
        return totalDistance;
    }

    public void setTotalDistance(double totalDistance) {
        this.totalDistance = totalDistance;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public int getNumPassengers() {
        return numPassengers;
    }

    public void setNumPassengers(int numPassengers) {
        this.numPassengers = numPassengers;
    }

    public String getPromoCodeUsed() {
        return promoCodeUsed;
    }

    public void setPromoCodeUsed(String promoCodeUsed) {
        this.promoCodeUsed = promoCodeUsed;
    }

    public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public double getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(double taxAmount) {
        this.taxAmount = taxAmount;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public double getFinalAmount() {
        return finalAmount;
    }

    public void setFinalAmount(double finalAmount) {
        this.finalAmount = finalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getCustomerMobile() {
        return CustomerMobile;
    }

    public void setCustomerMobile(String CustomerMobile) {
        this.CustomerMobile = CustomerMobile;
    }

    public String getVehicleColor() {
        return vehicleColor;
    }

    public void setVehicleColor(String vehicleColor) {
        this.vehicleColor = vehicleColor;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    @Override
    public String toString() {
        return "Booking{" +
                "bookingId=" + bookingId +
                ", customerId=" + customerId +
                ", vehicleType='" + vehicleType + '\'' +
                ", pickupLocation='" + pickupLocation + '\'' +
                ", dropLocation='" + dropLocation + '\'' +
                ", totalDistance=" + totalDistance +
                ", date='" + date + '\'' +
                ", time='" + time + '\'' +
                ", numPassengers=" + numPassengers +
                ", promoCodeUsed='" + promoCodeUsed + '\'' +
                ", basePrice=" + basePrice +
                ", taxAmount=" + taxAmount +
                ", discountAmount=" + discountAmount +
                ", finalAmount=" + finalAmount +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", vehicleNumber='" + vehicleNumber + '\'' +
                ", driverName='" + driverName + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", driverId=" + driverId +
                ", paymentId=" + paymentId +
                ", customerName='" + customerName + '\'' +
                ", mobileNumber='" + CustomerMobile + '\'' +
                ", vehicleColor='" + vehicleColor + '\'' +
                ", transactionId='" + transactionId + '\'' +
                '}';
    }
}