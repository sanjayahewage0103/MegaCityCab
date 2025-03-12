package com.example.megacitycab.service;

import com.example.megacitycab.dao.DriverDAO;
import com.example.megacitycab.model.Driver;

import java.sql.SQLException;
import java.util.List;

public class DriverService {
    private final DriverDAO driverDAO;

    // Existing no-argument constructor
    public DriverService() throws SQLException {
        this.driverDAO = new DriverDAO();
    }

    // New constructor to accept a DriverDAO object
    public DriverService(DriverDAO driverDAO) {
        this.driverDAO = driverDAO;
    }

    public List<Driver> getAllDrivers() throws SQLException {
        return driverDAO.getAllDrivers();
    }

    public void addDriver(Driver driver) throws SQLException {
        if (driverDAO.isNICExists(driver.getNic())) {
            throw new SQLException("NIC already exists: " + driver.getNic());
        }
        driverDAO.addDriver(driver);
    }

    public void updateDriver(Driver driver) throws SQLException {
        driverDAO.updateDriver(driver);
    }

    public void deleteDriver(int driverId) throws SQLException {
        driverDAO.deleteDriver(driverId);
    }

    public int getTotalDriverCount() throws SQLException {
        return driverDAO.getTotalDriverCount();
    }

    public int getActiveDriverCount() throws SQLException {
        return driverDAO.getActiveDriverCount();
    }

    public int getInactiveDriverCount() throws SQLException {
        return driverDAO.getInactiveDriverCount();
    }

    public List<Driver> searchDrivers(String query) throws SQLException {
        return driverDAO.searchDrivers(query);
    }

    // Method to fetch all available drivers
    public List<Driver> getAvailableDrivers() throws SQLException {
        return driverDAO.getAvailableDrivers();
    }

    public void updateDriverStatus(int driverId, String status) throws SQLException {
        driverDAO.updateDriverStatus(driverId, status);
    }
}