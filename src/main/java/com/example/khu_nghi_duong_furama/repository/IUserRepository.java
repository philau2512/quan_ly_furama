package com.example.khu_nghi_duong_furama.repository;

public interface IUserRepository {
    boolean addNewUser(String username, String password, int roleId);

    boolean checkLogin(String username, String password);

    String getUserRole(String username);
}
