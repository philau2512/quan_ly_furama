package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.model.RentType;
import com.example.khu_nghi_duong_furama.model.Service;
import com.example.khu_nghi_duong_furama.model.ServiceType;

import java.util.List;

public interface IServiceRepository {
    List<ServiceType> getAllServiceType();

    List<RentType> getAllRentType();

    List<Service> getAllService();

    boolean addService(Service service);
}
