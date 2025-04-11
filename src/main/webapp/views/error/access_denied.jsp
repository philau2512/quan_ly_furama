<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Access Denied</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .message-box {
            text-align: center;
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .message-box h1 {
            font-size: 2.5rem;
            color: #dc3545;
            margin-bottom: 20px;
        }
        .message-box p {
            font-size: 1.2rem;
            color: #333;
        }
        .btn-home {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="message-box">
    <h1>Access Denied</h1>
    <p>You do not have permission to do this action!</p>
    <a href="/home" class="btn btn-primary btn-home">Go to Home</a>
</div>
</body>
</html>