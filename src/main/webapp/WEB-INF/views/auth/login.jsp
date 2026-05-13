<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }

        .topbar {
            background: #fff;
            padding: 10px 0;
        }
        .topbar .logo {
            font-size: 2rem;
            font-weight: 800;
            color: #1a73e8;
            text-decoration: none;
            letter-spacing: -1px;
            display: flex;
            align-items: center;
        }
        .topbar .logo span { color: #ffd54f; }
        .topbar .topbar-title {
            font-size: 1rem; color: rgba(255,255,255,0.85);
            border-left: 1px solid rgba(255,255,255,0.4);
            padding-left: 16px; margin-left: 16px;
        }
        .topbar .help-link { 
           color: #0d47a1; 
           text-decoration: none; 
           font-size: 0.9rem; }
        .topbar .help-link:hover { text-decoration: underline; }

        .login-main {
            background: linear-gradient(135deg, #1a73e8 0%, #0d47a1 100%);
            flex: 1; display: flex; align-items: center; padding: 40px 0 60px;
        }

        .login-inner {
            display: flex; align-items: center;
            justify-content: space-between;
            width: 100%; max-width: 960px;
            margin: 0 auto; padding: 0 16px; gap: 32px;
        }

        .login-banner { flex: 1; color: #fff; padding-right: 16px; }
        .login-banner .bag-icon {
            font-size: 7rem; display: block; margin-bottom: 16px;
            filter: drop-shadow(0 4px 12px rgba(0,0,0,0.2));
        }
        .login-banner h2 { font-size: 2rem; font-weight: 700; margin-bottom: 8px; }
        .login-banner p { font-size: 1rem; opacity: 0.9; line-height: 1.6; }

        .login-card {
            background: #fff; border-radius: 4px;
            padding: 32px 32px 24px; width: 380px;
            flex-shrink: 0; box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .login-card h4 { font-size: 1.25rem; font-weight: 500; color: #333; margin-bottom: 24px; }

        .login-card .form-control {
            border-radius: 2px; border: 1px solid #ddd;
            padding: 10px 14px; font-size: 0.95rem;
        }
        .login-card .form-control:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 0 2px rgba(26,115,232,0.15);
        }

        .pw-wrapper { position: relative; }
        .pw-wrapper .form-control { padding-right: 42px; }
        .pw-toggle {
            position: absolute; right: 12px; top: 50%;
            transform: translateY(-50%); color: #999; cursor: pointer;
        }

        .forgot-link { font-size: 0.82rem; color: #1a73e8; text-decoration: none; }
        .forgot-link:hover { text-decoration: underline; }

        .btn-login {
            background: #1a73e8; border: none; border-radius: 2px;
            padding: 11px; font-size: 0.95rem; font-weight: 600;
            color: #fff; width: 100%; text-transform: uppercase;
            letter-spacing: 0.5px; transition: background 0.2s;
        }
        .btn-login:hover { background: #1557b0; color: #fff; }

        .divider-text {
            display: flex; align-items: center; gap: 10px;
            color: #ccc; font-size: 0.82rem; margin: 16px 0;
        }
        .divider-text::before, .divider-text::after { content: ''; flex: 1; height: 1px; background: #efefef; }

        .register-link { text-align: center; font-size: 0.88rem; color: #999; }
        .register-link a { color: #1a73e8; text-decoration: none; font-weight: 500; }
        .register-link a:hover { text-decoration: underline; }

        .alert { border-radius: 2px; font-size: 0.88rem; padding: 9px 12px; margin-bottom: 16px; }
    </style>
</head>
<body>

<div class="topbar">
    <div class="container d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center">
            <a href="${pageContext.request.contextPath}/home" class="logo">Shop<span>NBH</span></a>
            <span class="topbar-title">Đăng nhập</span>
        </div>
        <a href="#" class="help-link">Bạn cần giúp đỡ?</a>
    </div>
</div>

<div class="login-main">
    <div class="login-inner">
        <div class="login-banner">
            <i class="bi bi-bag-heart-fill bag-icon"></i>
            <h2>ShopNBH</h2>
            <p>Nền tảng mua sắm trực tuyến<br>uy tín, giá tốt, giao hàng nhanh</p>
        </div>

        <div class="login-card">
            <h4>Đăng nhập</h4>

            <c:if test="${not empty param.registerSuccess}">
                <div class="alert alert-success"><i class="bi bi-check-circle me-1"></i> Đăng ký thành công!</div>
            </c:if>
            <c:if test="${not empty param.resetSuccess}">
                <div class="alert alert-success"><i class="bi bi-check-circle me-1"></i> Đặt lại mật khẩu thành công!</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle me-1"></i> ${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-3">
                    <input type="text" name="username" class="form-control"
                           placeholder="Tên đăng nhập" required autofocus>
                </div>
                <div class="mb-2">
                    <div class="pw-wrapper">
                        <input type="password" name="password" id="passwordInput"
                               class="form-control" placeholder="Mật khẩu" required>
                        <span class="pw-toggle" onclick="togglePassword()">
                            <i class="bi bi-eye" id="eyeIcon"></i>
                        </span>
                    </div>
                </div>
                <div class="text-end mb-3">
                    <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-link">Quên mật khẩu?</a>
                </div>
                <button type="submit" class="btn-login">Đăng nhập</button>
            </form>

            <div class="divider-text">HOẶC</div>
            <div class="register-link">
                Bạn mới biết đến ShopNBH?
                <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    function togglePassword() {
        const input = document.getElementById('passwordInput');
        const icon  = document.getElementById('eyeIcon');
        input.type  = input.type === 'password' ? 'text' : 'password';
        icon.className = input.type === 'text' ? 'bi bi-eye-slash' : 'bi bi-eye';
    }
</script>
</body>
</html>
