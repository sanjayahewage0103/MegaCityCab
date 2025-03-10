package com.example.megacitycab.service;

import com.example.megacitycab.dao.PromoCodeDAO;
import com.example.megacitycab.model.PromoCode;

import java.sql.SQLException;
import java.util.List;

public class PromoCodeService {
    private PromoCodeDAO promoCodeDAO;

    public PromoCodeService() throws SQLException {
        this.promoCodeDAO = new PromoCodeDAO();
    }

    public void addPromoCode(PromoCode promoCode) throws SQLException {
        promoCodeDAO.addPromoCode(promoCode);
    }

    public List<PromoCode> getAllPromoCodes() throws SQLException {
        return promoCodeDAO.getAllPromoCodes();
    }

    public List<PromoCode> searchPromoCodes(String searchTerm) throws SQLException {
        return promoCodeDAO.searchPromoCodes(searchTerm);
    }

    public void updatePromoCode(PromoCode promoCode) throws SQLException {
        promoCodeDAO.updatePromoCode(promoCode);
    }

    public void deletePromoCode(int id) throws SQLException {
        promoCodeDAO.deletePromoCode(id);
    }

    public int getTotalPromoCodes() throws SQLException {
        return promoCodeDAO.getTotalPromoCodes();
    }

    public int getActivePromoCodes() throws SQLException {
        return promoCodeDAO.getActivePromoCodes();
    }

    public int getExpiredPromoCodes() throws SQLException {
        return promoCodeDAO.getExpiredPromoCodes();
    }
}