<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Furama Resort Management</title>
    <c:import url="/layout/library.jsp"/>

    <style>

        .container {
            display: flex;
            min-height: 80vh;
            overflow: hidden;
        }

        .sidebar {
            width: 200px;
            background-color: #e9ecef;
            padding: 20px;
            border-right: 1px solid #ccc;
            flex-shrink: 0;
        }

        .sidebar ul {
            list-style: none;
        }

        .sidebar li {
            margin: 10px 0;
        }

        .sidebar a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
        }

        .sidebar a:hover {
            color: #0059b3;
        }

        .content {
            flex-grow: 1;
            padding: 30px;
            overflow: hidden;
        }

        footer {
            background-color: #003366;
            color: white;
            text-align: center;
            padding: 10px;
        }

        .carousel {
            width: 100%;
            max-width: 100%;
        }

        .carousel-inner {
            width: 100%;
            max-width: 100%;
            overflow: hidden;
            border-radius: 10px;
        }

        .carousel-item {
            width: 100%;
            height: 420px;
            overflow: hidden;
        }

        .carousel-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .carousel-indicators {
            bottom: 10px;
        }

        .carousel-control-prev,
        .carousel-control-next {
            width: 5%;
        }

    </style>

</head>
<body>
<c:import url="/layout/header.jsp"/>

<div class="container">
    <div class="sidebar">
        <ul>
            <li><a href="#">📝 Item One</a></li>
            <li><a href="#">📋 Item Two</a></li>
            <li><a href="#">📦 Item Three</a></li>
        </ul>
    </div>

    <div class="content">
        <h2>Welcome to Furama Resort Management System</h2>
        <p>This is your central hub to manage customers, employees, services, and contracts.</p>

        <div id="carouselFurama" class="carousel slide mt-4" data-bs-ride="carousel" data-bs-interval="3000">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="https://cdn.pixabay.com/photo/2017/12/16/22/22/bora-bora-3023437_1280.jpg" alt="Slide 1">
                </div>
                <div class="carousel-item">
                    <img src="https://cdn.pixabay.com/photo/2020/02/27/18/05/pool-4885450_1280.jpg" alt="Slide 2">
                </div>
                <div class="carousel-item">
                    <img src="https://cdn.pixabay.com/photo/2017/03/17/16/49/sun-spa-resort-2152106_1280.jpg"
                         alt="Slide 3">
                </div>
                <div class="carousel-item">
                    <img src="https://cdn.pixabay.com/photo/2017/03/17/16/49/sun-spa-resort-2152107_1280.jpg"
                         alt="Slide 4">
                </div>
                <div class="carousel-item">
                    <img src="https://cdn.pixabay.com/photo/2020/01/09/15/54/sea-4753135_1280.jpg" alt="Slide 5">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselFurama" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselFurama" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselFurama" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#carouselFurama" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#carouselFurama" data-bs-slide-to="2"></button>
                <button type="button" data-bs-target="#carouselFurama" data-bs-slide-to="3"></button>
                <button type="button" data-bs-target="#carouselFurama" data-bs-slide-to="4"></button>
            </div>
        </div>
    </div>
</div>

<footer>
    Furama Resort © 2025
</footer>

<script>
    $(document).ready(function () {
        var currentPath = window.location.pathname;
        $('.nav-links a').each(function () {
            var href = $(this).attr('href');
            if (href && currentPath.includes(href)) {
                $(this).addClass('active');
            }
        });
    });
</script>
</body>
</html>