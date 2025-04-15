package com.example.khu_nghi_duong_furama.dto;

import com.example.khu_nghi_duong_furama.model.AttachService;
import com.example.khu_nghi_duong_furama.model.Contract;
import com.example.khu_nghi_duong_furama.model.Customer;
import com.example.khu_nghi_duong_furama.model.Service;

import java.util.List;

public class CustomerUsingServiceDTO {
    private Customer customer;
    private Contract contract;
    private Service service;
    private List<AttachService> attachServices;

    public CustomerUsingServiceDTO() {
    }

    public CustomerUsingServiceDTO(Customer customer, Contract contract, Service service, List<AttachService> attachServices) {
        this.customer = customer;
        this.contract = contract;
        this.service = service;
        this.attachServices = attachServices;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Contract getContract() {
        return contract;
    }

    public void setContract(Contract contract) {
        this.contract = contract;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public List<AttachService> getAttachServices() {
        return attachServices;
    }

    public void setAttachServices(List<AttachService> attachServices) {
        this.attachServices = attachServices;
    }
}
