package com.example.khu_nghi_duong_furama.service;

import com.example.khu_nghi_duong_furama.model.Contract;

import java.util.List;

public interface IContractService {
    boolean addContract(Contract contract);
    List<Contract> getAllContract();
}
