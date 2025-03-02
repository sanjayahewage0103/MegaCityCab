package com.example.megacitycab.factory;

import com.example.megacitycab.model.Customer;

public class UserFactory {
    public static Customer createCustomer(String name, String email, String address, String contact, String nic, String password) {
        return new Customer(name, email, address, contact, nic, password);
    }
}