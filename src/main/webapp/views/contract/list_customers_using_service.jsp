<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Danh sách khách hàng đang sử dụng dịch vụ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
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

        .btn-primary, .btn-warning, .btn-danger {
            margin: 0 5px;
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

        .dataTables_wrapper .dataTables_filter {
            margin-bottom: 15px;
        }

        .dataTables_wrapper .dataTables_length {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<c:import url="../../layout/header.jsp"/>

<div class="container">
    <div class="table-container">
        <h2>Danh sách khách hàng đang sử dụng dịch vụ</h2>
        <table id="customerTable" class="table table-striped table-bordered">
            <thead class="table-dark">
            <tr>
                <th>STT</th>
                <th>Mã khách hàng</th>
                <th>Tên khách hàng</th>
                <th>Số điện thoại</th>
                <th>Email</th>
                <th>Địa chỉ</th>
                <th>Dịch vụ chính</th>
                <th>Dịch vụ đính kèm</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="dto" items="${customerUsingServiceList}" varStatus="loop">
                <tr>
                    <td>${loop.count}</td>
                    <td>${dto.customer.customerId}</td>
                    <td>${dto.customer.customerName}</td>
                    <td>${dto.customer.customerPhone}</td>
                    <td>${dto.customer.customerEmail}</td>
                    <td>${dto.customer.customerAddress}</td>
                    <td>${dto.service.serviceName} (${dto.service.serviceType.serviceTypeName})</td>
                    <td>
                        <c:if test="${not empty dto.attachServices}">
                            <ul>
                                <c:forEach var="attachService" items="${dto.attachServices}">
                                    <li>${attachService.attachServiceName} (${attachService.attachServiceCost} VNĐ)</li>
                                </c:forEach>
                            </ul>
                        </c:if>
                        <c:if test="${empty dto.attachServices}">
                            Không có dịch vụ đính kèm
                        </c:if>
                    </td>
                    <td>
                        <a href="/service?action=edit&serviceId=${dto.service.serviceId}"
                           class="btn btn-warning btn-sm">Chỉnh sửa</a>
                        <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal"
                                data-bs-target="#deleteModal-${dto.service.serviceId}">
                            Xóa
                        </button>
                        <!-- Modal xác nhận xóa -->
                        <div class="modal fade" id="deleteModal-${dto.service.serviceId}" tabindex="-1"
                             aria-labelledby="deleteModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa dịch vụ</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        Bạn có chắc chắn muốn xóa dịch vụ "${dto.service.serviceName}" không?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy
                                        </button>
                                        <a href="/service?action=delete&serviceId=${dto.service.serviceId}"
                                           class="btn btn-danger">Xóa</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<c:import url="/views/common/notification-modal.jsp"/>
<script>
    <c:if test="${not empty message}">
    showNotificationModal('${message}', '${messageType != null ? messageType : "success"}');
    <% session.removeAttribute("message"); %>
    <% session.removeAttribute("messageType"); %>
    </c:if>
</script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function () {
        $('#customerTable').DataTable({
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.13.6/i18n/vi.json"
            },
            "pageLength": 10,
            "lengthMenu": [5, 10, 25, 50],
            "ordering": true,
            "searching": true,
            "paging": true
        });
    });
</script>
</body>
</html>