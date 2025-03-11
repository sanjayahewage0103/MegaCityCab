package com.example.megacitycab.service;

import com.example.megacitycab.dao.CustomerDAO;
import com.example.megacitycab.util.PasswordHasher;

public class AuthenticationService {
    private CustomerDAO customerDAO;

    public AuthenticationService() {
        this.customerDAO = new CustomerDAO();
    }

    public boolean authenticateCustomer(String email, String password) {
        String storedHashedPassword = customerDAO.getHashedPasswordByEmail(email);

        if (storedHashedPassword == null) {
            return false;
        }
        String hashedInputPassword = PasswordHasher.hashPassword(password);
        return storedHashedPassword.equals(hashedInputPassword);
    }
}