<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Danh sách nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Thêm CSS của DataTables -->
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <!-- Thêm CSS của FixedColumns -->
    <link href="https://cdn.datatables.net/fixedcolumns/4.0.1/css/fixedColumns.bootstrap5.min.css" rel="stylesheet">
    <style>
        body {
            background: #f0f2f5;
        }

        .container {
            margin-top: 40px;
        }

        .table-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
        }

        h2 {
            color: #003366;
            margin-bottom: 20px;
        }

        .btn-primary {
            background-color: #0059b3;
            border: none;
        }

        .btn-primary:hover {
            background-color: #004080;
        }

        .btn-danger {
            background-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .action-buttons {
            display: flex;
            gap: 5px;
            justify-content: center;
            width: 100px;
        }

        #employeeTable th,
        #employeeTable td {
            white-space: nowrap;
            padding: 8px;
            vertical-align: middle;
            text-align: left;
        }

        #employeeTable thead th {
            background-color: #003366 !important;
            color: white !important;
            font-weight: bold;
            padding: 12px;
            border-right: 1px solid #dee2e6;
        }

        #employeeTable td:last-child,
        #employeeTable th:last-child {
            text-align: center;
        }

        .dataTables_scrollBody {
            overflow-x: auto !important;
        }

        .dataTables_wrapper .dataTables_paginate {
            margin-top: 16px;
        }
    </style>
</head>
<body>
<c:import url="../../layout/header.jsp"/>

<div class="container">
    <div class="table-container">
        <h2 class="text-center">Danh sách nhân viên</h2>

        <!-- Nút Thêm nhân viên -->
        <div class="mb-3">
            <a href="/employee?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> Thêm nhân viên</a>
        </div>

        <!-- Hiển thị thông báo nếu danh sách rỗng -->
        <c:if test="${empty employeeList}">
            <div class="alert alert-warning text-center" role="alert">
                Không có nhân viên nào để hiển thị. Vui lòng thêm nhân viên mới.
            </div>
        </c:if>

        <!-- Bảng danh sách nhân viên -->
        <table id="employeeTable" class="table table-striped table-bordered nowrap w-100">
            <thead>
            <tr>
                <th>STT</th>
                <th>Họ và tên</th>
                <th>Ngày sinh</th>
                <th>Số CMND/CCCD</th>
                <th>Lương</th>
                <th>Số điện thoại</th>
                <th>Email</th>
                <th>Địa chỉ</th>
                <th>Vị trí</th>
                <th>Trình độ</th>
                <th>Bộ phận</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="employee" items="${employeeList}" varStatus="loop">
                <tr>
                    <td>${loop.count}</td>
                    <td>${employee.employeeName}</td>
                    <td>${employee.employeeBirthday}</td>
                    <td>${employee.employeeIdCard}</td>
                    <td><fmt:formatNumber value="${employee.employeeSalary}" type="number" groupingUsed="true"
                                          maxFractionDigits="0"/></td>
                    <td>${employee.employeePhone}</td>
                    <td>${employee.employeeEmail}</td>
                    <td>${employee.employeeAddress}</td>
                    <td>${employee.position.positionName}</td>
                    <td>${employee.educationDegree.educationDegreeName}</td>
                    <td>${employee.division.divisionName}</td>
                    <td>
                        <div class="action-buttons">
                            <!-- Nút Sửa -->
                            <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#editModal"
                                    onclick="thongTinSua('${employee.employeeId}', '${employee.employeeName}', '${employee.employeeBirthday}', '${employee.employeeIdCard}', '${employee.employeeSalary}', '${employee.employeePhone}', '${employee.employeeEmail}', '${employee.employeeAddress}', '${employee.position.positionId}', '${employee.educationDegree.educationDegreeId}', '${employee.division.divisionId}')">
                                <i class="fas fa-edit"></i> Sửa
                            </button>
                            <!-- Nút Xóa -->
                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal"
                                    onclick="thongTinXoa('${employee.employeeId}', '${employee.employeeName}')">
                                <i class="fas fa-trash-alt"></i> Xóa
                            </button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Import modal thông báo -->
<c:import url="/views/common/notification-modal.jsp"/>

<!-- Modal Xóa -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/employee?action=delete" method="get">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" id="deleteId" name="id">
                    <span>Bạn có muốn xóa nhân viên </span><span id="deleteName"></span><span> không?</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Modal Sửa -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/employee?action=edit" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Chỉnh sửa nhân viên</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" id="editId" name="employeeId">

                    <div class="mb-3">
                        <label for="editName" class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>

                    <div class="mb-3">
                        <label for="editBirthday" class="form-label">Ngày sinh</label>
                        <input type="date" class="form-control" id="editBirthday" name="birthday" required>
                    </div>

                    <div class="mb-3">
                        <label for="editIdCard" class="form-label">Số CMND/CCCD</label>
                        <input type="text" class="form-control" id="editIdCard" name="idCard" required>
                    </div>

                    <div class="mb-3">
                        <label for="editSalary" class="form-label">Lương</label>
                        <input type="number" class="form-control" id="editSalary" name="salary" required>
                    </div>

                    <div class="mb-3">
                        <label for="editPhone" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="editPhone" name="phone" required>
                    </div>

                    <div class="mb-3">
                        <label for="editEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="editEmail" name="email" required>
                    </div>

                    <div class="mb-3">
                        <label for="editAddress" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="editAddress" name="address" required>
                    </div>

                    <div class="mb-3">
                        <label for="editPosition" class="form-label">Vị trí</label>
                        <select class="form-select" id="editPosition" name="positionId" required>
                            <c:forEach var="position" items="${positionList}">
                                <option value="${position.positionId}">${position.positionName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="editEducationDegree" class="form-label">Trình độ</label>
                        <select class="form-select" id="editEducationDegree" name="educationDegreeId" required>
                            <c:forEach var="educationDegree" items="${educationDegreeList}">
                                <option value="${educationDegree.educationDegreeId}">${educationDegree.educationDegreeName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="editDivision" class="form-label">Bộ phận</label>
                        <select class="form-select" id="editDivision" name="divisionId" required>
                            <c:forEach var="division" items="${divisionList}">
                                <option value="${division.divisionId}">${division.divisionName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Thêm jQuery và DataTables -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<!-- Thêm JS của FixedColumns -->
<script src="https://cdn.datatables.net/fixedcolumns/4.0.1/js/dataTables.fixedColumns.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Hàm điền thông tin vào modal xóa
    function thongTinXoa(id, name) {
        document.getElementById("deleteId").value = id;
        document.getElementById("deleteName").innerText = name;
    }

    // Hàm điền thông tin vào modal sửa
    function thongTinSua(id, name, birthday, idCard, salary, phone, email, address, positionId, educationDegreeId, divisionId) {
        document.getElementById("editId").value = id;
        document.getElementById("editName").value = name;
        document.getElementById("editBirthday").value = birthday;
        document.getElementById("editIdCard").value = idCard;
        document.getElementById("editSalary").value = salary;
        document.getElementById("editPhone").value = phone;
        document.getElementById("editEmail").value = email;
        document.getElementById("editAddress").value = address;
        document.getElementById("editPosition").value = positionId;
        document.getElementById("editEducationDegree").value = educationDegreeId;
        document.getElementById("editDivision").value = divisionId;
    }
</script>

<!-- Khởi tạo DataTables -->
<script>
    $(document).ready(function () {
        $('#employeeTable').DataTable({
            "dom": 'flrtip', // Ẩn thanh tìm kiếm mặc định của DataTables (vì đã có tìm kiếm trong header)

            "lengthChange": true, // Hiển thị tùy chọn số lượng bản ghi
            "lengthMenu": [1, 5, 10, 25, 50], // Các tùy chọn số lượng bản ghi
            "pageLength": 5, // Mặc định hiển thị 5 bản ghi
            "language": {
                "paginate": {
                    "previous": "«",
                    "next": "»"
                },
                "info": "Hiển thị _START_ đến _END_ của _TOTAL_ nhân viên",
                "emptyTable": "Không có khách hàng nào để hiển thị",
                "search": "Tìm kiếm:",
                "lengthMenu": "Hiển thị _MENU_ nhân viên"
            }
        });
    });
</script>

<!-- Script hiển thị modal thông báo -->
<script>
    // Gọi trực tiếp thay vì dùng window.onload để tránh xung đột với DataTables
    <c:if test="${not empty message}">
    showNotificationModal('${message}', '${messageType != null ? messageType : "success"}');
    <% session.removeAttribute("message"); %>
    <% session.removeAttribute("messageType"); %>
    </c:if>
</script>
</body>
</html>