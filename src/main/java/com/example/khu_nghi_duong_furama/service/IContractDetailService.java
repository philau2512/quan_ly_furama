package com.example.khu_nghi_duong_furama.service;

import com.example.khu_nghi_duong_furama.model.AttachService;
import com.example.khu_nghi_duong_furama.model.ContractDetail;

import java.util.List;

public interface IContractDetailService {
    List<AttachService> getAllAttachService();

    boolean addContractDetail(ContractDetail contractDetail);
}
