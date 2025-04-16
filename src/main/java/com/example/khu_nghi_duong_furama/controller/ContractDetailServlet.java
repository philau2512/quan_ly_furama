package com.example.khu_nghi_duong_furama.controller;

import com.example.khu_nghi_duong_furama.model.AttachService;
import com.example.khu_nghi_duong_furama.model.Contract;
import com.example.khu_nghi_duong_furama.model.ContractDetail;
import com.example.khu_nghi_duong_furama.repository.IContractDetailRepository;
import com.example.khu_nghi_duong_furama.service.ContractDetailService;
import com.example.khu_nghi_duong_furama.service.ContractService;
import com.example.khu_nghi_duong_furama.service.IContractDetailService;
import com.example.khu_nghi_duong_furama.service.IContractService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ContractDetailServlet", urlPatterns = "/contract-detail")
public class ContractDetailServlet extends HttpServlet {
    private IContractDetailService contractDetailService = new ContractDetailService();
    private IContractService contractService = new ContractService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                showAddContractDetailForm(req, resp);
                break;
            case "list":
                showAllContractDetail(req, resp);
                break;
            default:
                break;
        }
    }

    private void showAllContractDetail(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void showAddContractDetailForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Contract> contractList = contractService.getAllContract();
        req.setAttribute("contractList", contractList);
        List<AttachService> attachServiceList = contractDetailService.getAllAttachService();
        req.setAttribute("attachServiceList", attachServiceList);
        req.getRequestDispatcher("/views/contract-detail/add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                addNewContractDetail(req, resp);
                break;
            default:
                break;
        }
    }

    private void addNewContractDetail(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int contractId = Integer.parseInt(req.getParameter("contractId"));
            int attachServiceId = Integer.parseInt(req.getParameter("attachServiceId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            ContractDetail contractDetail = new ContractDetail();

            Contract contract = new Contract();
            contract.setContractId(contractId);
            contractDetail.setContract(contract);

            AttachService attachService = new AttachService();
            attachService.setAttachServiceId(attachServiceId);
            contractDetail.setAttachService(attachService);

            contractDetail.setQuantity(quantity);

            boolean success = contractDetailService.addContractDetail(contractDetail);
            if (success) {
                req.getSession().setAttribute("message", "Thêm hợp đồng chi tiết thành công !");
                req.getSession().setAttribute("messageType", "success");
            } else {
                req.getSession().setAttribute("message", "Thêm hợp đồng chi tiết thất bại. Vui lòng thử lại !");
                req.getSession().setAttribute("messageType", "error");
            }
            resp.sendRedirect("/home");
        } catch (Exception e) {
            req.getSession().setAttribute("message", "Loi khi add contract detail : " + e.getMessage());
            req.getSession().setAttribute("messageType", "error");
            resp.sendRedirect("/home");
        }
    }
}
