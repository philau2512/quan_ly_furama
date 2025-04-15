package com.example.khu_nghi_duong_furama.controller;

import com.example.khu_nghi_duong_furama.model.Contract;
import com.example.khu_nghi_duong_furama.model.Customer;
import com.example.khu_nghi_duong_furama.model.Employee;
import com.example.khu_nghi_duong_furama.model.Service;
import com.example.khu_nghi_duong_furama.service.*;
import com.example.khu_nghi_duong_furama.util.AuthUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "ContractServlet", urlPatterns = "/contract")
public class ContractServlet extends HttpServlet {
    private ICustomerService customerService = new CustomerService();
    private IEmployeeService employeeService = new EmployeeService();
    private IServiceService serviceService = new ServiceService();
    private IContractService contractService = new ContractService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra phân quyền
//        if (!AuthUtil.isValidRole(req, resp, "Admin")) {
//            return;
//        }
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                showAddContractForm(req, resp);
                break;
            case "list":
                showAllContract(req, resp);
                break;
            default:
                break;
        }
    }

    private void showAllContract(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Contract> contractList = contractService.getAllContract();
        req.setAttribute("contractList", contractList);
        req.getRequestDispatcher("/views/contract/list.jsp").forward(req, resp);
    }

    private void showAddContractForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Customer> customerList = customerService.getAllCustomer();
        List<Employee> employeeList = employeeService.getAllEmployee();
        List<Service> serviceList = serviceService.getAllService();
        req.setAttribute("customerList", customerList);
        req.setAttribute("employeeList", employeeList);
        req.setAttribute("serviceList", serviceList);
        req.getRequestDispatcher("/views/contract/add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra phân quyền
//        if (!AuthUtil.isValidRole(req, resp, "Admin")) {
//            return;
//        }
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                addNewContract(req, resp);
                break;
            default:
                break;
        }
    }

    private void addNewContract(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            LocalDateTime startDate = LocalDateTime.parse(req.getParameter("startDate"));
            LocalDateTime endDate = LocalDateTime.parse(req.getParameter("endDate"));
            double deposit = Double.parseDouble(req.getParameter("deposit"));
            double totalMoney = Double.parseDouble(req.getParameter("totalMoney"));
            int employeeId = Integer.parseInt(req.getParameter("employeeId"));
            int customerId = Integer.parseInt(req.getParameter("customerId"));
            int serviceId = Integer.parseInt(req.getParameter("serviceId"));

            // Validation
            if (deposit < 0 || totalMoney < 0) {
                throw new IllegalArgumentException("Tiền cọc và tổng tiền phải là số không âm!");
            }
            if (startDate.isAfter(endDate)) {
                throw new IllegalArgumentException("Ngày bắt đầu phải trước ngày kết thúc!");
            }

            Contract contract = new Contract();
            contract.setContractStartDate(startDate);
            contract.setContractEndDate(endDate);
            contract.setContractDeposit(deposit);
            contract.setContractTotalMoney(totalMoney);

            Employee employee = new Employee();
            employee.setEmployeeId(employeeId);
            contract.setEmployee(employee);

            Customer customer = new Customer();
            customer.setCustomerId(customerId);
            contract.setCustomer(customer);

            Service service = new Service();
            service.setServiceId(serviceId);
            contract.setService(service);

            boolean success = contractService.addContract(contract);
            if (success) {
                req.getSession().setAttribute("message", "Thêm hợp đồng thành công!");
                req.getSession().setAttribute("messageType", "success");
                resp.sendRedirect("/home");
            } else {
                req.getSession().setAttribute("message", "Them hop dong that bai. Vui long thu lai.");
                req.getSession().setAttribute("messageType", "error");
                resp.sendRedirect("/home");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("message", "Lỗi khi thêm hợp đồng: " + e.getMessage());
            req.getSession().setAttribute("messageType", "error");
            resp.sendRedirect("/home");
        }
    }
}
