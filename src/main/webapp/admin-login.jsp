<%--
  Created by IntelliJ IDEA.
  User: pethu
  Date: 3/5/2025
  Time: 2:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Login - MegaCab</title>
  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome Icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary: #FF6B00;
      --primary-dark: #E55A00;
      --secondary: #2C3E50;
      --light: #F8F9FA;
      --dark: #1A1A1A;
      --gray: #6C757D;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background-color: var(--light);
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
      overflow: hidden;
    }

    .admin-login-container {
      display: flex;
      width: 900px;
      height: 600px;
      background-color: white;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      border-radius: 15px;
      overflow: hidden;
    }

    .admin-login-left {
      flex: 1;
      background-color: #f9f4ef;
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 40px;
      position: relative;
    }

    .admin-login-right {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 40px;
    }

    .admin-login-logo {
      display: flex;
      align-items: center;
      margin-bottom: 30px;
    }

    .admin-login-logo img {
      height: 50px;
      margin-right: 10px;
    }

    .admin-login-logo span {
      font-family: 'Montserrat', sans-serif;
      font-weight: 800;
      font-size: 1.8rem;
      color: var(--secondary);
    }

    .admin-login-logo span em {
      color: var(--primary);
      font-style: normal;
    }

    .admin-login-headline {
      margin-bottom: 30px;
    }

    .admin-login-headline h1 {
      font-size: 2.5rem;
      margin-bottom: 15px;
      color: var(--secondary);
    }

    .admin-login-headline h1 span {
      color: var(--primary);
    }

    .admin-login-form {
      width: 100%;
      max-width: 400px;
    }

    .form-floating {
      margin-bottom: 20px;
    }

    .form-control {
      border-radius: 10px;
      padding: 15px 20px;
      height: 60px;
      border: 1px solid #e1e5ea;
      background-color: #f9fafb;
      transition: all 0.3s ease;
    }

    .form-control:focus {
      box-shadow: none;
      border-color: var(--primary);
      background-color: white;
    }

    .btn-primary {
      background-color: var(--primary);
      border: none;
      color: white;
      font-weight: 600;
      padding: 12px 25px;
      border-radius: 50px;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(255, 107, 0, 0.3);
    }

    .btn-primary:hover {
      background-color: var(--primary-dark);
      transform: translateY(-2px);
    }

    .admin-illustration {
      position: absolute;
      bottom: -10%;
      right: -10%;
      width: 400px;
      opacity: 0.5;
      z-index: 0;
    }

    .alert {
      position: relative;
      padding: 0;
      margin-bottom: 20px;
      background: none;
      border: none;
      opacity: 0;
      visibility: hidden;
      transition: opacity 0.3s ease, visibility 0.3s ease;
    }

    .alert.show {
      opacity: 1;
      visibility: visible;
    }

    .alert-danger {
      color: transparent;
    }

    .alert.show.alert-danger {
      color: var(--primary);
    }

    .alert-content {
      display: flex;
      align-items: center;
      padding: 10px 15px;
      position: relative;
    }

    .alert-content i {
      opacity: 0;
      transform: scale(0.5);
      transition: opacity 0.3s ease, transform 0.3s ease;
      margin-right: 10px;
    }

    .alert.show .alert-content i {
      opacity: 1;
      transform: scale(1);
    }

    .alert-content::before {
      content: '';
      position: absolute;
      left: 0;
      top: 50%;
      transform: translateY(-50%) scale(0.5);
      width: 6px;
      height: 6px;
      border-radius: 50%;
      background-color: transparent;
      opacity: 0;
      transition: all 0.3s ease;
    }

    .alert.show.alert-danger .alert-content::before {
      background-color: var(--primary);
      opacity: 1;
      transform: translateY(-50%) scale(1);
    }

    @media (max-width: 991px) {
      .admin-login-container {
        flex-direction: column;
        height: auto;
        width: 90%;
        max-width: 500px;
      }

      .admin-login-left, .admin-login-right {
        width: 100%;
        padding: 30px 20px;
      }

      .admin-illustration {
        width: 250px;
        right: -10%;
        bottom: -15%;
      }
    }
  </style>
</head>
<body>
<div class="admin-login-container">
  <!-- Left side - Welcome and Illustration -->
  <div class="admin-login-left">
    <div class="admin-login-logo">
      <img src="Assets/images/megacab-logo.svg" alt="MegaCab Logo">
      <span>Mega<em>Cab</em></span>
    </div>
    <div class="admin-login-headline">
      <h1>Admin <span>Dashboard</span></h1>
      <p class="text-muted">Manage your MegaCab system with precision and ease</p>
    </div>
  </div>

  <!-- Right side - Login Form -->
  <div class="admin-login-right">
    <form action="admin-login" method="post" class="admin-login-form">
      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
        <label for="username"><i class="fas fa-user me-2"></i>Username</label>
      </div>

      <div class="form-floating mb-3">
        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
        <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
      </div>

      <!-- Error Message -->
      <c:if test="${not empty param.error}">
        <div class="alert alert-danger show">
          <div class="alert-content">
            <i class="fas fa-exclamation-circle"></i>${param.error}
          </div>
        </div>
      </c:if>

      <button type="submit" class="btn btn-primary w-100">
        <i class="fas fa-sign-in-alt me-2"></i>Login as Admin
      </button>
    </form>
  </div>
</div>
</body>
</html>