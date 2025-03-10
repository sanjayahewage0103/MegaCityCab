package com.example.megacitycab.model;

import java.sql.Timestamp;

public class Pricing {
    private int pricingId;
    private String vehicleType; // SUV, Sedan, Van
    private double taxPercentage;
    private double pricePerKmBelow10;
    private double pricePerKm10To20;
    private double pricePerKm20To50;
    private double pricePerKmAbove50;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default Constructor
    public Pricing() {}

    // Parameterized Constructor
    public Pricing(int pricingId, String vehicleType, double taxPercentage, double pricePerKmBelow10,
                   double pricePerKm10To20, double pricePerKm20To50, double pricePerKmAbove50,
                   Timestamp createdAt, Timestamp updatedAt) {
        this.pricingId = pricingId;
        this.vehicleType = vehicleType;
        this.taxPercentage = taxPercentage;
        this.pricePerKmBelow10 = pricePerKmBelow10;
        this.pricePerKm10To20 = pricePerKm10To20;
        this.pricePerKm20To50 = pricePerKm20To50;
        this.pricePerKmAbove50 = pricePerKmAbove50;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getPricingId() {
        return pricingId;
    }

    public void setPricingId(int pricingId) {
        this.pricingId = pricingId;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public double getTaxPercentage() {
        return taxPercentage;
    }

    public void setTaxPercentage(double taxPercentage) {
        this.taxPercentage = taxPercentage;
    }

    public double getPricePerKmBelow10() {
        return pricePerKmBelow10;
    }

    public void setPricePerKmBelow10(double pricePerKmBelow10) {
        this.pricePerKmBelow10 = pricePerKmBelow10;
    }

    public double getPricePerKm10To20() {
        return pricePerKm10To20;
    }

    public void setPricePerKm10To20(double pricePerKm10To20) {
        this.pricePerKm10To20 = pricePerKm10To20;
    }

    public double getPricePerKm20To50() {
        return pricePerKm20To50;
    }

    public void setPricePerKm20To50(double pricePerKm20To50) {
        this.pricePerKm20To50 = pricePerKm20To50;
    }

    public double getPricePerKmAbove50() {
        return pricePerKmAbove50;
    }

    public void setPricePerKmAbove50(double pricePerKmAbove50) {
        this.pricePerKmAbove50 = pricePerKmAbove50;
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
}