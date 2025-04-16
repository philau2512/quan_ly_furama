package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.model.AttachService;
import com.example.khu_nghi_duong_furama.model.ContractDetail;

import java.util.List;

public interface IContractDetailRepository {
    List<AttachService> getAllAttachService();

    boolean addContractDetail(ContractDetail contractDetail);
}
