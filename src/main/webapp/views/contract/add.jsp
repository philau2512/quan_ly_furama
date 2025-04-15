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
    </style>
</head>
<body>
<c:import url="../../layout/header.jsp"/>

<div class="container">
    <div class="form-container">
        <h2>Thêm hợp đồng mới</h2>
        <form action="contract?action=add" method="post">
            <div class="mb-3">
                <label for="startDate" class="form-label">Ngày bắt đầu</label>
                <input type="datetime-local" class="form-control" id="startDate" name="startDate"
                       value="${messageType == 'error' ? param.startDate : ''}" required>
            </div>

            <div class="mb-3">
                <label for="endDate" class="form-label">Ngày kết thúc</label>
                <input type="datetime-local" class="form-control" id="endDate" name="endDate"
                       value="${messageType == 'error' ? param.endDate : ''}" required>
            </div>

            <div class="mb-3">
                <label for="deposit" class="form-label">Tiền cọc (VNĐ)</label>
                <input type="number" step="0.01" class="form-control" id="deposit" name="deposit"
                       value="${messageType == 'error' ? param.deposit : ''}" required>
            </div>

            <div class="mb-3">
                <label for="totalMoney" class="form-label">Tổng tiền (VNĐ)</label>
                <input type="number" step="0.01" class="form-control" id="totalMoney" name="totalMoney"
                       value="${messageType == 'error' ? param.totalMoney : ''}" required>
            </div>

            <div class="mb-3">
                <label for="employeeId" class="form-label">Nhân viên</label>
                <select class="form-select" id="employeeId" name="employeeId" required>
                    <c:forEach var="employee" items="${employeeList}">
                        <option value="${employee.employeeId}" ${messageType == 'error' && param.employeeId == employee.employeeId ? 'selected' : ''}>${employee.employeeName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label for="customerId" class="form-label">Khách hàng</label>
                <select class="form-select" id="customerId" name="customerId" required>
                    <c:forEach var="customer" items="${customerList}">
                        <option value="${customer.customerId}" ${messageType == 'error' && param.customerId == customer.customerId ? 'selected' : ''}>${customer.customerName}</option>
                    </c:forEach>
                </select>
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
<!-- Script hiển thị modal thông báo -->
<script>
    <c:if test="${not empty message}">
    showNotificationModal('${message}', '${messageType != null ? messageType : "success"}');
    <% session.removeAttribute("message"); %>
    <% session.removeAttribute("messageType"); %>
    </c:if>
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>