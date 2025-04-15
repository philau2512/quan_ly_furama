package com.example.khu_nghi_duong_furama.controller;

import com.example.khu_nghi_duong_furama.model.*;
import com.example.khu_nghi_duong_furama.service.IServiceService;
import com.example.khu_nghi_duong_furama.service.ServiceService;
import com.example.khu_nghi_duong_furama.util.AuthUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServiceServlet", urlPatterns = "/service")
public class ServiceServlet extends HttpServlet {
    private IServiceService serviceService = new ServiceService();

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
                showAddServiceForm(req, resp);
                break;
            case "list":
                showAllService(req, resp);
                break;
            default:
                break;
        }
    }

    private void showAllService(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Service> serviceList = serviceService.getAllService();
        req.setAttribute("serviceList", serviceList);
        req.getRequestDispatcher("/views/service/list.jsp").forward(req, resp);
    }

    private void showAddServiceForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<RentType> rentTypeList = serviceService.getAllRentType();
        req.setAttribute("rentTypeList", rentTypeList);

        List<ServiceType> serviceTypeList = serviceService.getAllServiceType();
        req.setAttribute("serviceTypeList", serviceTypeList);

        req.getRequestDispatcher("/views/service/add.jsp").forward(req, resp);
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
                addNewService(req, resp);
                break;
            default:
                break;
        }
    }

    private void addNewService(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String serviceName = req.getParameter("serviceName");
            double area = Double.parseDouble(req.getParameter("area"));
            double cost = Double.parseDouble(req.getParameter("cost"));
            int maxPeople = Integer.parseInt(req.getParameter("maxPeople"));
            int rentTypeId = Integer.parseInt(req.getParameter("rentTypeId"));
            int serviceTypeId = Integer.parseInt(req.getParameter("serviceTypeId"));

            RentType rentType = new RentType();
            rentType.setRentTypeId(rentTypeId);

            ServiceType serviceType = new ServiceType();
            serviceType.setServiceTypeId(serviceTypeId);

            Service service;

            if (serviceTypeId == 1) { // Villa
                String standardRoom = req.getParameter("standardRoom");
                String descriptionOtherConvenience = req.getParameter("descriptionOtherConvenience");
                double poolArea = req.getParameter("poolArea") != null && !req.getParameter("poolArea").isEmpty() ? Double.parseDouble(req.getParameter("poolArea")) : 0;
                int numberOfFloors = req.getParameter("numberOfFloors") != null && !req.getParameter("numberOfFloors").isEmpty() ? Integer.parseInt(req.getParameter("numberOfFloors")) : 0;

                Villa villa = new Villa();
                villa.setServiceName(serviceName);
                villa.setServiceArea(area);
                villa.setServiceCost(cost);
                villa.setServiceMaxPeople(maxPeople);
                villa.setServiceRentType(rentType);
                villa.setServiceType(serviceType);
                villa.setStandardRoom(standardRoom);
                villa.setDescriptionOtherConvenience(descriptionOtherConvenience);
                villa.setPoolArea(poolArea);
                villa.setNumberOfFloors(numberOfFloors);

                service = villa;
            } else if (serviceTypeId == 2) { // House
                String standardRoom = req.getParameter("standardRoom");
                String descriptionOtherConvenience = req.getParameter("descriptionOtherConvenience");
                int numberOfFloors = req.getParameter("numberOfFloors") != null && !req.getParameter("numberOfFloors").isEmpty() ? Integer.parseInt(req.getParameter("numberOfFloors")) : 0;

                House house = new House();
                house.setServiceName(serviceName);
                house.setServiceArea(area);
                house.setServiceCost(cost);
                house.setServiceMaxPeople(maxPeople);
                house.setServiceRentType(rentType);
                house.setServiceType(serviceType);
                house.setStandardRoom(standardRoom);
                house.setDescriptionOtherConvenience(descriptionOtherConvenience);
                house.setNumberOfFloors(numberOfFloors);

                service = house;
            } else { // Room
                String freeServiceIncluded = req.getParameter("freeServiceIncluded");

                Room room = new Room();
                room.setServiceName(serviceName);
                room.setServiceArea(area);
                room.setServiceCost(cost);
                room.setServiceMaxPeople(maxPeople);
                room.setServiceRentType(rentType);
                room.setServiceType(serviceType);
                room.setFreeServiceIncluded(freeServiceIncluded);

                service = room;
            }

            boolean status = serviceService.addService(service);

            if (status) {
                req.getSession().setAttribute("message", "Thêm dịch vụ " + serviceName + " thành công!");
                req.getSession().setAttribute("messageType", "success");
                resp.sendRedirect("/service?action=list");
            } else {
                req.getSession().setAttribute("message", "Them dich vu that bai. Vui long thu lai!");
                req.getSession().setAttribute("messageType", "error");
                resp.sendRedirect("/service?action=list");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("message", "Lỗi khi thêm dịch vụ : " + e.getMessage());
            req.getSession().setAttribute("messageType", "error");
            resp.sendRedirect("/service?action=list");
        }
    }
}


