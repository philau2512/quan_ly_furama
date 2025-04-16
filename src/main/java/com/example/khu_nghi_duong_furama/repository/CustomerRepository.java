package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.model.Customer;
import com.example.khu_nghi_duong_furama.model.CustomerType;
import com.example.khu_nghi_duong_furama.util.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerRepository implements ICustomerRepository {
    @Override
    public List<Customer> getAllCustomer() {
        List<Customer> customerList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        String sql = "select * from customer c join customer_type ct on c.customer_type_id = ct.customer_type_id order by c.customer_id";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("customer_id");
                String name = resultSet.getString("customer_name");
                String birthday = resultSet.getString("customer_birthday");
                boolean gender = resultSet.getBoolean("customer_gender");
                String idCard = resultSet.getString("customer_id_card");
                String phone = resultSet.getString("customer_phone");
                String email = resultSet.getString("customer_email");
                String address = resultSet.getString("customer_address");
                int customerTypeId = resultSet.getInt("customer_type_id");
                String customerTypeName = resultSet.getString("customer_type_name");
                CustomerType customerType = new CustomerType(customerTypeId, customerTypeName);
                Customer customer = new Customer(id, customerType, name, birthday, gender, idCard, phone, email, address);
                customerList.add(customer);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return customerList;
    }

    @Override
    public List<CustomerType> getAllCustomerType() {
        List<CustomerType> customerTypeList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        String sql = "select * from customer_type";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("customer_type_id");
                String name = resultSet.getString("customer_type_name");
                customerTypeList.add(new CustomerType(id, name));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return customerTypeList;
    }

    @Override
    public boolean addNewCustomer(Customer customer) {
        Connection connection = BaseRepository.getConnectDB();
        String sql = "INSERT INTO customer (customer_type_id, customer_name, customer_birthday, customer_gender, customer_id_card, customer_phone, customer_email, customer_address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, customer.getCustomerType().getId());
            preparedStatement.setString(2, customer.getCustomerName());
            preparedStatement.setString(3, customer.getCustomerBirthday());
            preparedStatement.setBoolean(4, customer.isCustomerGender());
            preparedStatement.setString(5, customer.getCustomerIdCard());
            preparedStatement.setString(6, customer.getCustomerPhone());
            preparedStatement.setString(7, customer.getCustomerEmail());
            preparedStatement.setString(8, customer.getCustomerAddress());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteCustomer(int customerId) {
        String sql = "delete from customer where customer_id = ?";
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, customerId);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE customer SET customer_type_id = ?, customer_name = ?, customer_birthday = ?, customer_gender = ?, customer_id_card = ?, customer_phone = ?, customer_email = ?, customer_address = ? WHERE customer_id = ?";
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, customer.getCustomerType().getId());
            preparedStatement.setString(2, customer.getCustomerName());
            preparedStatement.setString(3, customer.getCustomerBirthday());
            preparedStatement.setBoolean(4, customer.isCustomerGender());
            preparedStatement.setString(5, customer.getCustomerIdCard());
            preparedStatement.setString(6, customer.getCustomerPhone());
            preparedStatement.setString(7, customer.getCustomerEmail());
            preparedStatement.setString(8, customer.getCustomerAddress());
            preparedStatement.setInt(9, customer.getCustomerId());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Customer getCustomerById(int customerId) {
        String sql = "SELECT c.*, ct.customer_type_name " +
                "FROM customer c " +
                "JOIN customer_type ct ON c.customer_type_id = ct.customer_type_id " +
                "WHERE c.customer_id = ?";
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, customerId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(resultSet.getInt("customer_id"));
                customer.setCustomerName(resultSet.getString("customer_name"));
                customer.setCustomerBirthday(resultSet.getString("customer_birthday"));
                customer.setCustomerGender(resultSet.getBoolean("customer_gender"));
                customer.setCustomerIdCard(resultSet.getString("customer_id_card"));
                customer.setCustomerPhone(resultSet.getString("customer_phone"));
                customer.setCustomerEmail(resultSet.getString("customer_email"));
                customer.setCustomerAddress(resultSet.getString("customer_address"));

                CustomerType customerType = new CustomerType();
                customerType.setId(resultSet.getInt("customer_type_id"));
                customerType.setName(resultSet.getString("customer_type_name"));
                customer.setCustomerType(customerType);

                return customer;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
