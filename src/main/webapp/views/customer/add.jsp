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
        <h2>Thêm khách hàng mới</h2>
        <form action="customer?action=add" method="post" onsubmit="return validateForm()">
            <div class="mb-3">
                <label for="name" class="form-label">Họ và tên</label>
                <input type="text" class="form-control" id="name" name="name" value="${messageType == 'error' ? param.name : ''}" required>
                <div id="nameError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="birthday" class="form-label">Ngày sinh</label>
                <input type="date" class="form-control" id="birthday" name="birthday" value="${messageType == 'error' ? param.birthday : ''}" max="${LocalDate.now().toString()}" required>
                <div id="birthdayError" class="error"></div>
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
                <div id="genderError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="idCard" class="form-label">Số CMND/CCCD</label>
                <input type="text" class="form-control" id="idCard" name="idCard" value="${messageType == 'error' ? param.idCard : ''}" required>
                <div id="idCardError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="text" class="form-control" id="phone" name="phone" value="${messageType == 'error' ? param.phone : ''}" required>
                <div id="phoneError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="${messageType == 'error' ? param.email : ''}" required>
                <div id="emailError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="address" name="address" value="${messageType == 'error' ? param.address : ''}" required>
                <div id="addressError" class="error"></div>
            </div>

            <div class="mb-3">
                <label for="type" class="form-label">Loại khách hàng</label>
                <select class="form-select" id="type" name="typeId" required>
                    <c:forEach var="type" items="${customerTypeList}">
                        <option value="${type.id}" ${messageType == 'error' && param.typeId == type.id ? 'selected' : ''}>${type.name}</option>
                    </c:forEach>
                </select>
                <div id="typeError" class="error"></div>
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
<script>
    <c:if test="${not empty message}">
    showNotificationModal('${message}', '${messageType != null ? messageType : "success"}');
    <% session.removeAttribute("message"); %>
    <% session.removeAttribute("messageType"); %>
    </c:if>

    function validateForm() {
        let isValid = true;

        // Validate họ và tên (không rỗng)
        const name = document.getElementById("name").value.trim();
        if (!name) {
            showError("nameError", "Họ và tên không được để trống!");
            isValid = false;
        } else {
            clearError("nameError");
        }

        // Validate ngày sinh
        const birthday = document.getElementById("birthday").value;
        if (!birthday) {
            showError("birthdayError", "Ngày sinh không được để trống!");
            isValid = false;
        } else {
            // Kiểm tra ngày sinh có trước ngày hiện tại không
            const selectedDate = new Date(birthday);
            const today = new Date();
            today.setHours(0, 0, 0, 0); // Đặt giờ về 00:00:00 để so sánh chính xác
            if (selectedDate >= today) {
                showError("birthdayError", "Ngày sinh phải trước ngày hiện tại!");
                isValid = false;
            } else {
                clearError("birthdayError");
            }
        }

        // Validate giới tính
        const gender = document.querySelector('input[name="gender"]:checked');
        if (!gender) {
            showError("genderError", "Vui lòng chọn giới tính!");
            isValid = false;
        } else {
            clearError("genderError");
        }

        // Validate số CMND/CCCD
        const idCard = document.getElementById("idCard").value.trim();
        if (!validateIdNumber(idCard)) {
            showError("idCardError", "Số CMND/CCCD phải có 9 hoặc 12 chữ số!");
            isValid = false;
        } else {
            clearError("idCardError");
        }

        // Validate số điện thoại
        const phone = document.getElementById("phone").value.trim();
        if (!validatePhoneNumber(phone)) {
            showError("phoneError", "Số điện thoại phải có định dạng 090xxxxxxx, 091xxxxxxx, (84)+90xxxxxxx hoặc (84)+91xxxxxxx!");
            isValid = false;
        } else {
            clearError("phoneError");
        }

        // Validate email
        const email = document.getElementById("email").value.trim();
        if (!validateEmail(email)) {
            showError("emailError", "Email không đúng định dạng!");
            isValid = false;
        } else {
            clearError("emailError");
        }

        // Validate địa chỉ (không rỗng)
        const address = document.getElementById("address").value.trim();
        if (!address) {
            showError("addressError", "Địa chỉ không được để trống!");
            isValid = false;
        } else {
            clearError("addressError");
        }

        // Validate loại khách hàng
        const type = document.getElementById("type").value;
        if (!type) {
            showError("typeError", "Vui lòng chọn loại khách hàng!");
            isValid = false;
        } else {
            clearError("typeError");
        }

        return isValid;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>