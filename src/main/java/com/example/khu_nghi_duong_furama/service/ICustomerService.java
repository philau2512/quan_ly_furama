package com.example.khu_nghi_duong_furama.service;

import com.example.khu_nghi_duong_furama.model.Customer;
import com.example.khu_nghi_duong_furama.model.CustomerType;

import java.util.List;

public interface ICustomerService {
    List<Customer> getAllCustomer();

    List<CustomerType> getAllCustomerType();

    boolean addNewCustomer(Customer customer);

    boolean deleteCustomer(int customerId);

    boolean updateCustomer(Customer customer);

    Customer getCustomerById(int customerId);
}
