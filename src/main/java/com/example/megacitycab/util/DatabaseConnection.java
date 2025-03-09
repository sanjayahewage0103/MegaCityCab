package com.example.megacitycab.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static DatabaseConnection instance;
    private Connection connection;

    // Private constructor to prevent instantiation
    private DatabaseConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Explicitly load the driver
            System.out.println("MySQL JDBC Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            throw new SQLException("Driver not found", e);
        }

        String url = "jdbc:mysql://127.0.0.1:3306/megacitycab?useSSL=false&serverTimezone=UTC";
        String username = "root";
        String password = ""; // Leave empty for WAMP default

        System.out.println("Connecting to database: " + url);
        connection = DriverManager.getConnection(url, username, password);
        System.out.println("Database connection established.");
    }

    // Singleton instance getter
    public static synchronized DatabaseConnection getInstance() throws SQLException {
        if (instance == null || instance.connection == null || instance.connection.isClosed()) {
            instance = new DatabaseConnection();
        }
        return instance;
    }

    // Getter for the database connection (non-static)
    public Connection getConnection() {
        return connection;
    }

    // Close the connection (only call this during application shutdown)
    public void closeConnection() {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                    System.out.println("Database connection closed.");
                }
            } catch (SQLException e) {
                System.err.println("Error closing the database connection: " + e.getMessage());
            }
        }
    }
}
