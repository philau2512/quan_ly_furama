package com.example.khu_nghi_duong_furama.controller;

import com.example.khu_nghi_duong_furama.model.Division;
import com.example.khu_nghi_duong_furama.model.EducationDegree;
import com.example.khu_nghi_duong_furama.model.Employee;
import com.example.khu_nghi_duong_furama.model.Position;
import com.example.khu_nghi_duong_furama.service.EmployeeService;
import com.example.khu_nghi_duong_furama.service.IEmployeeService;
import com.example.khu_nghi_duong_furama.util.AuthUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "EmployeeServlet", urlPatterns = "/employee")
public class EmployeeServlet extends HttpServlet {
    private IEmployeeService employeeService = new EmployeeService();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra phân quyền
//        if (!AuthUtil.isValidRole(req, resp, "Admin")) {
//            return;
//        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                showAddEmployeeForm(req, resp);
                break;
            case "list":
                showEmployeeList(req, resp);
                break;
            case "delete":
                deleteEmployee(req, resp);
                break;
            case "edit":
                showEditEmployeeForm(req, resp);
                break;
            default:
                resp.sendRedirect("/home");
                break;
        }

    }

    private void showEditEmployeeForm(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void deleteEmployee(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void showEmployeeList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Employee> employeeList = employeeService.getAllEmployee();
        if (employeeList == null || employeeList.isEmpty()) {
            // Log để debug
            System.out.println("Danh sách nhân viên rỗng hoặc null");
            // Đặt thông báo để hiển thị trên JSP
            req.setAttribute("message", "Không có nhân viên nào để hiển thị.");
            req.setAttribute("messageType", "warning");
        } else {
            System.out.println("Số lượng nhân viên: " + employeeList.size());
        }
        req.setAttribute("employeeList", employeeList);
        // Đảm bảo các danh sách dropdown được truyền vào
        req.setAttribute("positionList", employeeService.getAllPosition());
        req.setAttribute("educationDegreeList", employeeService.getAllEducationDegree());
        req.setAttribute("divisionList", employeeService.getAllDivision());
        req.getRequestDispatcher("/views/employee/list.jsp").forward(req, resp);
    }

    private void showAddEmployeeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Position> positionList = employeeService.getAllPosition();
        List<Division> divisionList = employeeService.getAllDivision();
        List<EducationDegree> educationDegreeList = employeeService.getAllEducationDegree();

        req.setAttribute("positionList", positionList);
        req.setAttribute("divisionList", divisionList);
        req.setAttribute("educationDegreeList", educationDegreeList);

        req.getRequestDispatcher("/views/employee/add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra phân quyền
        if (!AuthUtil.isValidRole(req, resp, "Admin")) {
            return;
        }
    }
}
