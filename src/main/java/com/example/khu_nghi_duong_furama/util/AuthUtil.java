package com.example.khu_nghi_duong_furama.util;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthUtil {
    /**
     * Kiểm tra xem người dùng có vai trò hợp lệ hay không.
     * Nếu không hợp lệ, chuyển hướng đến trang lỗi access_denied.jsp.
     *
     * @param req      HttpServletRequest
     * @param resp     HttpServletResponse
     * @param roleName Vai trò cần kiểm tra (ví dụ: "Admin", "Employee")
     * @return true nếu người dùng có vai trò hợp lệ, false nếu không
     * @throws ServletException nếu có lỗi khi forward
     * @throws IOException      nếu có lỗi khi redirect
     */
    public static boolean isValidRole(HttpServletRequest req, HttpServletResponse resp, String roleName)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !roleName.equals(session.getAttribute("role"))) {
            req.getRequestDispatcher("/views/error/access_denied.jsp").forward(req, resp);
            return false;
        }
        return true;
    }

    // Dùng multiple role
    public static boolean isValidRole(HttpServletRequest req, HttpServletResponse resp, String... allowedRoles)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            req.getRequestDispatcher("/views/error/access_denied.jsp").forward(req, resp);
            return false;
        }

        String userRole = (String) session.getAttribute("role");
        for (String role : allowedRoles) {
            if (role.equals(userRole)) {
                return true;
            }
        }

        req.getRequestDispatcher("/views/error/access_denied.jsp").forward(req, resp);
        return false;
    }

//    if (!AuthUtil.isValidRole(req, resp, "Admin", "Employee")) {
//        return;
//    }
}