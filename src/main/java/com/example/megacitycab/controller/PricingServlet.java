package com.example.megacitycab.controller;

import com.example.megacitycab.model.Pricing;
import com.example.megacitycab.service.PricingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class PricingServlet extends HttpServlet {
    private PricingService pricingService;

    @Override
    public void init() throws ServletException {
        try {
            pricingService = new PricingService();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize PricingService", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Pricing> pricings = pricingService.getAllPricings();
            request.setAttribute("pricings", pricings);
            request.getRequestDispatcher("manage-pricing.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int pricingId = Integer.parseInt(request.getParameter("pricingId"));
            double taxPercentage = Double.parseDouble(request.getParameter("taxPercentage"));
            double pricePerKmBelow10 = Double.parseDouble(request.getParameter("pricePerKmBelow10"));
            double pricePerKm10To20 = Double.parseDouble(request.getParameter("pricePerKm10To20"));
            double pricePerKm20To50 = Double.parseDouble(request.getParameter("pricePerKm20To50"));
            double pricePerKmAbove50 = Double.parseDouble(request.getParameter("pricePerKmAbove50"));

            Pricing pricing = new Pricing();
            pricing.setPricingId(pricingId);
            pricing.setTaxPercentage(taxPercentage);
            pricing.setPricePerKmBelow10(pricePerKmBelow10);
            pricing.setPricePerKm10To20(pricePerKm10To20);
            pricing.setPricePerKm20To50(pricePerKm20To50);
            pricing.setPricePerKmAbove50(pricePerKmAbove50);

            pricingService.updatePricing(pricing);
            response.sendRedirect("pricing-servlet?message=Pricing updated successfully.");
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}