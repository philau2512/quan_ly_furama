package com.example.khu_nghi_duong_furama.service;

import com.example.khu_nghi_duong_furama.dto.CustomerUsingServiceDTO;
import com.example.khu_nghi_duong_furama.model.AttachService;
import com.example.khu_nghi_duong_furama.model.Contract;
import com.example.khu_nghi_duong_furama.repository.ContractRepository;
import com.example.khu_nghi_duong_furama.repository.IContractRepository;

import java.util.List;

public class ContractService implements IContractService {
    private IContractRepository contractRepository = new ContractRepository();

    @Override
    public boolean addContract(Contract contract) {
        return contractRepository.addContract(contract);
    }

    @Override
    public List<Contract> getAllContract() {
        return contractRepository.getAllContract();
    }

    @Override
    public List<CustomerUsingServiceDTO> getCustomerUsingService() {
        return contractRepository.getCustomerUsingService();
    }

    @Override
    public List<AttachService> getAttachServicesByContractId(int contractId) {
        return contractRepository.getAttachServicesByContractId(contractId);
    }
}
