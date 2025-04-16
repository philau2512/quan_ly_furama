<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .modal-content {
        border-radius: 10px;
    }
    .modal-header {
        background-color: #003366;
        color: white;
    }
    .modal-footer .btn-primary {
        background-color: #0059b3;
        border: none;
    }
    .modal-footer .btn-primary:hover {
        background-color: #003d80;
    }
</style>

<!-- Modal thông báo -->
<div class="modal fade" id="notificationModal" tabindex="-1" aria-labelledby="notificationModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="notificationModalLabel">Thông báo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="notificationModalBody">
                <!-- Nội dung thông báo sẽ được điền bằng JavaScript -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript để hiển thị modal -->
<script>
    // Hàm hiển thị modal với thông báo
    function showNotificationModal(message, type = 'success') {
        const modalBody = document.getElementById('notificationModalBody');
        const modalTitle = document.getElementById('notificationModalLabel');

        // Đặt nội dung thông báo
        modalBody.innerHTML = message;

        // Đặt tiêu đề và màu sắc dựa trên loại thông báo
        if (type === 'success') {
            modalTitle.innerHTML = 'Thành công';
            modalBody.className = 'modal-body text-success';
        } else if (type === 'error') {
            modalTitle.innerHTML = 'Lỗi';
            modalBody.className = 'modal-body text-danger';
        } else if (type === 'warning') {
            modalTitle.innerHTML = 'Cảnh báo';
            modalBody.className = 'modal-body text-warning';
        } else {
            modalTitle.innerHTML = 'Thông báo';
            modalBody.className = 'modal-body';
        }

        // Hiển thị modal
        const modal = new bootstrap.Modal(document.getElementById('notificationModal'));
        modal.show();
    }
</script>