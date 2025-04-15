package com.example.khu_nghi_duong_furama.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Contract {
    private int contractId;
    private LocalDateTime contractStartDate;
    private LocalDateTime contractEndDate;
    private double contractDeposit;
    private double contractTotalMoney;
    private Employee employee;
    private Customer customer;
    private Service service;

    public Contract() {
    }

    public Contract(int contractId, LocalDateTime contractStartDate, LocalDateTime contractEndDate, double contractDeposit, double contractTotalMoney, Employee employee, Customer customer, Service service) {
        this.contractId = contractId;
        this.contractStartDate = contractStartDate;
        this.contractEndDate = contractEndDate;
        this.contractDeposit = contractDeposit;
        this.contractTotalMoney = contractTotalMoney;
        this.employee = employee;
        this.customer = customer;
        this.service = service;
    }

    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
    }

    public LocalDateTime getContractStartDate() {
        return contractStartDate;
    }

    public void setContractStartDate(LocalDateTime contractStartDate) {
        this.contractStartDate = contractStartDate;
    }

    public LocalDateTime getContractEndDate() {
        return contractEndDate;
    }

    public void setContractEndDate(LocalDateTime contractEndDate) {
        this.contractEndDate = contractEndDate;
    }

    public double getContractDeposit() {
        return contractDeposit;
    }

    public void setContractDeposit(double contractDeposit) {
        this.contractDeposit = contractDeposit;
    }

    public double getContractTotalMoney() {
        return contractTotalMoney;
    }

    public void setContractTotalMoney(double contractTotalMoney) {
        this.contractTotalMoney = contractTotalMoney;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    // Thêm phương thức định dạng ngày giờ
    public String getFormattedStartDate() {
        return contractStartDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }

    public String getFormattedEndDate() {
        return contractEndDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }
}
