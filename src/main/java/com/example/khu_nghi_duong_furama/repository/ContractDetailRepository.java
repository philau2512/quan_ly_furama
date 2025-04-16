package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.model.AttachService;
import com.example.khu_nghi_duong_furama.model.ContractDetail;
import com.example.khu_nghi_duong_furama.util.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContractDetailRepository implements IContractDetailRepository {
    @Override
    public List<AttachService> getAllAttachService() {
        List<AttachService> attachServiceList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        String sql = "select * from attach_service";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("attach_service_id");
                String name = resultSet.getString("attach_service_name");
                double cost = resultSet.getDouble("attach_service_cost");
                int unit = resultSet.getInt("attach_service_unit");
                String status = resultSet.getString("attach_service_status");
                attachServiceList.add(new AttachService(id, name, cost, unit, status));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return attachServiceList;
    }

    @Override
    public boolean addContractDetail(ContractDetail contractDetail) {
        String sql = "INSERT INTO contract_detail (contract_id, attach_service_id, quantity) VALUES (?, ?, ?)";
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, contractDetail.getContract().getContractId());
            preparedStatement.setInt(2, contractDetail.getAttachService().getAttachServiceId());
            preparedStatement.setInt(3, contractDetail.getQuantity());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected == 1;
        } catch (SQLException e) {
            throw new RuntimeException("Loi khi add Contract Detail to DB: " + e.getMessage());
        }
    }
}
