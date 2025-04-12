package com.example.khu_nghi_duong_furama.service;

import com.example.khu_nghi_duong_furama.model.Customer;
import com.example.khu_nghi_duong_furama.model.CustomerType;
import com.example.khu_nghi_duong_furama.repository.CustomerRepository;
import com.example.khu_nghi_duong_furama.repository.ICustomerRepository;

import java.util.List;

public class CustomerService implements ICustomerService {
    private ICustomerRepository customerRepository = new CustomerRepository();

    @Override
    public List<Customer> getAllCustomer() {
        return customerRepository.getAllCustomer();
    }

    @Override
    public List<CustomerType> getAllCustomerType() {
        return customerRepository.getAllCustomerType();
    }

    @Override
    public boolean addNewCustomer(Customer customer) {
        return customerRepository.addNewCustomer(customer);
    }

    @Override
    public boolean deleteCustomer(int customerId) {
        return customerRepository.deleteCustomer(customerId);
    }

    @Override
    public boolean updateCustomer(Customer customer) {
        return customerRepository.updateCustomer(customer);
    }

    @Override
    public Customer getCustomerById(int customerId) {
        return customerRepository.getCustomerById(customerId);
    }
}
