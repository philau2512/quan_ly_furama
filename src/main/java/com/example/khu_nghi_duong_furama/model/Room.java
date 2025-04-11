package com.example.khu_nghi_duong_furama.model;

public class Room extends Service {
    private String freeServiceIncluded;

    public Room() {
    }

    public Room(int serviceId, String serviceName, double serviceArea, double serviceCost, int serviceMaxPeople, RentType serviceRentType, ServiceType serviceType, String freeServiceIncluded) {
        super(serviceId, serviceName, serviceArea, serviceCost, serviceMaxPeople, serviceRentType, serviceType);
        this.freeServiceIncluded = freeServiceIncluded;
    }

    public String getFreeServiceIncluded() {
        return freeServiceIncluded;
    }

    public void setFreeServiceIncluded(String freeServiceIncluded) {
        this.freeServiceIncluded = freeServiceIncluded;
    }
}
