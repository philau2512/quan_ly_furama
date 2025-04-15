<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Danh sách hợp đồng</title>
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
        <h2>Danh sách hợp đồng</h2>
        <div class="mb-3 text-end">
            <a href="/contract?action=add" class="btn btn-primary">Thêm hợp đồng mới</a>
        </div>
        <table id="contractTable" class="table table-striped table-bordered">
            <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Mã hợp đồng</th>
                <th>Ngày bắt đầu</th>
                <th>Ngày kết thúc</th>
                <th>Tiền cọc (VNĐ)</th>
                <th>Tổng tiền (VNĐ)</th>
                <th>Nhân viên</th>
                <th>Khách hàng</th>
                <th>Dịch vụ</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="contract" items="${contractList}" varStatus="loop">
                <tr>
                    <td>${loop.count}</td>
                    <td>${contract.contractId}</td>
                    <td>${contract.getFormattedStartDate()}</td>
                    <td>${contract.getFormattedEndDate()}</td>
                    <td><fmt:formatNumber value="${contract.contractDeposit}" type="currency"
                                          currencySymbol="VNĐ"/></td>
                    <td><fmt:formatNumber value="${contract.contractTotalMoney}" type="currency"
                                          currencySymbol="VNĐ"/></td>
                    <td>${contract.employee.employeeName}</td>
                    <td>${contract.customer.customerName}</td>
                    <td>${contract.service.serviceName} (${contract.service.serviceType.serviceTypeName})</td>
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
        $('#contractTable').DataTable({
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