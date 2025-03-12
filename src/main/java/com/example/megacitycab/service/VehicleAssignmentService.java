package com.example.megacitycab.service;

import com.example.megacitycab.dao.VehicleAssignmentDAO;

import java.sql.SQLException;

public class VehicleAssignmentService {
    private final VehicleAssignmentDAO vehicleAssignmentDAO;

    public VehicleAssignmentService(VehicleAssignmentDAO vehicleAssignmentDAO) {
        this.vehicleAssignmentDAO = vehicleAssignmentDAO;
    }

    // Assign vehicle and driver to a booking
    public void assignVehicleAndDriver(int bookingId, int vehicleId, int driverId) throws SQLException {
        vehicleAssignmentDAO.assignVehicleAndDriver(bookingId, vehicleId, driverId);
    }
}