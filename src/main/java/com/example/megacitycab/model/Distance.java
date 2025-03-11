package com.example.megacitycab.model;

public class Distance {
    private int id;
    private String locationFrom;
    private String locationTo;
    private double distanceKm;

    // Constructors
    public Distance() {}

    public Distance(String locationFrom, String locationTo, double distanceKm) {
        this.locationFrom = locationFrom;
        this.locationTo = locationTo;
        this.distanceKm = distanceKm;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLocationFrom() {
        return locationFrom;
    }

    public void setLocationFrom(String locationFrom) {
        this.locationFrom = locationFrom;
    }

    public String getLocationTo() {
        return locationTo;
    }

    public void setLocationTo(String locationTo) {
        this.locationTo = locationTo;
    }

    public double getDistanceKm() {
        return distanceKm;
    }

    public void setDistanceKm(double distanceKm) {
        this.distanceKm = distanceKm;
    }

    @Override
    public String toString() {
        return "Distance{" +
                "id=" + id +
                ", locationFrom='" + locationFrom + '\'' +
                ", locationTo='" + locationTo + '\'' +
                ", distanceKm=" + distanceKm +
                '}';
    }
}