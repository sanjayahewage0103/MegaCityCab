package com.example.megacitycab.service;

import com.example.megacitycab.dao.VehicleDAO;
import com.example.megacitycab.model.Vehicle;

import java.sql.SQLException;
import java.util.List;

public class VehicleService {
    private final VehicleDAO vehicleDAO;

    // Existing no-argument constructor
    public VehicleService() {
        this.vehicleDAO = new VehicleDAO();
    }

    // New constructor to accept a VehicleDAO object
    public VehicleService(VehicleDAO vehicleDAO) {
        this.vehicleDAO = vehicleDAO;
    }

    public boolean addVehicle(Vehicle vehicle) throws SQLException {
        return vehicleDAO.addVehicle(vehicle);
    }

    public List<Vehicle> getAllVehicles() throws SQLException {
        return vehicleDAO.getAllVehicles();
    }

    public boolean updateVehicle(Vehicle vehicle) throws SQLException {
        return vehicleDAO.updateVehicle(vehicle);
    }

    public boolean deleteVehicle(int vehicleId) throws SQLException {
        return vehicleDAO.deleteVehicle(vehicleId);
    }

    public List<Vehicle> searchVehicles(String queryParam) throws SQLException {
        return vehicleDAO.searchVehicles(queryParam);
    }

    // Method to fetch all available vehicles with optional filtering by type
    public List<Vehicle> getAvailableVehicles(String type) throws SQLException {
        return vehicleDAO.getAvailableVehicles(type);
    }

    // Method to update vehicle status
    public void updateVehicleStatus(int vehicleId, String status) throws SQLException {
        vehicleDAO.updateVehicleStatus(vehicleId, status);
    }
}