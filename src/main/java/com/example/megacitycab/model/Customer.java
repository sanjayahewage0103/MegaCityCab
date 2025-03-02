package com.example.megacitycab.model;

public class Customer {
    private int id;
    private String name;
    private String email;
    private String address;
    private String contact;
    private String nic;
    private String password;

    // Constructors
    public Customer() {}

    public Customer(String name, String email, String address, String contact, String nic, String password) {
        this.name = name;
        this.email = email;
        this.address = address;
        this.contact = contact;
        this.nic = nic;
        this.password = password;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}