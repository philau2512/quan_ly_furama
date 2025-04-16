<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa dịch vụ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
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
        <h2>Chỉnh sửa dịch vụ</h2>
        <c:if test="${service == null}">
            <div class="alert alert-danger">Không tìm thấy dịch vụ để chỉnh sửa!</div>
        </c:if>
        <c:if test="${service != null}">
            <form action="/service?action=edit" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="serviceId" value="${service.serviceId}">
                <div class="mb-3">
                    <label for="serviceName" class="form-label">Tên dịch vụ</label>
                    <input type="text" class="form-control" id="serviceName" name="serviceName"
                           value="${service.serviceName}" required>
                    <div id="serviceNameError" class="error"></div>
                </div>

                <div class="mb-3">
                    <label for="area" class="form-label">Diện tích (m²)</label>
                    <input type="number" step="0.01" class="form-control" id="area" name="area"
                           value="${service.serviceArea}" required>
                    <div id="areaError" class="error"></div>
                </div>

                <div class="mb-3">
                    <label for="cost" class="form-label">Chi phí thuê (VNĐ)</label>
                    <input type="number" step="0.01" class="form-control" id="cost" name="cost"
                           value="${service.serviceCost}" required>
                    <div id="costError" class="error"></div>
                </div>

                <div class="mb-3">
                    <label for="maxPeople" class="form-label">Số người tối đa</label>
                    <input type="number" class="form-control" id="maxPeople" name="maxPeople"
                           value="${service.serviceMaxPeople}" required>
                    <div id="maxPeopleError" class="error"></div>
                </div>

                <div class="mb-3">
                    <label for="rentTypeId" class="form-label">Loại thuê</label>
                    <c:if test="${empty rentTypeList}">
                        <div class="alert alert-warning">Không có loại thuê nào để hiển thị!</div>
                    </c:if>
                    <c:if test="${not empty rentTypeList}">
                        <select class="form-select" id="rentTypeId" name="rentTypeId" required>
                            <c:forEach var="rentType" items="${rentTypeList}">
                                <option value="${rentType.rentTypeId}"
                                        <c:if test="${service.serviceRentType != null && service.serviceRentType.rentTypeId == rentType.rentTypeId}">selected</c:if>>${rentType.rentTypeName}</option>
                            </c:forEach>
                        </select>
                    </c:if>
                    <div id="rentTypeIdError" class="error"></div>
                </div>

                <div class="mb-3">
                    <label for="serviceTypeId" class="form-label">Loại dịch vụ</label>
                    <c:if test="${empty serviceTypeList}">
                        <div class="alert alert-warning">Không có loại dịch vụ nào để hiển thị!</div>
                    </c:if>
                    <c:if test="${not empty serviceTypeList}">
                        <select class="form-select" id="serviceTypeId" name="serviceTypeId" required
                                onchange="toggleAdditionalFields()">
                            <c:forEach var="serviceType" items="${serviceTypeList}">
                                <option value="${serviceType.serviceTypeId}"
                                        <c:if test="${service.serviceType != null && service.serviceType.serviceTypeId == serviceType.serviceTypeId}">selected</c:if>>${serviceType.serviceTypeName}</option>
                            </c:forEach>
                        </select>
                    </c:if>
                    <div id="serviceTypeIdError" class="error"></div>
                </div>

                <!-- Các trường bổ sung cho Villa -->
                <div id="villaFields" class="additional-fields">
                    <div class="mb-3">
                        <label for="standardRoomVilla" class="form-label">Tiêu chuẩn phòng</label>
                        <input type="text" class="form-control" id="standardRoomVilla" name="standardRoom"
                               value="${service.serviceType != null && service.serviceType.serviceTypeId == 1 ? service.standardRoom : ''}">
                        <div id="standardRoomVillaError" class="error"></div>
                    </div>
                    <div class="mb-3">
                        <label for="descriptionOtherConvenienceVilla" class="form-label">Tiện nghi khác</label>
                        <input type="text" class="form-control" id="descriptionOtherConvenienceVilla"
                               name="descriptionOtherConvenience"
                               value="${service.serviceType != null && service.serviceType.serviceTypeId == 1 ? service.descriptionOtherConvenience : ''}">
                        <div id="descriptionOtherConvenienceVillaError" class="error"></div>
                    </div>
                    <div class="mb-3">
                        <label for="poolArea" class="form-label">Diện tích hồ bơi (m²)</label>
                        <input type="number" step="0.01" class="form-control" id="poolArea" name="poolArea"
                               value="${service.serviceType != null && service.serviceType.serviceTypeId == 1 ? service.poolArea : ''}">
                        <div id="poolAreaError" class="error"></div>
                    </div>
                    <div class="mb-3">
                        <label for="numberOfFloorsVilla" class="form-label">Số tầng</label>
                        <input type="number" class="form-control" id="numberOfFloorsVilla" name="numberOfFloors"
                               value="${service.serviceType != null && service.serviceType.serviceTypeId == 1 ? service.numberOfFloors : ''}">
                        <div id="numberOfFloorsVillaError" class="error"></div>
                    </div>
                </div>

                <!-- Các trường bổ sung cho House -->
                <div id="houseFields" class="additional-fields">
                    <div class="mb-3">
                        <label for="standardRoomHouse" class="form-label">Tiêu chuẩn phòng</label>
                        <input type="text" class="form-control" id="standardRoomHouse" name="standardRoom"
                               value="${service.serviceType != null && service.serviceType.serviceTypeId == 2 ? service.standardRoom : ''}">
                        <div id="standardRoomHouseError" class="error"></div>
                    </div>
                    <div class="mb-3">
                        <label for="descriptionOtherConvenienceHouse" class="form-label">Tiện nghi khác</label>
                        <input type="text" class="form-control" id="descriptionOtherConvenienceHouse"
                               name="descriptionOtherConvenience"
                               value="${service.serviceType != null && service.serviceType.serviceTypeId == 2 ? service.descriptionOtherConvenience : ''}">
                        <div id="descriptionOtherConvenienceHouseError" class="error"></div>
                    </div>
                    <div class="mb-3">
                        <label for="numberOfFloorsHouse" class="form-label">Số tầng</label>
                        <input type="number" class="form-control" id="numberOfFloorsHouse" name="numberOfFloors"
                               value="${service.serviceType != null && service.serviceType.serviceTypeId == 2 ? service.numberOfFloors : ''}">
                        <div id="numberOfFloorsHouseError" class="error"></div>
                    </div>
                </div>

                <!-- Các trường bổ sung cho Room -->
                <div id="roomFields" class="additional-fields">
                    <div class="mb-3">
                        <label for="freeServiceIncluded" class="form-label">Dịch vụ miễn phí đi kèm</label>
                        <input type="text" class="form-control" id="freeServiceIncluded" name="freeServiceIncluded"
                               value="${service.serviceType != null && service.serviceType.serviceTypeId == 3 ? service.freeServiceIncluded : ''}">
                        <div id="freeServiceIncludedError" class="error"></div>
                    </div>
                </div>

                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                    <a href="/contract?action=list-customers-using-service" class="btn btn-secondary">Hủy</a>
                </div>
            </form>
        </c:if>
    </div>
</div>

<c:import url="/views/common/notification-modal.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="/common/validation.js"></script>
<script>
    <c:if test="${not empty message}">
    showNotificationModal('${message}', '${messageType != null ? messageType : "success"}');
    </c:if>

    function toggleAdditionalFields() {
        const serviceTypeElement = document.getElementById("serviceTypeId");
        if (serviceTypeElement) {
            const serviceTypeId = serviceTypeElement.value;
            const villaFields = document.getElementById("villaFields");
            const houseFields = document.getElementById("houseFields");
            const roomFields = document.getElementById("roomFields");

            // Ẩn tất cả các trường bổ sung trước
            villaFields.style.display = "none";
            houseFields.style.display = "none";
            roomFields.style.display = "none";

            // Hiển thị trường tương ứng với loại dịch vụ được chọn
            if (serviceTypeId == "1") {
                villaFields.style.display = "block";
            } else if (serviceTypeId == "2") {
                houseFields.style.display = "block";
            } else if (serviceTypeId == "3") {
                roomFields.style.display = "block";
            }
        } else {
            console.log("Không tìm thấy phần tử #serviceTypeId");
        }
    }

    // Gọi hàm để hiển thị các trường bổ sung ngay khi tải trang
    toggleAdditionalFields();

    function validateForm() {
        let isValid = true;

        // Validate diện tích (số dương)
        const area = document.getElementById("area").value;
        if (!validatePositiveNumber(area)) {
            showError("areaError", "Diện tích phải là số dương!");
            isValid = false;
        } else {
            clearError("areaError");
        }

        // Validate chi phí thuê (số dương)
        const cost = document.getElementById("cost").value;
        if (!validatePositiveNumber(cost)) {
            showError("costError", "Chi phí thuê phải là số dương!");
            isValid = false;
        } else {
            clearError("costError");
        }

        // Validate số người tối đa (số nguyên dương)
        const maxPeople = document.getElementById("maxPeople").value;
        if (!validatePositiveInteger(maxPeople)) {
            showError("maxPeopleError", "Số người tối đa phải là số nguyên dương!");
            isValid = false;
        } else {
            clearError("maxPeopleError");
        }

        // Validate các trường bổ sung cho Villa
        const serviceTypeId = document.getElementById("serviceTypeId").value;
        if (serviceTypeId == "1") {
            const poolArea = document.getElementById("poolArea").value;
            if (poolArea && !validatePositiveNumber(poolArea)) {
                showError("poolAreaError", "Diện tích hồ bơi phải là số dương!");
                isValid = false;
            } else {
                clearError("poolAreaError");
            }

            const numberOfFloorsVilla = document.getElementById("numberOfFloorsVilla").value;
            if (numberOfFloorsVilla && !validatePositiveInteger(numberOfFloorsVilla)) {
                showError("numberOfFloorsVillaError", "Số tầng phải là số nguyên dương!");
                isValid = false;
            } else {
                clearError("numberOfFloorsVillaError");
            }
        }

        // Validate các trường bổ sung cho House
        if (serviceTypeId == "2") {
            const numberOfFloorsHouse = document.getElementById("numberOfFloorsHouse").value;
            if (numberOfFloorsHouse && !validatePositiveInteger(numberOfFloorsHouse)) {
                showError("numberOfFloorsHouseError", "Số tầng phải là số nguyên dương!");
                isValid = false;
            } else {
                clearError("numberOfFloorsHouseError");
            }
        }

        return isValid;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>