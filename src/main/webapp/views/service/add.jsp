<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thêm dịch vụ mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f0f2f5;
        }

        .form-container {
            max-width: 700px;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin: 40px auto;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #003366;
        }

        .btn-primary {
            background-color: #0059b3;
            border: none;
        }

        .btn-primary:hover {
            background-color: #004080;
        }

        .additional-fields {
            display: none;
        }
    </style>
</head>
<body>
<c:import url="../../layout/header.jsp"/>

<div class="container">
    <div class="form-container">
        <h2>Thêm dịch vụ mới</h2>
        <form action="service?action=add" method="post">
            <div class="mb-3">
                <label for="serviceType" class="form-label">Loại dịch vụ</label>
                <select class="form-select" id="serviceType" name="serviceTypeId" required onchange="toggleFields()">
                    <c:forEach var="serviceType" items="${serviceTypeList}">
                        <option value="${serviceType.serviceTypeId}" ${messageType == 'error' && param.serviceTypeId == serviceType.serviceTypeId ? 'selected' : ''}>${serviceType.serviceTypeName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label for="serviceName" class="form-label">Tên dịch vụ</label>
                <input type="text" class="form-control" id="serviceName" name="serviceName"
                       value="${messageType == 'error' ? param.serviceName : ''}" required>
            </div>

            <div class="mb-3">
                <label for="area" class="form-label">Diện tích (m²)</label>
                <input type="number" step="0.01" class="form-control" id="area" name="area"
                       value="${messageType == 'error' ? param.area : ''}" required>
            </div>

            <div class="mb-3">
                <label for="cost" class="form-label">Chi phí thuê</label>
                <input type="number" step="0.01" class="form-control" id="cost" name="cost"
                       value="${messageType == 'error' ? param.cost : ''}" required>
            </div>

            <div class="mb-3">
                <label for="maxPeople" class="form-label">Số người tối đa</label>
                <input type="number" class="form-control" id="maxPeople" name="maxPeople"
                       value="${messageType == 'error' ? param.maxPeople : ''}" required>
            </div>

            <div class="mb-3">
                <label for="rentType" class="form-label">Loại thuê</label>
                <select class="form-select" id="rentType" name="rentTypeId" required>
                    <c:forEach var="rentType" items="${rentTypeList}">
                        <option value="${rentType.rentTypeId}" ${messageType == 'error' && param.rentTypeId == rentType.rentTypeId ? 'selected' : ''}>${rentType.rentTypeName}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Các trường dành cho House và Villa -->
            <div id="houseVillaFields" class="additional-fields">
                <div class="mb-3">
                    <label for="standardRoom" class="form-label">Tiêu chuẩn phòng</label>
                    <input type="text" class="form-control" id="standardRoom" name="standardRoom"
                           value="${messageType == 'error' ? param.standardRoom : ''}">
                </div>

                <div class="mb-3">
                    <label for="descriptionOtherConvenience" class="form-label">Mô tả tiện nghi khác</label>
                    <textarea class="form-control" id="descriptionOtherConvenience" name="descriptionOtherConvenience" rows="3">${messageType == 'error' ? param.descriptionOtherConvenience : ''}</textarea>
                </div>

                <div class="mb-3">
                    <label for="numberOfFloors" class="form-label">Số tầng</label>
                    <input type="number" class="form-control" id="numberOfFloors" name="numberOfFloors"
                           value="${messageType == 'error' ? param.numberOfFloors : ''}">
                </div>
            </div>

            <!-- Trường dành riêng cho Villa -->
            <div id="villaFields" class="additional-fields">
                <div class="mb-3">
                    <label for="poolArea" class="form-label">Diện tích hồ bơi (m²)</label>
                    <input type="number" step="0.01" class="form-control" id="poolArea" name="poolArea"
                           value="${messageType == 'error' ? param.poolArea : ''}">
                </div>
            </div>

            <!-- Trường dành riêng cho Room -->
            <div id="roomFields" class="additional-fields">
                <div class="mb-3">
                    <label for="freeServiceIncluded" class="form-label">Dịch vụ miễn phí đi kèm</label>
                    <input type="text" class="form-control" id="freeServiceIncluded" name="freeServiceIncluded"
                           value="${messageType == 'error' ? param.freeServiceIncluded : ''}">
                </div>
            </div>

            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary">Thêm mới</button>
                <a href="/service?action=list" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<!-- Import modal thông báo -->
<c:import url="/views/common/notification-modal.jsp"/>
<!-- Script hiển thị modal thông báo -->
<script>
    <c:if test="${not empty message}">
    showNotificationModal('${message}', '${messageType != null ? messageType : "success"}');
    <% session.removeAttribute("message"); %>
    <% session.removeAttribute("messageType"); %>
    </c:if>
</script>

<script>
    function toggleFields() {
        var serviceTypeId = document.getElementById("serviceType").value;
        var houseVillaFields = document.getElementById("houseVillaFields");
        var villaFields = document.getElementById("villaFields");
        var roomFields = document.getElementById("roomFields");

        // Ẩn tất cả các trường bổ sung
        houseVillaFields.style.display = "none";
        villaFields.style.display = "none";
        roomFields.style.display = "none";

        // Hiển thị các trường tương ứng với loại dịch vụ
        if (serviceTypeId == "1") { // Villa
            houseVillaFields.style.display = "block";
            villaFields.style.display = "block";
        } else if (serviceTypeId == "2") { // House
            houseVillaFields.style.display = "block";
        } else if (serviceTypeId == "3") { // Room
            roomFields.style.display = "block";
        }
    }

    // Gọi hàm toggleFields khi trang được tải để hiển thị các trường phù hợp
    window.onload = function() {
        toggleFields();
    };
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>