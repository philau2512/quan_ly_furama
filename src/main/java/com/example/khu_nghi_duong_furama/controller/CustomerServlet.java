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
            action = "list";
        }

        switch (action) {
            case "add":
                showAddCustomerForm(req, resp);
                break;
            case "list":
                showCustomerList(req, resp);
                break;
            case "delete":
                deleteCustomer(req, resp);
                break;
            case "edit":
                showEditCustomerForm(req, resp);
                break;
            default:
                resp.sendRedirect("/home");
                break;
        }
    }

    private void showCustomerList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Customer> customerList = customerService.getAllCustomer();
        List<CustomerType> customerTypeList = customerService.getAllCustomerType();
        req.setAttribute("customerList", customerList);
        req.setAttribute("customerTypeList", customerTypeList);
        req.getRequestDispatcher("/views/customer/list.jsp").forward(req, resp);
    }

    private void deleteCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int customerId = Integer.parseInt(req.getParameter("id"));
        boolean success = customerRepository.deleteCustomer(customerId);
        if (success) {
            req.getSession().setAttribute("message", "Xóa khách hàng thành công!");
            req.getSession().setAttribute("messageType", "success");
        } else {
            req.getSession().setAttribute("message", "Xóa khách hàng thất bại. Vui lòng thử lại.");
            req.getSession().setAttribute("messageType", "error");
        }
        resp.sendRedirect("/customer?action=list");
    }

    private void showEditCustomerForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int customerId = Integer.parseInt(req.getParameter("id"));
        Customer customer = customerService.getCustomerById(customerId);
        if (customer == null) {
            req.getSession().setAttribute("message", "Không tìm thấy khách hàng.");
            req.getSession().setAttribute("messageType", "error");
            resp.sendRedirect("/customer?action=list");
            return;
        }

        req.setAttribute("customer", customer);
        req.setAttribute("customerTypeList", customerRepository.getAllCustomerType());
        req.getRequestDispatcher("/views/customer/edit.jsp").forward(req, resp);
    }

    private void showAddCustomerForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CustomerType> customerTypeList = customerService.getAllCustomerType();
        req.setAttribute("customerTypeList", customerTypeList);
        req.getRequestDispatcher("/views/customer/add.jsp").forward(req, resp);
    }


    // =================================== POST METHOD ======================================//

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
                updateCustomer(req, resp);
                break;
            case "delete":
                break;
            default:
                break;
        }
    }

    private void updateCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int customerId = Integer.parseInt(req.getParameter("customerId"));
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
        customer.setCustomerId(customerId);
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
        boolean success = customerRepository.updateCustomer(customer);
        if (success) {
            req.getSession().setAttribute("message", "Cập nhật khách hàng thành công!");
            req.getSession().setAttribute("messageType", "success");
        } else {
            req.getSession().setAttribute("message", "Cập nhật khách hàng thất bại. Vui lòng thử lagi.");
            req.getSession().setAttribute("messageType", "error");
        }
        resp.sendRedirect("/customer?action=list");
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
