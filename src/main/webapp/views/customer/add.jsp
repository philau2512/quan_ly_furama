<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thêm khách hàng mới</title>
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
        <h2>Thêm khách hàng mới</h2>
        <form action="customer?action=add" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Họ và tên</label>
                <input type="text" class="form-control" id="name" name="name" value="${messageType == 'error' ? param.name : ''}" required>
            </div>

            <div class="mb-3">
                <label for="birthday" class="form-label">Ngày sinh</label>
                <input type="date" class="form-control" id="birthday" name="birthday" value="${messageType == 'error' ? param.birthday : ''}" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Giới tính</label><br>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" id="male" value="Nam" ${messageType == 'error' && param.gender == 'Nam' || messageType != 'error' ? 'checked' : ''}>
                    <label class="form-check-label" for="male">Nam</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" id="female" value="Nữ" ${messageType == 'error' && param.gender == 'Nữ' ? 'checked' : ''}>
                    <label class="form-check-label" for="female">Nữ</label>
                </div>
            </div>

            <div class="mb-3">
                <label for="idCard" class="form-label">Số CMND/CCCD</label>
                <input type="text" class="form-control" id="idCard" name="idCard" value="${messageType == 'error' ? param.idCard : ''}" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="text" class="form-control" id="phone" name="phone" value="${messageType == 'error' ? param.phone : ''}" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="${messageType == 'error' ? param.email : ''}" required>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="address" name="address" value="${messageType == 'error' ? param.address : ''}" required>
            </div>

            <div class="mb-3">
                <label for="type" class="form-label">Loại khách hàng</label>
                <select class="form-select" id="type" name="typeId" required>
                    <c:forEach var="type" items="${customerTypeList}">
                        <option value="${type.id}" ${messageType == 'error' && param.typeId == type.id ? 'selected' : ''}>${type.name}</option>
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