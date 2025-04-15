package com.example.khu_nghi_duong_furama.service;

import com.example.khu_nghi_duong_furama.model.*;

import java.util.List;

public interface IServiceService {
    List<ServiceType> getAllServiceType();

    List<RentType> getAllRentType();

    List<Service> getAllService();

    boolean addService(Service service);
}
