package com.example.megacitycab.model;

import java.sql.Timestamp;

public class VehicleAssignment {
    private int assignmentId;
    private int bookingId;
    private int vehicleId;
    private int driverId;
    private Timestamp assignedAt;
    private String status;

    // Constructors
    public VehicleAssignment() {}

    public VehicleAssignment(int bookingId, int vehicleId, int driverId, String status) {
        this.bookingId = bookingId;
        this.vehicleId = vehicleId;
        this.driverId = driverId;
        this.status = status;
    }

    // Getters and Setters
    public int getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(int assignmentId) {
        this.assignmentId = assignmentId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public Timestamp getAssignedAt() {
        return assignedAt;
    }

    public void setAssignedAt(Timestamp assignedAt) {
        this.assignedAt = assignedAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "VehicleAssignment{" +
                "assignmentId=" + assignmentId +
                ", bookingId=" + bookingId +
                ", vehicleId=" + vehicleId +
                ", driverId=" + driverId +
                ", assignedAt=" + assignedAt +
                ", status='" + status + '\'' +
                '}';
    }
}