package com.example.khu_nghi_duong_furama.service;

public interface IUserService {
    boolean addNewUser(String username, String password, int roleId);

    boolean checkLogin(String username, String password);

    String getUserRole(String username);
}
