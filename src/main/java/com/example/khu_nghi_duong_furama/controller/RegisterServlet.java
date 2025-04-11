package com.example.khu_nghi_duong_furama.controller;

import com.example.khu_nghi_duong_furama.repository.IUserRepository;
import com.example.khu_nghi_duong_furama.repository.UserRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    private IUserRepository userRepository = new UserRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/user/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        int roleId = Integer.parseInt(req.getParameter("roleId"));

        // Validate dữ liệu (cơ bản)
        if (username == null || username.trim().isEmpty() || username.length() < 3) {
            req.setAttribute("error", "Username must be at least 3 characters long.");
            req.getRequestDispatcher("/views/user/register.jsp").forward(req, resp);
            return;
        }
        if (password == null || password.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters long.");
            req.getRequestDispatcher("/views/user/register.jsp").forward(req, resp);
            return;
        }
        if (roleId != 2 && roleId != 3) {
            req.setAttribute("error", "Invalid role selected.");
            req.getRequestDispatcher("/views/user/register.jsp").forward(req, resp);
            return;
        }

        // Thêm người dùng mới
        boolean success = userRepository.addNewUser(username, password, roleId);
        if (success) {
            // Đăng ký thành công, chuyển hướng đến trang đăng nhập
            resp.sendRedirect("login");
        } else {
            // Đăng ký thất bại (username đã tồn tại), hiển thị thông báo lỗi
            req.setAttribute("error", "Username already exists. Please choose another one.");
            req.setAttribute("username", username);
            req.setAttribute("roleId", roleId);
            req.getRequestDispatcher("/views/user/register.jsp").forward(req, resp);
        }
    }
}