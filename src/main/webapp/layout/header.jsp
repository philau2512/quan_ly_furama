<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Furama Resort Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background-color: #003366;
            color: white;
        }

        .logo {
            font-weight: bold;
            font-size: 22px;
        }

        .username {
            font-size: 14px;
            margin-right: 20px;
        }

        header a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        header a:hover {
            text-decoration: underline;
        }

        header i {
            margin-right: 5px;
        }

        nav {
            background-color: #0059b3;
            padding: 10px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        .nav-links a:hover,
        .nav-links .dropdown-toggle:hover {
            text-decoration: underline;
        }

        .nav-links i {
            margin-right: 5px;
        }

        .nav-links a.active {
            background-color: #003366;
            padding: 5px 10px;
            border-radius: 4px;
        }

        .search-bar input {
            padding: 6px 10px;
            border: none;
            border-radius: 4px;
            width: 200px;
        }

        .dropdown-menu {
            background-color: #0059b3;
        }

        .dropdown-item {
            color: white;
        }

        .dropdown-item:hover {
            background-color: #003366;
            color: white;
        }

        .dropdown {
            margin-left: 20px;
        }

    </style>
</head>
<body>

<header>
    <div class="logo">🏖 Furama Resort</div>
    <div style="display: flex; align-items: center; gap: 10px;">
        <c:choose>
            <c:when test="${not empty fn:trim(sessionScope.username)}">
                <div class="username">
                    Welcome, <strong>${sessionScope.username}</strong>
                    &nbsp;|&nbsp;
                    <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </c:when>

            <c:otherwise>
                <a href="/login"><i class="fas fa-sign-in-alt"></i> Login</a>
                <span>|</span>
                <a href="/register"><i class="fas fa-user-plus"></i> Signup</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<nav>
    <div class="nav-links">
        <a href="home"><i class="fas fa-home"></i> Home</a>
        <div class="dropdown">
            <a class="dropdown-toggle" href="#" role="button" id="employeeDropdown" data-bs-toggle="dropdown"
               aria-expanded="false">
                <i class="fas fa-users"></i> Employee
            </a>
            <ul class="dropdown-menu" aria-labelledby="employeeDropdown">
                <li><a class="dropdown-item" href="employee?action=list">Danh sách nhân viên</a></li>
                <li><a class="dropdown-item" href="employee?action=add">Thêm nhân viên mới</a></li>
                <li><a class="dropdown-item" href="employee?action=stats">Thống kê nhân viên</a></li>
            </ul>
        </div>
        <div class="dropdown">
            <a class="dropdown-toggle" href="#" role="button" id="customerDropdown" data-bs-toggle="dropdown"
               aria-expanded="false">
                <i class="fas fa-user-tie"></i> Customer
            </a>
            <ul class="dropdown-menu" aria-labelledby="customerDropdown">
                <li><a class="dropdown-item" href="customer?action=list">Danh sách khách hàng</a></li>
                <li><a class="dropdown-item" href="customer?action=add">Thêm khách hàng mới</a></li>
                <li><a class="dropdown-item" href="customer?action=usingService">Khách hàng đang sử dụng dịch vụ</a>
                </li>
            </ul>
        </div>
        <div class="dropdown">
            <a class="dropdown-toggle" href="#" role="button" id="serviceDropdown" data-bs-toggle="dropdown"
               aria-expanded="false">
                <i class="fas fa-concierge-bell"></i> Service
            </a>
            <ul class="dropdown-menu" aria-labelledby="serviceDropdown">
                <li><a class="dropdown-item" href="service?action=list">Danh sách dịch vụ</a></li>
                <li><a class="dropdown-item" href="service?action=add">Thêm dịch vụ mới</a></li>
                <li><a class="dropdown-item" href="service?action=attach">Dịch vụ đi kèm</a></li>
            </ul>
        </div>
        <div class="dropdown">
            <a class="dropdown-toggle" href="#" role="button" id="contractDropdown" data-bs-toggle="dropdown"
               aria-expanded="false">
                <i class="fas fa-file-contract"></i> Contract
            </a>
            <ul class="dropdown-menu" aria-labelledby="contractDropdown">
                <li><a class="dropdown-item" href="contract?action=list">Danh sách hợp đồng</a></li>
                <li><a class="dropdown-item" href="contract?action=add">Thêm hợp đồng mới</a></li>
                <li><a class="dropdown-item" href="contract?action=addDetail">Thêm chi tiết hợp đồng</a></li>
            </ul>
        </div>
    </div>
    <div class="search-bar">
        <form action="search" method="get">
            <input type="text" name="keyword" placeholder="Search...">
        </form>
    </div>
</nav>
<!-- Import modal thông báo -->
<c:import url="/views/common/notification-modal.jsp"/>
</html>
