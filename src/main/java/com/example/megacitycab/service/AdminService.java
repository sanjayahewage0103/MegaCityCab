package com.example.megacitycab.service;

import com.example.megacitycab.util.AdminCredentialsManager;

public class AdminService {
    private AdminCredentialsManager adminCredentialsManager;

    public AdminService() {
        this.adminCredentialsManager = AdminCredentialsManager.getInstance();
    }

    // Method to authenticate admin
    public boolean authenticateAdmin(String username, String password) {
        return adminCredentialsManager.validateAdmin(username, password);
    }
}