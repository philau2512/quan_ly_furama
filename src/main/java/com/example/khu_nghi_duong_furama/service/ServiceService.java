package com.example.khu_nghi_duong_furama.service;

import com.example.khu_nghi_duong_furama.model.*;
import com.example.khu_nghi_duong_furama.repository.IServiceRepository;
import com.example.khu_nghi_duong_furama.repository.ServiceRepository;

import java.util.List;

public class ServiceService implements IServiceService {
    private IServiceRepository serviceRepository = new ServiceRepository();

    @Override
    public List<ServiceType> getAllServiceType() {
        return serviceRepository.getAllServiceType();
    }

    @Override
    public List<RentType> getAllRentType() {
        return serviceRepository.getAllRentType();
    }

    @Override
    public List<Service> getAllService() {
        return serviceRepository.getAllService();
    }

    @Override
    public boolean addService(Service service) {
        return serviceRepository.addService(service);
    }

    @Override
    public boolean updateService(Service service) {
        return serviceRepository.updateService(service);
    }

    @Override
    public boolean deleteService(int id) {
        return serviceRepository.deleteService(id);
    }

    @Override
    public Service getServiceById(int id) {
        return serviceRepository.getServiceById(id);
    }
}
