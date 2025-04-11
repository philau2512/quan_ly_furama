package com.example.khu_nghi_duong_furama.repository;

import com.example.khu_nghi_duong_furama.util.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRepository implements IUserRepository {
    @Override
    public boolean addNewUser(String username, String password, int roleId) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            connection.setAutoCommit(false);

            String checkSql = "SELECT * FROM user WHERE username = ?";
            PreparedStatement checkStmt = connection.prepareStatement(checkSql);
            checkStmt.setString(1, username);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                return false; // Username đã tồn tại
            }

            // Thêm người dùng mới vào bảng user
            String insertSql = "INSERT INTO user (username, password) VALUES (?, ?)";
            PreparedStatement insertStmt = connection.prepareStatement(insertSql);
            insertStmt.setString(1, username);
            insertStmt.setString(2, password);
            int rowsAffected = insertStmt.executeUpdate();

            // Thêm vai trò mặc định (Customer) cho người dùng mới
            String roleSql = "INSERT INTO user_role (role_id, username) VALUES (?, ?)";
            PreparedStatement roleStmt = connection.prepareStatement(roleSql);
            roleStmt.setInt(1, roleId);
            roleStmt.setString(2, username);
            rowsAffected = roleStmt.executeUpdate();

            if (rowsAffected > 0) {
                connection.commit();
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean checkLogin(String username, String password) {
        Connection connection = BaseRepository.getConnectDB();
        String sql = "select * from user where username = ? and password = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public String getUserRole(String username) {
        Connection connection = BaseRepository.getConnectDB();
        String sql = "SELECT r.role_name FROM user_role ur JOIN role r ON ur.role_id = r.role_id WHERE ur.username = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("role_name");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return "";
    }
}
