package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.model.*;
import com.example.khu_nghi_duong_furama.util.BaseRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContractRepository implements IContractRepository {
    @Override
    public boolean addContract(Contract contract) {
        Connection connection = BaseRepository.getConnectDB();
        String sql = "INSERT INTO contract (contract_start_date, contract_end_date, contract_deposit, contract_total_money, employee_id, customer_id, service_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setTimestamp(1, Timestamp.valueOf(contract.getContractStartDate()));
            stmt.setTimestamp(2, Timestamp.valueOf(contract.getContractEndDate()));
            stmt.setDouble(3, contract.getContractDeposit());
            stmt.setDouble(4, contract.getContractTotalMoney());
            stmt.setInt(5, contract.getEmployee().getEmployeeId());
            stmt.setInt(6, contract.getCustomer().getCustomerId());
            stmt.setInt(7, contract.getService().getServiceId());
            int effectedRows = stmt.executeUpdate();
            return effectedRows == 1;
        } catch (SQLException e) {
            System.out.println("Lỗi khi thêm hợp đồng vào DB : " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Contract> getAllContract() {
        List<Contract> contractList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        String sql = "SELECT c.*, e.employee_id, e.employee_name, cu.customer_id, cu.customer_name, s.service_name, st.* " +
                "FROM contract c " +
                "JOIN employee e ON c.employee_id = e.employee_id " +
                "JOIN customer cu ON c.customer_id = cu.customer_id " +
                "JOIN service s ON c.service_id = s.service_id " +
                "JOIN service_type st ON s.service_type_id = st.service_type_id";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Contract contract = new Contract();
                contract.setContractId(rs.getInt("contract_id"));
                contract.setContractStartDate(rs.getTimestamp("contract_start_date").toLocalDateTime());
                contract.setContractEndDate(rs.getTimestamp("contract_end_date").toLocalDateTime());
                contract.setContractDeposit(rs.getDouble("contract_deposit"));
                contract.setContractTotalMoney(rs.getDouble("contract_total_money"));

                Employee employee = new Employee();
                employee.setEmployeeId(rs.getInt("employee_id"));
                employee.setEmployeeName(rs.getString("employee_name"));
                contract.setEmployee(employee);

                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setCustomerName(rs.getString("customer_name"));
                contract.setCustomer(customer);

                Service service = new Service();
                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));

                ServiceType serviceType = new ServiceType();
                serviceType.setServiceTypeId(rs.getInt("service_type_id"));
                serviceType.setServiceTypeName(rs.getString("service_type_name"));
                service.setServiceType(serviceType);
                contract.setService(service);

                contractList.add(contract);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return contractList;
    }
}
