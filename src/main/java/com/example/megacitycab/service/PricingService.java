package com.example.megacitycab.service;

import com.example.megacitycab.dao.PricingDAO;
import com.example.megacitycab.model.Pricing;

import java.sql.SQLException;
import java.util.List;

public class PricingService {
    private PricingDAO pricingDAO;

    public PricingService() throws SQLException {
        this.pricingDAO = new PricingDAO();
    }

    public List<Pricing> getAllPricings() throws SQLException {
        return pricingDAO.getAllPricings();
    }

    public void updatePricing(Pricing pricing) throws SQLException {
        pricingDAO.updatePricing(pricing);
    }
}