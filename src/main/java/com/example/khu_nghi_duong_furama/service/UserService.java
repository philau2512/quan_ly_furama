package com.example.khu_nghi_duong_furama.service;

import com.example.khu_nghi_duong_furama.repository.IUserRepository;
import com.example.khu_nghi_duong_furama.repository.UserRepository;

public class UserService implements IUserService {
    private IUserRepository userRepository = new UserRepository();

    @Override
    public boolean addNewUser(String username, String password, int roleId) {
        return userRepository.addNewUser(username, password, roleId);
    }
}
