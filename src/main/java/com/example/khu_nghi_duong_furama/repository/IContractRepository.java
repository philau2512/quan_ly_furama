package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.model.Contract;

import java.util.List;

public interface IContractRepository {
    boolean addContract(Contract contract);
    List<Contract> getAllContract();
}
