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
        if (!AuthUtil.isValidRole(req, resp, "Admin")) {
            return;
        }

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

    private void deleteEmployee(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        boolean success = employeeService.deleteEmployee(id);
        if (success) {
            req.getSession().setAttribute("message", "Xóa nhân viên thành công !");
            req.getSession().setAttribute("messageType", "success");
        } else {
            req.getSession().setAttribute("message", "Xóa nhân viên thất bại. Vui lòng thử lại.");
            req.getSession().setAttribute("messageType", "error");
        }
        resp.sendRedirect("/employee?action=list");
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

        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                addNewEmployee(req, resp);
                break;
            case "edit":
                updateEmployee(req, resp);
                break;
            default:
                break;
        }
    }

    private void addNewEmployee(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int roleId = Integer.parseInt(req.getParameter("roleId"));

        String name = req.getParameter("name");
        String birthday = req.getParameter("birthday");
        String idCard = req.getParameter("idCard");
        double salary = Double.parseDouble(req.getParameter("salary"));
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");

        int positionId = Integer.parseInt(req.getParameter("positionId"));
        String positionName = req.getParameter("positionName");

        int educationDegreeId = Integer.parseInt(req.getParameter("educationDegreeId"));
        String educationDegreeName = req.getParameter("educationDegreeName");

        int divisionId = Integer.parseInt(req.getParameter("divisionId"));
        String divisionName = req.getParameter("divisionName");

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Employee employee = new Employee();
        employee.setEmployeeName(name);
        employee.setEmployeeBirthday(birthday);
        employee.setEmployeeIdCard(idCard);
        employee.setEmployeeSalary(salary);
        employee.setEmployeePhone(phone);
        employee.setEmployeeEmail(email);
        employee.setEmployeeAddress(address);

        Position position = new Position(positionId, positionName);
        EducationDegree educationDegree = new EducationDegree(educationDegreeId, educationDegreeName);
        Division division = new Division(divisionId, divisionName);

        employee.setPosition(position);
        employee.setEducationDegree(educationDegree);
        employee.setDivision(division);
        employee.setUsername(username);

        boolean success = employeeService.addEmployee(employee, password, roleId);
        if (success) {
            req.getSession().setAttribute("message", "Thêm nhân viên thành công!");
            req.getSession().setAttribute("messageType", "success");
        } else {
            req.getSession().setAttribute("message", "Thêm nhân viên thất bại. Vui lòng thử lagi.");
            req.getSession().setAttribute("messageType", "error");
        }
        resp.sendRedirect("/employee?action=list");
    }

    private void updateEmployee(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int employeeId = Integer.parseInt(req.getParameter("employeeId"));

        String name = req.getParameter("name");
        String birthday = req.getParameter("birthday");
        String idCard = req.getParameter("idCard");
        double salary = Double.parseDouble(req.getParameter("salary"));
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");

        int positionId = Integer.parseInt(req.getParameter("positionId"));
        int educationDegreeId = Integer.parseInt(req.getParameter("educationDegreeId"));
        int divisionId = Integer.parseInt(req.getParameter("divisionId"));

        String username = req.getParameter("username");

        Position position = new Position();
        position.setPositionId(positionId);

        EducationDegree educationDegree = new EducationDegree();
        educationDegree.setEducationDegreeId(educationDegreeId);

        Division division = new Division();
        division.setDivisionId(divisionId);

        Employee employee = new Employee(employeeId, name, birthday, idCard, salary, phone, email, address, position, educationDegree, division, username);

        boolean success = employeeService.updateEmployee(employee);
        if (success) {
            req.getSession().setAttribute("message", "Chỉnh sửa nhân viên thành công!");
            req.getSession().setAttribute("messageType", "success");
        } else {
            req.getSession().setAttribute("message", "Chỉnh sửa nhân viên thất bại. Vui lòng thử lại.");
            req.getSession().setAttribute("messageType", "error");
        }
        resp.sendRedirect("/employee?action=list");
    }
}
