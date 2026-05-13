<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            min-height: 100vh;
            background: #f0f2f5;
            display: flex;
            flex-direction: column;
            font-family: 'Segoe UI', sans-serif;
        }

        .main-content {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 15px;
        }

        .login-wrapper {
            display: flex;
            width: 880px;
            min-height: 520px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.10);
            overflow: hidden;
        }

        /* Cột trái - banner */
        .login-banner {
            width: 45%;
            background: linear-gradient(135deg, #1a73e8 0%, #0d47a1 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 32px;
            color: #fff;
        }

        .login-banner .logo {
            font-size: 2rem;
            font-weight: 700;
            letter-spacing: -1px;
            margin-bottom: 12px;
        }

        .login-banner .logo span {
            color: #ffd54f;
        }

        .login-banner p {
            font-size: 0.95rem;
            opacity: 0.85;
            text-align: center;
            line-height: 1.6;
        }

        .login-banner .banner-icon {
            font-size: 5rem;
            margin-bottom: 24px;
            opacity: 0.9;
        }

        /* Cột phải - form */
        .login-form-area {
            width: 55%;
            padding: 48px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-form-area h4 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-bottom: 6px;
        }

        .login-form-area .subtitle {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 28px;
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: #444;
            margin-bottom: 6px;
        }

        .input-group .form-control {
            border-right: none;
            border-radius: 8px 0 0 8px;
            padding: 10px 14px;
            font-size: 0.95rem;
            border-color: #dee2e6;
        }

        .input-group .form-control:focus {
            box-shadow: none;
            border-color: #1a73e8;
        }

        .input-group .input-group-text {
            background: #fff;
            border-left: none;
            border-radius: 0 8px 8px 0;
            border-color: #dee2e6;
            cursor: pointer;
            color: #6c757d;
        }

        .input-group:focus-within .input-group-text {
            border-color: #1a73e8;
        }

        .btn-login {
            background: #1a73e8;
            border: none;
            border-radius: 8px;
            padding: 11px;
            font-size: 1rem;
            font-weight: 600;
            color: #fff;
            width: 100%;
            margin-top: 8px;
            transition: background 0.2s;
        }

        .btn-login:hover {
            background: #1557b0;
            color: #fff;
        }

        .divider {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 20px 0;
            color: #aaa;
            font-size: 0.82rem;
        }

        .divider::before, .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #e0e0e0;
        }

        .footer-links {
            text-align: center;
            font-size: 0.87rem;
            color: #6c757d;
            margin-top: 16px;
        }

        .footer-links a {
            color: #1a73e8;
            text-decoration: none;
            font-weight: 500;
        }

        .footer-links a:hover { text-decoration: underline; }

        .alert {
            border-radius: 8px;
            font-size: 0.9rem;
            padding: 10px 14px;
            margin-bottom: 18px;
        }

        /* Footer */
        .site-footer {
            background: #fff;
            padding: 40px 0 20px;
            border-top: 1px solid #e0e0e0;
            font-size: 0.85rem;
            color: #6c757d;
        }
        .site-footer h5 {
            font-size: 1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 16px;
        }
        .site-footer ul {
            list-style: none;
            padding: 0;
        }
        .site-footer ul li {
            margin-bottom: 10px;
        }
        .site-footer ul li a {
            color: #6c757d;
            text-decoration: none;
            transition: color 0.2s;
        }
        .site-footer ul li a:hover {
            color: #1a73e8;
        }
        .footer-bottom {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
            text-align: center;
            font-size: 0.8rem;
        }
    </style>
</head>
<body>

<div class="main-content">
<div class="login-wrapper">

    <!-- Banner trái -->
    <div class="login-banner">
        <div class="banner-icon"><i class="bi bi-bag-heart-fill"></i></div>
        <div class="logo">Shop<span>HBN</span></div>
        <p>Mua sắm dễ dàng, giao hàng nhanh chóng.<br>Hàng ngàn sản phẩm chờ bạn khám phá.</p>
    </div>

    <!-- Form phải -->
    <div class="login-form-area">
        <h4>Chào mừng trở lại!</h4>
        <p class="subtitle">Đăng nhập để tiếp tục mua sắm</p>

        <!-- Thông báo đăng ký thành công -->
        <c:if test="${not empty param.registerSuccess}">
            <div class="alert alert-success">
                <i class="bi bi-check-circle me-1"></i> Đăng ký thành công! Vui lòng đăng nhập.
            </div>
        </c:if>

        <!-- Thông báo reset mật khẩu thành công -->
        <c:if test="${not empty param.resetSuccess}">
            <div class="alert alert-success">
                <i class="bi bi-check-circle me-1"></i> Đặt lại mật khẩu thành công!
            </div>
        </c:if>

        <!-- Lỗi đăng nhập -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-circle me-1"></i> ${error}
            </div>
        </c:if>

        <!-- Form đăng nhập -->
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label class="form-label">Tên đăng nhập</label>
                <div class="input-group">
                    <input type="text" name="username" class="form-control"
                           placeholder="Nhập tên đăng nhập" required autofocus>
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                </div>
            </div>

            <div class="mb-2">
                <label class="form-label">Mật khẩu</label>
                <div class="input-group">
                    <input type="password" name="password" id="passwordInput"
                           class="form-control" placeholder="Nhập mật khẩu" required>
                    <span class="input-group-text" onclick="togglePassword()">
                        <i class="bi bi-eye" id="eyeIcon"></i>
                    </span>
                </div>
            </div>

            <div class="text-end mb-3">
                <a href="${pageContext.request.contextPath}/forgot-password"
                   style="font-size:0.85rem; color:#1a73e8; text-decoration:none;">
                    Quên mật khẩu?
                </a>
            </div>

            <button type="submit" class="btn-login">
                <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
            </button>
        </form>

        <div class="divider">hoặc</div>

        <div class="footer-links">
            Chưa có tài khoản?
            <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
        </div>
    </div>
</div>
</div>

<footer class="site-footer">
    <div class="container">
        <div class="row">
            <div class="col-md-3 mb-4">
                <h5>Chăm sóc khách hàng</h5>
                <ul>
                    <li><a href="#">Trung Tâm Trợ Giúp</a></li>
                    <li><a href="#">Hướng Dẫn Mua Hàng</a></li>
                    <li><a href="#">Chính Sách Vận Chuyển</a></li>
                    <li><a href="#">Trả Hàng & Hoàn Tiền</a></li>
                </ul>
            </div>
            <div class="col-md-3 mb-4">
                <h5>Về ShopHBN</h5>
                <ul>
                    <li><a href="#">Giới Thiệu</a></li>
                    <li><a href="#">Tuyển Dụng</a></li>
                    <li><a href="#">Điều Khoản ShopHBN</a></li>
                    <li><a href="#">Chính Sách Bảo Mật</a></li>
                </ul>
            </div>
            <div class="col-md-3 mb-4">
                <h5>Thanh toán</h5>
                <div class="d-flex gap-2 mb-3">
                    <i class="bi bi-credit-card fs-3" title="Thẻ tín dụng/ghi nợ"></i>
                    <i class="bi bi-wallet2 fs-3" title="Ví điện tử"></i>
                    <i class="bi bi-cash-coin fs-3" title="Thanh toán khi nhận hàng"></i>
                </div>
                <h5>Theo dõi chúng tôi trên</h5>
                <div class="d-flex gap-3">
                    <a href="#" class="text-secondary fs-4" title="Facebook"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-secondary fs-4" title="Instagram"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-secondary fs-4" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <h5>Tải ứng dụng ngay</h5>
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-qr-code text-secondary" style="font-size: 4rem;"></i>
                    <div class="d-flex flex-column gap-2">
                        <button class="btn btn-outline-secondary btn-sm text-start" style="width: 120px;">
                            <i class="bi bi-apple"></i> App Store
                        </button>
                        <button class="btn btn-outline-secondary btn-sm text-start" style="width: 120px;">
                            <i class="bi bi-google-play"></i> Google Play
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            &copy; 2026 ShopHBN. Tất cả các quyền được bảo lưu.
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function togglePassword() {
        const input = document.getElementById('passwordInput');
        const icon  = document.getElementById('eyeIcon');
        if (input.type === 'password') {
            input.type = 'text';
            icon.className = 'bi bi-eye-slash';
        } else {
            input.type = 'password';
            icon.className = 'bi bi-eye';
        }
    }
</script>
</body>
</html>
