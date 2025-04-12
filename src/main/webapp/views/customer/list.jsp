<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Danh sách khách hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Thêm CSS của DataTables -->
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
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
        }
    </style>
</head>
<body>
<c:import url="../../layout/header.jsp"/>

<div class="container">
    <div class="table-container">
        <h2 class="text-center">Danh sách khách hàng</h2>

        <!-- Nút Thêm khách hàng -->
        <div class="mb-3">
            <a href="/customer?action=add" class="btn btn-primary"><i class="fas fa-plus"></i> Thêm khách hàng</a>
        </div>

        <!-- Bảng danh sách khách hàng -->
        <table id="customerTable" class="table table-striped table-bordered">
            <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Họ và tên</th>
                <th>Ngày sinh</th>
                <th>Giới tính</th>
                <th>Số CMND/CCCD</th>
                <th>Số điện thoại</th>
                <th>Email</th>
                <th>Địa chỉ</th>
                <th>Loại khách hàng</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="customer" items="${customerList}" varStatus="loop">
                <tr>
                    <td>${loop.count}</td>
                    <td>${customer.customerName}</td>
                    <td>${customer.customerBirthday}</td>
                    <td>${customer.customerGender ? 'Nam' : 'Nữ'}</td>
                    <td>${customer.customerIdCard}</td>
                    <td>${customer.customerPhone}</td>
                    <td>${customer.customerEmail}</td>
                    <td>${customer.customerAddress}</td>
                    <td>${customer.customerType.name}</td>
                    <td>
                        <div class="action-buttons">
                            <!-- Nút Sửa -->
                            <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#editModal"
                                    onclick="thongTinSua('${customer.customerId}', '${customer.customerName}', '${customer.customerBirthday}', '${customer.customerGender ? 'Nam' : 'Nữ'}', '${customer.customerIdCard}', '${customer.customerPhone}', '${customer.customerEmail}', '${customer.customerAddress}', '${customer.customerType.id}')">
                                <i class="fas fa-edit"></i> Sửa
                            </button>
                            <!-- Nút Xóa -->
                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal"
                                    onclick="thongTinXoa('${customer.customerId}', '${customer.customerName}')">
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
        <form action="/customer?action=delete" method="get">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" id="deleteId" name="id">
                    <span>Bạn có muốn xóa khách hàng </span><span id="deleteName"></span><span> không?</span>
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
        <form action="/customer?action=edit" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Chỉnh sửa khách hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" id="editId" name="customerId">

                    <div class="mb-3">
                        <label for="editName" class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>

                    <div class="mb-3">
                        <label for="editBirthday" class="form-label">Ngày sinh</label>
                        <input type="date" class="form-control" id="editBirthday" name="birthday" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Giới tính</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="editGenderMale" value="Nam">
                            <label class="form-check-label" for="editGenderMale">Nam</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="editGenderFemale" value="Nữ">
                            <label class="form-check-label" for="editGenderFemale">Nữ</label>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="editIdCard" class="form-label">Số CMND/CCCD</label>
                        <input type="text" class="form-control" id="editIdCard" name="idCard" required>
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
                        <label for="editType" class="form-label">Loại khách hàng</label>
                        <select class="form-select" id="editType" name="typeId" required>
                            <c:forEach var="type" items="${customerTypeList}">
                                <option value="${type.id}">${type.name}</option>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Hàm điền thông tin vào modal xóa
    function thongTinXoa(id, name) {
        document.getElementById("deleteId").value = id;
        document.getElementById("deleteName").innerText = name;
    }

    // Hàm điền thông tin vào modal sửa
    function thongTinSua(id, name, birthday, gender, idCard, phone, email, address, typeId) {
        document.getElementById("editId").value = id;
        document.getElementById("editName").value = name;
        document.getElementById("editBirthday").value = birthday;
        document.getElementById("editGenderMale").checked = (gender === "Nam");
        document.getElementById("editGenderFemale").checked = (gender === "Nữ");
        document.getElementById("editIdCard").value = idCard;
        document.getElementById("editPhone").value = phone;
        document.getElementById("editEmail").value = email;
        document.getElementById("editAddress").value = address;
        document.getElementById("editType").value = typeId;
    }
</script>

<!-- Khởi tạo DataTables -->
<script>
    $(document).ready(function () {
        $('#customerTable').DataTable({
            "dom": 'flrtip', // Ẩn thanh tìm kiếm mặc định của DataTables (vì đã có tìm kiếm trong header)
            "lengthChange": false, // Ẩn tùy chọn thay đổi số lượng bản ghi trên mỗi trang
            "pageLength": 5, // Số bản ghi trên mỗi trang
            "language": {
                "paginate": {
                    "previous": "«",
                    "next": "»"
                },
                "info": "Hiển thị _START_ đến _END_ của _TOTAL_ khách hàng",
                "emptyTable": "Không có khách hàng nào để hiển thị",
                "search": "Tìm kiếm:"
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