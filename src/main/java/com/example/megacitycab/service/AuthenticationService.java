package com.example.megacitycab.service;

import com.example.megacitycab.dao.CustomerDAO;
import com.example.megacitycab.util.PasswordHasher;

public class AuthenticationService {
    private CustomerDAO customerDAO;

    public AuthenticationService() {
        this.customerDAO = new CustomerDAO();
    }

    public boolean authenticateCustomer(String email, String password) {
        // Retrieve the hashed password from the database
        String storedHashedPassword = customerDAO.getHashedPasswordByEmail(email);

        if (storedHashedPassword == null) {
            return false; // Email not found
        }

        // Hash the input password and compare with the stored hash
        String hashedInputPassword = PasswordHasher.hashPassword(password);
        return storedHashedPassword.equals(hashedInputPassword);
    }
}