package com.example.khu_nghi_duong_furama.controller;

import com.example.khu_nghi_duong_furama.repository.IUserRepository;
import com.example.khu_nghi_duong_furama.repository.UserRepository;
import com.example.khu_nghi_duong_furama.service.IUserService;
import com.example.khu_nghi_duong_furama.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    private IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        String username = "";
        String password = "";
        boolean remember = false;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    username = cookie.getValue();
                } else if ("password".equals(cookie.getName())) {
                    password = cookie.getValue();
                    remember = true;
                }
            }
        }

        req.setAttribute("username", username);
        req.setAttribute("password", password);
        req.setAttribute("remember", remember);
        req.getRequestDispatcher("/views/user/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String rememberMe = req.getParameter("remember");

        boolean isValid = userService.checkLogin(username, password);

        if (isValid) {
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", userService.getUserRole(username));

            if ("on".equals(rememberMe)) {
                Cookie usernameCookie = new Cookie("username", username);
                Cookie passwordCookie = new Cookie("password", password);
                usernameCookie.setMaxAge(30 * 24 * 60 * 60); // 30 ngày
                passwordCookie.setMaxAge(30 * 24 * 60 * 60);
                usernameCookie.setHttpOnly(true);
                passwordCookie.setHttpOnly(true);
                resp.addCookie(usernameCookie);
                resp.addCookie(passwordCookie);
            } else {
                Cookie usernameCookie = new Cookie("username", "");
                Cookie passwordCookie = new Cookie("password", "");
                usernameCookie.setMaxAge(0);
                passwordCookie.setMaxAge(0);
                resp.addCookie(usernameCookie);
                resp.addCookie(passwordCookie);
            }
            // Thêm thông báo thành công
            session.setAttribute("message", "Đăng nhập thành công!");
            session.setAttribute("messageType", "success");
            resp.sendRedirect("/home");
        } else {
            // Thêm thông báo lỗi
            req.setAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng.");
            req.setAttribute("messageType", "error");
            req.setAttribute("username", username);
            req.setAttribute("password", password);
            req.setAttribute("remember", "on".equals(rememberMe));
            req.getRequestDispatcher("/views/user/login.jsp").forward(req, resp);
        }
    }
}