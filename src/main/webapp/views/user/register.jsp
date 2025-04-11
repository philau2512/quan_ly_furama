<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up - Furama Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('https://cdn.pixabay.com/photo/2020/01/09/15/54/sea-4753135_1280.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .signup-box {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 12px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
        }
        .signup-box h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #003366;
        }
        .form-control {
            border-radius: 8px;
        }
        .btn-primary {
            width: 100%;
            border-radius: 8px;
            background-color: #0059b3;
            border: none;
        }
        .btn-primary:hover {
            background-color: #003d80;
        }
        .text-link {
            text-align: center;
            margin-top: 15px;
        }
        .text-link a {
            text-decoration: none;
            color: #0059b3;
        }
        .text-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="signup-box">
    <h2>Đăng ký tài khoản</h2>
    <form action="signup" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Tên đăng nhập</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Mật khẩu</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Bạn là</label>
            <select class="form-select" id="role" name="role" required>
                <option value="">-- Chọn vai trò --</option>
                <option value="Employee">Nhân viên</option>
                <option value="Customer">Khách hàng</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Đăng ký</button>
        <div class="text-link">
            <p>Đã có tài khoản? <a href="login">Đăng nhập</a></p>
        </div>
    </form>
</div>
</body>
</html>
