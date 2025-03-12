package com.example.megacitycab.service;

import com.example.megacitycab.dao.DistanceDAO;

import java.sql.SQLException;
import java.util.Set;

public class DistanceService {
    private final DistanceDAO distanceDAO;

    public DistanceService(DistanceDAO distanceDAO) {
        this.distanceDAO = distanceDAO;
    }

    // Fetch all unique locations
    public Set<String> getAllUniqueLocations() throws SQLException {
        return distanceDAO.getAllUniqueLocations();
    }
}