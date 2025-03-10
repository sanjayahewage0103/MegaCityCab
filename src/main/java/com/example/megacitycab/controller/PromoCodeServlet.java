package com.example.megacitycab.controller;

import com.example.megacitycab.model.PromoCode;
import com.example.megacitycab.service.PromoCodeService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

public class PromoCodeServlet extends HttpServlet {
    private PromoCodeService promoCodeService;

    @Override
    public void init() throws ServletException {
        try {
            promoCodeService = new PromoCodeService();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize PromoCodeService", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("search".equals(action)) {
                String searchTerm = request.getParameter("search");
                List<PromoCode> promoCodes = promoCodeService.searchPromoCodes(searchTerm);
                request.setAttribute("promoCodes", promoCodes);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                promoCodeService.deletePromoCode(id);
                response.sendRedirect("promo-code-servlet?message=Promo code deleted successfully.");
                return;
            } else {
                // Default: Fetch all promo codes
                List<PromoCode> promoCodes = promoCodeService.getAllPromoCodes();
                request.setAttribute("promoCodes", promoCodes);
            }

            // Fetch promo code statistics
            int totalPromoCodes = promoCodeService.getTotalPromoCodes();
            int activePromoCodes = promoCodeService.getActivePromoCodes();
            int expiredPromoCodes = promoCodeService.getExpiredPromoCodes();

            request.setAttribute("totalPromoCodes", totalPromoCodes);
            request.setAttribute("activePromoCodes", activePromoCodes);
            request.setAttribute("expiredPromoCodes", expiredPromoCodes);

            request.getRequestDispatcher("manage-promo-codes.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                PromoCode promoCode = new PromoCode();
                promoCode.setPromoCode(request.getParameter("promoCode"));
                promoCode.setDiscountPercentage(Double.parseDouble(request.getParameter("discountPercentage")));
                promoCode.setValidFrom(new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("validFrom")).getTime()));
                promoCode.setValidUntil(new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("validUntil")).getTime()));
                promoCode.setStatus(request.getParameter("status"));

                promoCodeService.addPromoCode(promoCode);
                response.sendRedirect("promo-code-servlet?message=Promo code added successfully.");
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                PromoCode promoCode = new PromoCode();
                promoCode.setId(id);
                promoCode.setPromoCode(request.getParameter("promoCode"));
                promoCode.setDiscountPercentage(Double.parseDouble(request.getParameter("discountPercentage")));
                promoCode.setValidFrom(new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("validFrom")).getTime()));
                promoCode.setValidUntil(new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("validUntil")).getTime()));
                promoCode.setStatus(request.getParameter("status"));

                promoCodeService.updatePromoCode(promoCode);
                response.sendRedirect("promo-code-servlet?message=Promo code updated successfully.");
            }
        } catch (SQLException | ParseException e) {
            throw new ServletException("Database error", e);
        }
    }
}