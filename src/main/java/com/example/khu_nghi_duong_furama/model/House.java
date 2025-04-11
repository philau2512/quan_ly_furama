package com.example.khu_nghi_duong_furama.model;

public class House extends Service {
    private String standardRoom;
    private String descriptionOtherConvenience;
    private int numberOfFloors;

    public House() {
    }

    public House(int serviceId, String serviceName, double serviceArea, double serviceCost, int serviceMaxPeople, RentType serviceRentType, ServiceType serviceType, String standardRoom, String descriptionOtherConvenience, int numberOfFloors) {
        super(serviceId, serviceName, serviceArea, serviceCost, serviceMaxPeople, serviceRentType, serviceType);
        this.standardRoom = standardRoom;
        this.descriptionOtherConvenience = descriptionOtherConvenience;
        this.numberOfFloors = numberOfFloors;
    }

    public String getStandardRoom() {
        return standardRoom;
    }

    public void setStandardRoom(String standardRoom) {
        this.standardRoom = standardRoom;
    }

    public String getDescriptionOtherConvenience() {
        return descriptionOtherConvenience;
    }

    public void setDescriptionOtherConvenience(String descriptionOtherConvenience) {
        this.descriptionOtherConvenience = descriptionOtherConvenience;
    }

    public int getNumberOfFloors() {
        return numberOfFloors;
    }

    public void setNumberOfFloors(int numberOfFloors) {
        this.numberOfFloors = numberOfFloors;
    }
}
