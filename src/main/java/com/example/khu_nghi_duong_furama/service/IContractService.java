package com.example.khu_nghi_duong_furama.service;

import com.example.khu_nghi_duong_furama.dto.CustomerUsingServiceDTO;
import com.example.khu_nghi_duong_furama.model.AttachService;
import com.example.khu_nghi_duong_furama.model.Contract;

import java.util.List;

public interface IContractService {
    boolean addContract(Contract contract);

    List<Contract> getAllContract();

    List<CustomerUsingServiceDTO> getCustomerUsingService();

    List<AttachService> getAttachServicesByContractId(int contractId);
}
