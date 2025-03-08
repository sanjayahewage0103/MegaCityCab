package com.example.megacitycab.service;

import com.example.megacitycab.dao.DriverDAO;
import com.example.megacitycab.model.Driver;

import java.sql.SQLException;
import java.util.List;

public class DriverService {
    private DriverDAO driverDAO;

    public DriverService() throws SQLException {
        this.driverDAO = new DriverDAO();
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

}