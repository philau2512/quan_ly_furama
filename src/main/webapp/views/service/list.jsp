<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Danh sách dịch vụ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f0f2f5;
        }

        .table-container {
            max-width: 1200px;
            background: white;
            padding: 20px;
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

        th, td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
<c:import url="../../layout/header.jsp"/>

<div class="container">
    <div class="table-container">
        <h2>Danh sách dịch vụ</h2>
        <div class="mb-3 text-end">
            <a href="/service?action=add" class="btn btn-primary">Thêm dịch vụ mới</a>
        </div>
        <table id="serviceTable" class="table table-striped table-bordered">
            <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Tên dịch vụ</th>
                <th>Loại dịch vụ</th>
                <th>Diện tích (m²)</th>
                <th>Chi phí thuê</th>
                <th>Số người tối đa</th>
                <th>Loại thuê</th>
                <th>Thông tin bổ sung</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="service" items="${serviceList}" varStatus="loop">
                <tr>
                    <td>${loop.count}</td>
                    <td>${service.serviceName}</td>
                    <td>${service.serviceType.serviceTypeName}</td>
                    <td>${service.serviceArea}</td>
                    <td><fmt:formatNumber value="${service.serviceCost}" type="currency" currencySymbol="VNĐ"/></td>
                    <td>${service.serviceMaxPeople}</td>
                    <td>${service.serviceRentType.rentTypeName}</td>
                    <td>
                        <c:choose>
                            <c:when test="${service.serviceType.serviceTypeId == 1}">
                                <!-- Villa -->
                                Tiêu chuẩn phòng: ${service.standardRoom}<br>
                                Tiện nghi khác: ${service.descriptionOtherConvenience}<br>
                                Diện tích hồ bơi: ${service.poolArea} m²<br>
                                Số tầng: ${service.numberOfFloors}
                            </c:when>
                            <c:when test="${service.serviceType.serviceTypeId == 2}">
                                <!-- House -->
                                Tiêu chuẩn phòng: ${service.standardRoom}<br>
                                Tiện nghi khác: ${service.descriptionOtherConvenience}<br>
                                Số tầng: ${service.numberOfFloors}
                            </c:when>
                            <c:otherwise>
                                <!-- Room -->
                                Dịch vụ miễn phí: ${service.freeServiceIncluded}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
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

<!-- Thêm jQuery và DataTables -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Khởi tạo DataTables -->
<script>
    $(document).ready(function () {
        $('#serviceTable').DataTable({
            "dom": 'flrtip',
            "lengthChange": true, // Hiển thị tùy chọn số lượng bản ghi
            "lengthMenu": [1, 5, 10, 25, 50], // Các tùy chọn số lượng bản ghi
            "pageLength": 5, // Mặc định hiển thị 5 bản ghi
            "language": {
                "paginate": {
                    "previous": "«",
                    "next": "»"
                },
                "info": "Hiển thị _START_ đến _END_ của _TOTAL_ dịch vụ",
                "emptyTable": "Không có dịch vụ nào để hiển thị",
                "search": "Tìm kiếm:",
                "lengthMenu": "Hiển thị _MENU_ dịch vụ"
            }
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>