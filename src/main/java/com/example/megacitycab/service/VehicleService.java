package com.example.megacitycab.service;

import com.example.megacitycab.dao.VehicleDAO;
import com.example.megacitycab.model.Vehicle;

import java.sql.SQLException;
import java.util.List;

public class VehicleService {

    private final VehicleDAO vehicleDAO;

    public VehicleService() {
        this.vehicleDAO = new VehicleDAO();
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
}