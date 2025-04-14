<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thêm nhân viên mới</title>
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
        <h2>Thêm nhân viên mới</h2>
        <form action="employee?action=add" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Họ và tên</label>
                <input type="text" class="form-control" id="name" name="name"
                       value="${messageType == 'error' ? param.name : ''}" required>
            </div>

            <div class="mb-3">
                <label for="birthday" class="form-label">Ngày sinh</label>
                <input type="date" class="form-control" id="birthday" name="birthday"
                       value="${messageType == 'error' ? param.birthday : ''}" required>
            </div>

            <div class="mb-3">
                <label for="idCard" class="form-label">Số CMND/CCCD</label>
                <input type="text" class="form-control" id="idCard" name="idCard"
                       value="${messageType == 'error' ? param.idCard : ''}" required>
            </div>

            <div class="mb-3">
                <label for="salary" class="form-label">Lương</label>
                <input type="number" step="0.01" class="form-control" id="salary" name="salary"
                       value="${messageType == 'error' ? param.salary : ''}" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="text" class="form-control" id="phone" name="phone"
                       value="${messageType == 'error' ? param.phone : ''}" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email"
                       value="${messageType == 'error' ? param.email : ''}" required>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="address" name="address"
                       value="${messageType == 'error' ? param.address : ''}" required>
            </div>

            <div class="mb-3">
                <label for="position" class="form-label">Vị trí</label>
                <select class="form-select" id="position" name="positionId" required onchange="updatePositionName()">
                    <c:forEach var="position" items="${positionList}">
                        <option value="${position.positionId}" ${messageType == 'error' && param.positionId == position.positionId ? 'selected' : ''}>${position.positionName}</option>
                    </c:forEach>
                </select>
                <input type="hidden" id="positionName" name="positionName" value="">
            </div>

            <div class="mb-3">
                <label for="educationDegree" class="form-label">Trình độ</label>
                <select class="form-select" id="educationDegree" name="educationDegreeId" required onchange="updateEducationDegreeName()">
                    <c:forEach var="educationDegree" items="${educationDegreeList}">
                        <option value="${educationDegree.educationDegreeId}" ${messageType == 'error' && param.educationDegreeId == educationDegree.educationDegreeId ? 'selected' : ''}>${educationDegree.educationDegreeName}</option>
                    </c:forEach>
                </select>
                <input type="hidden" id="educationDegreeName" name="educationDegreeName" value="">
            </div>

            <div class="mb-3">
                <label for="division" class="form-label">Bộ phận</label>
                <select class="form-select" id="division" name="divisionId" required onchange="updateDivisionName()">
                    <c:forEach var="division" items="${divisionList}">
                        <option value="${division.divisionId}" ${messageType == 'error' && param.divisionId == division.divisionId ? 'selected' : ''}>${division.divisionName}</option>
                    </c:forEach>
                </select>
                <input type="hidden" id="divisionName" name="divisionName" value="">
            </div>

            <div class="mb-3">
                <label for="username" class="form-label">Tên đăng nhập</label>
                <input type="text" class="form-control" id="username" name="username"
                       value="${messageType == 'error' ? param.username : ''}" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>

            <input type="hidden" name="roleId" value="2">

            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary">Thêm mới</button>
                <a href="/employee?action=list" class="btn btn-secondary">Hủy</a>
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
    // Cập nhật positionName khi chọn vị trí
    function updatePositionName() {
        var select = document.getElementById("position");
        var positionNameInput = document.getElementById("positionName");
        positionNameInput.value = select.options[select.selectedIndex].text;
    }

    // Cập nhật educationDegreeName khi chọn trình độ
    function updateEducationDegreeName() {
        var select = document.getElementById("educationDegree");
        var educationDegreeNameInput = document.getElementById("educationDegreeName");
        educationDegreeNameInput.value = select.options[select.selectedIndex].text;
    }

    // Cập nhật divisionName khi chọn bộ phận
    function updateDivisionName() {
        var select = document.getElementById("division");
        var divisionNameInput = document.getElementById("divisionName");
        divisionNameInput.value = select.options[select.selectedIndex].text;
    }

    // Gọi hàm để cập nhật giá trị ban đầu khi trang được tải
    window.onload = function() {
        updatePositionName();
        updateEducationDegreeName();
        updateDivisionName();
    };
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>