package com.example.khu_nghi_duong_furama.service;

import com.example.khu_nghi_duong_furama.model.AttachService;
import com.example.khu_nghi_duong_furama.model.ContractDetail;
import com.example.khu_nghi_duong_furama.repository.ContractDetailRepository;
import com.example.khu_nghi_duong_furama.repository.IContractDetailRepository;

import java.util.List;

public class ContractDetailService implements IContractDetailService{
    private IContractDetailRepository contractDetailRepository = new ContractDetailRepository();

    @Override
    public List<AttachService> getAllAttachService() {
        return contractDetailRepository.getAllAttachService();
    }

    @Override
    public boolean addContractDetail(ContractDetail contractDetail) {
        return contractDetailRepository.addContractDetail(contractDetail);
    }
}
