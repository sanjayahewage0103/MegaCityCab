package com.example.megacitycab.listener;

import com.example.megacitycab.util.DatabaseConnection;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Application started.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            DatabaseConnection.getInstance().closeConnection();
            System.out.println("Database connection closed during application shutdown.");
        } catch (Exception e) {
            System.err.println("Error closing database connection during shutdown: " + e.getMessage());
        }
    }
}