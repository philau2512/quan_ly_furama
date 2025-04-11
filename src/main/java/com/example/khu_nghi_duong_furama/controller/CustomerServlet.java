package com.example.khu_nghi_duong_furama.controller;

import com.example.khu_nghi_duong_furama.model.Customer;
import com.example.khu_nghi_duong_furama.model.CustomerType;
import com.example.khu_nghi_duong_furama.repository.CustomerRepository;
import com.example.khu_nghi_duong_furama.repository.ICustomerRepository;
import com.example.khu_nghi_duong_furama.service.CustomerService;
import com.example.khu_nghi_duong_furama.service.ICustomerService;
import com.example.khu_nghi_duong_furama.util.AuthUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerServlet", urlPatterns = "/customer")
public class CustomerServlet extends HttpServlet {
    private ICustomerService customerService = new CustomerService();
    private ICustomerRepository customerRepository = new CustomerRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
                showAddCustomerForm(req, resp);
                break;
            case "edit":
                break;
            case "delete":
                break;
            default:
                break;
        }
    }

    private void showAddCustomerForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CustomerType> customerTypeList = customerService.getAllCustomerType();
        req.setAttribute("customerTypeList", customerTypeList);
        req.getRequestDispatcher("/views/customer/add.jsp").forward(req, resp);
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
                addNewCustomer(req, resp);
                break;
            case "edit":
                break;
            case "delete":
                break;
            default:
                break;
        }
    }

    private void addNewCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String name = req.getParameter("name");
        String birthday = req.getParameter("birthday");
        String gender = req.getParameter("gender");
        String idCard = req.getParameter("idCard");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        int typeId = Integer.parseInt(req.getParameter("typeId"));

        // Tạo đối tượng Customer
        Customer customer = new Customer();
        customer.setCustomerName(name);
        customer.setCustomerBirthday(birthday);
        customer.setCustomerGender("Nam".equals(gender));
        customer.setCustomerIdCard(idCard);
        customer.setCustomerPhone(phone);
        customer.setCustomerEmail(email);
        customer.setCustomerAddress(address);

        // Tạo đối tượng CustomerType và gán vào Customer
        CustomerType customerType = new CustomerType();
        customerType.setId(typeId);
        customer.setCustomerType(customerType);

        // Thêm khách hàng vào cơ sở dữ liệu
        boolean success = customerRepository.addNewCustomer(customer);
        if (success) {
            req.getSession().setAttribute("message", "Thêm khách hàng thành công!");
            req.getSession().setAttribute("messageType", "success");
            resp.sendRedirect("/customer?action=list"); // Chuyển hướng đến danh sách khách hàng
        } else {
            req.setAttribute("message", "Thêm khách hàng thất bại. Vui lòng thử lại.");
            req.setAttribute("messageType", "error");
            req.setAttribute("customerTypeList", customerRepository.getAllCustomerType());
            req.getRequestDispatcher("/views/customer/add.jsp").forward(req, resp);
        }
    }
}
