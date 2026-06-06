<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - ShopNBH</title>
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

        .register-main {
            background: linear-gradient(135deg, #1a73e8 0%, #0d47a1 100%);
            flex: 1; display: flex; align-items: center; padding: 40px 0 60px;
        }

        .register-inner {
            display: flex; align-items: center;
            justify-content: space-between;
            width: 100%; max-width: 960px;
            margin: 0 auto; padding: 0 16px; gap: 32px;
        }

        .register-banner { flex: 1; color: #fff; padding-right: 16px; }
        .register-banner .bag-icon {
            font-size: 7rem; display: block; margin-bottom: 16px;
            filter: drop-shadow(0 4px 12px rgba(0,0,0,0.2));
        }
        .register-banner h2 { font-size: 2rem; font-weight: 700; margin-bottom: 8px; }
        .register-banner p { font-size: 1rem; opacity: 0.9; line-height: 1.6; }

        .register-card {
            background: #fff; border-radius: 4px;
            padding: 32px 32px 24px; width: 420px;
            flex-shrink: 0; box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .register-card h4 { font-size: 1.25rem; font-weight: 500; color: #333; margin-bottom: 20px; }

        .register-card .form-control {
            border-radius: 2px; border: 1px solid #ddd;
            padding: 10px 14px; font-size: 0.9rem;
        }
        .register-card .form-control:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 0 2px rgba(26,115,232,0.15);
        }
        .register-card .form-control.is-invalid { border-color: #dc3545; }

        .pw-wrapper { position: relative; }
        .pw-wrapper .form-control { padding-right: 42px; }
        .pw-toggle {
            position: absolute; right: 12px; top: 50%;
            transform: translateY(-50%); color: #999; cursor: pointer;
        }

        .btn-register {
            background: #1a73e8; border: none; border-radius: 2px;
            padding: 11px; font-size: 0.95rem; font-weight: 600;
            color: #fff; width: 100%; text-transform: uppercase;
            letter-spacing: 0.5px; transition: background 0.2s; margin-top: 4px;
        }
        .btn-register:hover { background: #1557b0; color: #fff; }

        .login-link { text-align: center; font-size: 0.88rem; color: #999; margin-top: 16px; }
        .login-link a { color: #1a73e8; text-decoration: none; font-weight: 500; }
        .login-link a:hover { text-decoration: underline; }

        .alert { border-radius: 2px; font-size: 0.88rem; padding: 9px 12px; margin-bottom: 16px; }
        .form-label { font-size: 0.82rem; color: #555; margin-bottom: 4px; }
    </style>
</head>
<body>

<div class="topbar">
    <div class="container d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center">
            <a href="${pageContext.request.contextPath}/home" class="logo">Shop<span>NBH</span></a>
            <span class="topbar-title">Đăng ký</span>
        </div>
        <a href="#" class="help-link">Bạn cần giúp đỡ?</a>
    </div>
</div>

<div class="register-main">
    <div class="register-inner">

        <!-- Banner trái -->
        <div class="register-banner">
            <i class="bi bi-bag-heart-fill bag-icon"></i>
            <h2>ShopNBH</h2>
            <p>Tạo tài khoản miễn phí<br>Mua sắm dễ dàng, giao hàng nhanh chóng</p>
        </div>

        <!-- Form đăng ký -->
        <div class="register-card">
            <h4>Đăng ký</h4>

            <c:if test="${not empty error}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle me-1"></i> ${error}</div>
            </c:if>
            <c:if test="${not empty validationErrors}">
                  <div class="alert alert-danger">
                   <c:forEach items="${validationErrors}" var="err">
                  <div>${err.defaultMessage}</div>
             </c:forEach>

    </div>
</c:if>

            <form action="${pageContext.request.contextPath}/register" method="post">

                <div class="mb-3">
                    <label class="form-label">Họ và tên</label>
                    <input type="text" name="fullName" class="form-control"
                           placeholder="Nhập họ và tên" value="${param.fullName}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Tên đăng nhập</label>
                    <input type="text" name="userName" class="form-control"
                           placeholder="Nhập tên đăng nhập" value="${param.userName}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control"
                           placeholder="Nhập email" value="${param.email}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                    <input type="text" name="phone" class="form-control"
                           placeholder="Nhập số điện thoại" value="${param.phone}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mật khẩu</label>
                    <div class="pw-wrapper">
                        <input type="password" name="password" id="pw1"
                               class="form-control" placeholder="Tối thiểu 6 ký tự" required>
                        <span class="pw-toggle" onclick="togglePw('pw1','eye1')">
                            <i class="bi bi-eye" id="eye1"></i>
                        </span>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Xác nhận mật khẩu</label>
                    <div class="pw-wrapper">
                        <input type="password" name="confirmPassword" id="pw2"
                               class="form-control" placeholder="Nhập lại mật khẩu" required>
                        <span class="pw-toggle" onclick="togglePw('pw2','eye2')">
                            <i class="bi bi-eye" id="eye2"></i>
                        </span>
                    </div>
                </div>

                <button type="submit" class="btn-register">Đăng ký</button>
            </form>

            <div class="login-link">
                Bạn đã có tài khoản?
                <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
            </div>
        </div>

    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    function togglePw(inputId, iconId) {
        const input = document.getElementById(inputId);
        const icon  = document.getElementById(iconId);
        input.type  = input.type === 'password' ? 'text' : 'password';
        icon.className = input.type === 'text' ? 'bi bi-eye-slash' : 'bi bi-eye';
    }
</script>
</body>
</html>
