package com.example.megacitycab.dao;

import com.example.megacitycab.model.Vehicle;
import com.example.megacitycab.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {

    // Add a new vehicle
    public boolean addVehicle(Vehicle vehicle) throws SQLException {
        String query = "INSERT INTO vehicle (vehicle_number, color, register_number, model, type, seating_capacity, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, vehicle.getVehicleNumber());
            statement.setString(2, vehicle.getColor());
            statement.setString(3, vehicle.getRegisterNumber());
            statement.setString(4, vehicle.getModel());
            statement.setString(5, vehicle.getType());
            statement.setInt(6, vehicle.getSeatingCapacity());
            statement.setString(7, vehicle.getStatus());
            return statement.executeUpdate() > 0;
        }
    }

    // Fetch all vehicles
    public List<Vehicle> getAllVehicles() throws SQLException {
        List<Vehicle> vehicles = new ArrayList<>();
        String query = "SELECT * FROM vehicle";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {
            while (resultSet.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setVehicleId(resultSet.getInt("vehicle_id"));
                vehicle.setVehicleNumber(resultSet.getString("vehicle_number"));
                vehicle.setColor(resultSet.getString("color"));
                vehicle.setRegisterNumber(resultSet.getString("register_number"));
                vehicle.setModel(resultSet.getString("model"));
                vehicle.setType(resultSet.getString("type"));
                vehicle.setSeatingCapacity(resultSet.getInt("seating_capacity"));
                vehicle.setStatus(resultSet.getString("status"));
                vehicles.add(vehicle);
            }
        }
        return vehicles;
    }

    // Update an existing vehicle
    public boolean updateVehicle(Vehicle vehicle) throws SQLException {
        String query = "UPDATE vehicle SET vehicle_number = ?, color = ?, register_number = ?, model = ?, type = ?, seating_capacity = ?, status = ? WHERE vehicle_id = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, vehicle.getVehicleNumber());
            statement.setString(2, vehicle.getColor());
            statement.setString(3, vehicle.getRegisterNumber());
            statement.setString(4, vehicle.getModel());
            statement.setString(5, vehicle.getType());
            statement.setInt(6, vehicle.getSeatingCapacity());
            statement.setString(7, vehicle.getStatus());
            statement.setInt(8, vehicle.getVehicleId());
            return statement.executeUpdate() > 0;
        }
    }

    // Delete a vehicle by ID
    public boolean deleteVehicle(int vehicleId) throws SQLException {
        String query = "DELETE FROM vehicle WHERE vehicle_id = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, vehicleId);
            return statement.executeUpdate() > 0;
        }
    }

    // Search vehicles by type or registration number
    public List<Vehicle> searchVehicles(String queryParam) throws SQLException {
        List<Vehicle> vehicles = new ArrayList<>();
        String query = "SELECT * FROM vehicle WHERE type LIKE ? OR register_number LIKE ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, "%" + queryParam + "%");
            statement.setString(2, "%" + queryParam + "%");
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setVehicleId(resultSet.getInt("vehicle_id"));
                vehicle.setVehicleNumber(resultSet.getString("vehicle_number"));
                vehicle.setColor(resultSet.getString("color"));
                vehicle.setRegisterNumber(resultSet.getString("register_number"));
                vehicle.setModel(resultSet.getString("model"));
                vehicle.setType(resultSet.getString("type"));
                vehicle.setSeatingCapacity(resultSet.getInt("seating_capacity"));
                vehicle.setStatus(resultSet.getString("status"));
                vehicles.add(vehicle);
            }
        }
        return vehicles;
    }

    // Get vehicle by type
    public Vehicle getVehicleByType(String vehicleType) throws SQLException {
        String query = "SELECT * FROM vehicle WHERE type = ? LIMIT 1"; // Assuming one vehicle per type for simplicity
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, vehicleType);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setVehicleId(resultSet.getInt("vehicle_id"));
                vehicle.setVehicleNumber(resultSet.getString("vehicle_number"));
                vehicle.setColor(resultSet.getString("color"));
                vehicle.setRegisterNumber(resultSet.getString("register_number"));
                vehicle.setModel(resultSet.getString("model"));
                vehicle.setType(resultSet.getString("type"));
                vehicle.setSeatingCapacity(resultSet.getInt("seating_capacity"));
                vehicle.setStatus(resultSet.getString("status"));
                return vehicle;
            }
        }
        return null;
    }

    // Fetch all available vehicles (status = 'Available')
    public List<Vehicle> getAvailableVehicles(String type) throws SQLException {
        String query = "SELECT * FROM vehicle WHERE status = 'Available'";
        if (type != null && !type.isEmpty()) {
            query += " AND type = ?";
        }

        List<Vehicle> vehicles = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            if (type != null && !type.isEmpty()) {
                stmt.setString(1, type);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setVehicleId(rs.getInt("vehicle_id"));
                vehicle.setVehicleNumber(rs.getString("vehicle_number"));
                vehicle.setColor(rs.getString("color"));
                vehicle.setRegisterNumber(rs.getString("register_number"));
                vehicle.setModel(rs.getString("model"));
                vehicle.setType(rs.getString("type"));
                vehicle.setSeatingCapacity(rs.getInt("seating_capacity"));
                vehicle.setStatus(rs.getString("status"));
                vehicles.add(vehicle);
            }
        }
        return vehicles;
    }

}