package com.example.megacitycab.service;

import com.example.megacitycab.dao.DiscountDAO;
import com.example.megacitycab.model.Discount;

import java.sql.SQLException;
import java.util.List;

public class DiscountService {
    private DiscountDAO discountDAO;

    public DiscountService() throws SQLException {
        this.discountDAO = new DiscountDAO();
    }

    public List<Discount> getAllDiscounts() throws SQLException {
        return discountDAO.getAllDiscounts();
    }

    public void addDiscount(Discount discount) throws SQLException {
        discountDAO.addDiscount(discount);
    }

    public void updateDiscount(Discount discount) throws SQLException {
        discountDAO.updateDiscount(discount);
    }

    public void deleteDiscount(int discountId) throws SQLException {
        discountDAO.deleteDiscount(discountId);
    }

    public int getActiveDiscountCount() throws SQLException {
        return discountDAO.getActiveDiscountCount();
    }

    public int getInactiveDiscountCount() throws SQLException {
        return discountDAO.getInactiveDiscountCount();
    }
}