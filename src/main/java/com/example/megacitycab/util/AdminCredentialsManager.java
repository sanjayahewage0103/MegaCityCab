package com.example.megacitycab.util;

public class AdminCredentialsManager {
    // Singleton instance
    private static AdminCredentialsManager instance;

    // Hardcoded admin credentials
    private final String ADMIN_USERNAME = "admin";
    private final String ADMIN_PASSWORD = "admin123";

    // Private constructor to prevent instantiation
    private AdminCredentialsManager() {}

    // Method to get the Singleton instance
    public static synchronized AdminCredentialsManager getInstance() {
        if (instance == null) {
            instance = new AdminCredentialsManager();
        }
        return instance;
    }

    // Method to validate admin credentials
    public boolean validateAdmin(String username, String password) {
        return ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password);
    }
}