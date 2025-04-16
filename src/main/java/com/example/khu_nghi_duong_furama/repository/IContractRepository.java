package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.dto.CustomerUsingServiceDTO;
import com.example.khu_nghi_duong_furama.model.AttachService;
import com.example.khu_nghi_duong_furama.model.Contract;

import java.util.List;

public interface IContractRepository {
    boolean addContract(Contract contract);

    List<Contract> getAllContract();

    List<CustomerUsingServiceDTO> getCustomerUsingService();

    List<AttachService> getAttachServicesByContractId(int contractId);
}
