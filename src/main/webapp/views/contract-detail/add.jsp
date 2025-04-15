<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thêm hợp đồng mới</title>
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

        .error {
            color: red;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
<c:import url="../../layout/header.jsp"/>

<div class="container">
    <div class="form-container">
        <h2>Thêm hợp đồng mới</h2>
        <form action="contract?action=add" method="post" onsubmit="return validateForm()">
            <div class="mb-3">
                <label for="startDate" class="form-label">Ngày bắt đầu</label>
                <input type="datetime-local" class="form-control" id="startDate" name="startDate"
                       value="${messageType == 'error' ? param.startDate : ''}" required>
                <div id="startDateError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="endDate" class="form-label">Ngày kết thúc</label>
                <input type="datetime-local" class="form-control" id="endDate" name="endDate"
                       value="${messageType == 'error' ? param.endDate : ''}" required>
                <div id="endDateError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="deposit" class="form-label">Tiền cọc (VNĐ)</label>
                <input type="number" step="0.01" class="form-control" id="deposit" name="deposit"
                       value="${messageType == 'error' ? param.deposit : ''}" required>
                <div id="depositError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="totalMoney" class="form-label">Tổng tiền (VNĐ)</label>
                <input type="number" step="0.01" class="form-control" id="totalMoney" name="totalMoney"
                       value="${messageType == 'error' ? param.totalMoney : ''}" required>
                <div id="totalMoneyError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="employeeId" class="form-label">Nhân viên</label>
                <select class="form-select" id="employeeId" name="employeeId" required>
                    <c:forEach var="employee" items="${employeeList}">
                        <option value="${employee.employeeId}" ${messageType == 'error' && param.employeeId == employee.employeeId ? 'selected' : ''}>${employee.employeeName}</option>
                    </c:forEach>
                </select>
                <div id="employeeIdError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="customerId" class="form-label">Khách hàng</label>
                <select class="form-select" id="customerId" name="customerId" required>
                    <c:forEach var="customer" items="${customerList}">
                        <option value="${customer.customerId}" ${messageType == 'error' && param.customerId == customer.customerId ? 'selected' : ''}>${customer.customerName}</option>
                    </c:forEach>
                </select>
                <div id="customerIdError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="serviceId" class="form-label">Dịch vụ</label>
                <select class="form-select" id="serviceId" name="serviceId" required>
                    <c:forEach var="service" items="${serviceList}">
                        <option value="${service.serviceId}" ${messageType == 'error' && param.serviceId == service.serviceId ? 'selected' : ''}>${service.serviceName}
                            (${service.serviceType.serviceTypeName})
                        </option>
                    </c:forEach>
                </select>
                <div id="serviceIdError" class="error"></div>
            </div>

            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary">Thêm mới</button>
                <a href="/home" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<!-- Import modal thông báo -->
<c:import url="/views/common/notification-modal.jsp"/>

<!-- Import validation.js -->
<script src="/common/validation.js"></script>

<!-- Script hiển thị modal thông báo và validate -->
<script>
    <c:if test="${not empty message}">
    showNotificationModal('${message}', '${messageType != null ? messageType : "success"}');
    <% session.removeAttribute("message"); %>
    <% session.removeAttribute("messageType"); %>
    </c:if>

    function validateForm() {
        let isValid = true;

        // Validate ngày bắt đầu
        const startDate = document.getElementById("startDate").value;
        if (!startDate) {
            showError("startDateError", "Ngày bắt đầu không được để trống!");
            isValid = false;
        } else {
            const start = new Date(startDate);
            const today = new Date();
            today.setHours(0, 0, 0, 0); // Đặt giờ về 00:00:00 để so sánh chính xác
            if (start < today) {
                showError("startDateError", "Ngày bắt đầu phải từ ngày hiện tại trở đi!");
                isValid = false;
            } else {
                clearError("startDateError");
            }
        }

        // Validate ngày kết thúc
        const endDate = document.getElementById("endDate").value;
        if (!endDate) {
            showError("endDateError", "Ngày kết thúc không được để trống!");
            isValid = false;
        } else {
            const end = new Date(endDate);
            const start = new Date(startDate);
            if (end <= start) {
                showError("endDateError", "Ngày kết thúc phải sau ngày bắt đầu!");
                isValid = false;
            } else {
                clearError("endDateError");
            }
        }

        // Validate tiền cọc
        const deposit = document.getElementById("deposit").value;
        if (!deposit) {
            showError("depositError", "Tiền cọc không được để trống!");
            isValid = false;
        } else if (deposit < 0) {
            showError("depositError", "Tiền cọc phải là số dương!");
            isValid = false;
        } else {
            clearError("depositError");
        }

        // Validate tổng tiền
        const totalMoney = document.getElementById("totalMoney").value;
        if (!totalMoney) {
            showError("totalMoneyError", "Tổng tiền không được để trống!");
            isValid = false;
        } else if (totalMoney < 0) {
            showError("totalMoneyError", "Tổng tiền phải là số dương!");
            isValid = false;
        } else if (parseFloat(totalMoney) < parseFloat(deposit)) {
            showError("totalMoneyError", "Tổng tiền phải lớn hơn hoặc bằng tiền cọc!");
            isValid = false;
        } else {
            clearError("totalMoneyError");
        }

        // Validate nhân viên
        const employeeId = document.getElementById("employeeId").value;
        if (!employeeId) {
            showError("employeeIdError", "Vui lòng chọn nhân viên!");
            isValid = false;
        } else {
            clearError("employeeIdError");
        }

        // Validate khách hàng
        const customerId = document.getElementById("customerId").value;
        if (!customerId) {
            showError("customerIdError", "Vui lòng chọn khách hàng!");
            isValid = false;
        } else {
            clearError("customerIdError");
        }

        // Validate dịch vụ
        const serviceId = document.getElementById("serviceId").value;
        if (!serviceId) {
            showError("serviceIdError", "Vui lòng chọn dịch vụ!");
            isValid = false;
        } else {
            clearError("serviceIdError");
        }

        return isValid;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>