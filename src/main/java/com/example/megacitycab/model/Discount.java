package com.example.megacitycab.model;

import java.sql.Timestamp;

public class Discount {
    private int discountId;
    private String vehicleType;
    private int kmRangeStart;
    private int kmRangeEnd;
    private double discountPercentage;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Getters and Setters
    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public int getKmRangeStart() {
        return kmRangeStart;
    }

    public void setKmRangeStart(int kmRangeStart) {
        this.kmRangeStart = kmRangeStart;
    }

    public int getKmRangeEnd() {
        return kmRangeEnd;
    }

    public void setKmRangeEnd(int kmRangeEnd) {
        this.kmRangeEnd = kmRangeEnd;
    }

    public double getDiscountPercentage() {
        return discountPercentage;
    }

    public void setDiscountPercentage(double discountPercentage) {
        this.discountPercentage = discountPercentage;
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
}