package com.example.megacitycab.controller;

import com.example.megacitycab.model.Discount;
import com.example.megacitycab.service.DiscountService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class DiscountServlet extends HttpServlet {
    private DiscountService discountService;

    @Override
    public void init() throws ServletException {
        try {
            discountService = new DiscountService();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize DiscountService", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Discount> discounts = discountService.getAllDiscounts();
            request.setAttribute("discounts", discounts);

            int activeDiscounts = discountService.getActiveDiscountCount();
            int inactiveDiscounts = discountService.getInactiveDiscountCount();
            request.setAttribute("activeDiscounts", activeDiscounts);
            request.setAttribute("inactiveDiscounts", inactiveDiscounts);

            request.getRequestDispatcher("manage-discount.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                Discount discount = new Discount();
                discount.setVehicleType(request.getParameter("vehicleType"));
                discount.setKmRangeStart(Integer.parseInt(request.getParameter("kmRangeStart")));
                discount.setKmRangeEnd(Integer.parseInt(request.getParameter("kmRangeEnd")));
                discount.setDiscountPercentage(Double.parseDouble(request.getParameter("discountPercentage")));
                discount.setStatus(request.getParameter("status"));

                discountService.addDiscount(discount);
                response.sendRedirect("discount-servlet?message=Discount added successfully.");
            } else if ("update".equals(action)) {
                int discountId = Integer.parseInt(request.getParameter("id"));
                Discount discount = new Discount();
                discount.setDiscountId(discountId);
                discount.setVehicleType(request.getParameter("vehicleType"));
                discount.setKmRangeStart(Integer.parseInt(request.getParameter("kmRangeStart")));
                discount.setKmRangeEnd(Integer.parseInt(request.getParameter("kmRangeEnd")));
                discount.setDiscountPercentage(Double.parseDouble(request.getParameter("discountPercentage")));
                discount.setStatus(request.getParameter("status"));

                discountService.updateDiscount(discount);
                response.sendRedirect("discount-servlet?message=Discount updated successfully.");
            }else if ("delete".equals(action)) {
                int discountId = Integer.parseInt(request.getParameter("id"));
                try {
                    discountService.deleteDiscount(discountId);
                    response.sendRedirect("discount-servlet?message=Discount deleted successfully.");
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.sendRedirect("discount-servlet?error=Database error while deleting discount.");
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}