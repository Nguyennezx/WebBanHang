<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
          *  { box-sizing: border-box; 
              margin: 0; 
              padding: 0; 
             }
        body { font-family: 'Segoe UI', sans-serif; 
               min-height: 100vh; 
               display: flex; 
               flex-direction: column; 
              }

       .topbar { background: #fff; 
                  padding: 10px 0; 
               }
        .topbar .logo { 
           font-size: 1.6rem; 
           font-weight: 800; 
                        color: #1a73e8;
                       text-decoration: none;
                       letter-spacing: -1px; 
                       }
        .topbar .logo span { color: #ffd54f; 
                           }
        .topbar .topbar-title {
            font-size: 1rem; 
            color: rgba(255,255,255,0.85);
            border-left: 1px solid rgba(255,255,255,0.4);
            padding-left: 16px; 
            margin-left: 16px;
            }
        .topbar .help-link { color: #0d47a1; text-decoration: none; font-size: 0.9rem; }
        .topbar .help-link:hover { text-decoration: underline; }

        .main-area {
            background: linear-gradient(135deg, #1a73e8 0%, #0d47a1 100%);
            flex: 1; display: flex; align-items: center; padding: 40px 0 60px;
        }

        .inner {
            display: flex; align-items: center; justify-content: space-between;
            width: 100%; max-width: 960px; margin: 0 auto; padding: 0 16px; gap: 32px;
        }

        .banner { flex: 1; color: #fff; padding-right: 16px; }
        .banner .icon { font-size: 7rem; display: block; margin-bottom: 16px; filter: drop-shadow(0 4px 12px rgba(0,0,0,0.2)); }
        .banner h2 { font-size: 2rem; font-weight: 700; margin-bottom: 8px; }
        .banner p { font-size: 1rem; opacity: 0.9; line-height: 1.6; }

        .card-box {
            background: #fff; border-radius: 4px; padding: 32px 32px 24px;
            width: 400px; flex-shrink: 0; box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .card-box h4 { font-size: 1.25rem; font-weight: 500; color: #333; margin-bottom: 8px; }
        .card-box .desc { font-size: 0.85rem; color: #888; margin-bottom: 20px; line-height: 1.5; }

        .card-box .form-control {
            border-radius: 2px; border: 1px solid #ddd; padding: 10px 14px; font-size: 0.9rem;
        }
        .card-box .form-control:focus { border-color: #1a73e8; box-shadow: 0 0 0 2px rgba(26,115,232,0.15); }

        .btn-main {
            background: #1a73e8; border: none; border-radius: 2px; padding: 11px;
            font-size: 0.95rem; font-weight: 600; color: #fff; width: 100%;
            text-transform: uppercase; letter-spacing: 0.5px; transition: background 0.2s; margin-top: 4px;
        }
        .btn-main:hover { background: #1557b0; color: #fff; }

        .bottom-link { text-align: center; font-size: 0.88rem; color: #999; margin-top: 16px; }
        .bottom-link a { color: #1a73e8; text-decoration: none; font-weight: 500; }
        .bottom-link a:hover { text-decoration: underline; }

        .alert { border-radius: 2px; font-size: 0.88rem; padding: 9px 12px; margin-bottom: 16px; }
        .form-label { font-size: 0.82rem; color: #555; margin-bottom: 4px; }

        /* Step indicator */
        .steps { display: flex; align-items: center; gap: 8px; margin-bottom: 20px; }
        .step {
            width: 28px; height: 28px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.8rem; font-weight: 700;
        }
        .step.active { background: #1a73e8; color: #fff; }
        .step.inactive { background: #e0e0e0; color: #999; }
        .step-line { flex: 1; height: 2px; background: #e0e0e0; }
        .step-label { font-size: 0.78rem; color: #999; }
        .step-label.active { color: #1a73e8; font-weight: 600; }
    </style>
</head>
<body>

<div class="topbar">
    <div class="container d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center">
            <a href="${pageContext.request.contextPath}/home" class="logo">Shop<span>NBH</span></a>
            <span class="topbar-title">Quên mật khẩu</span>
        </div>
        <a href="#" class="help-link">Bạn cần giúp đỡ?</a>
    </div>
</div>

<div class="main-area">
    <div class="inner">

        <!-- Banner trái -->
        <div class="banner">
            <i class="bi bi-shield-lock-fill icon"></i>
            <h2>Khôi phục mật khẩu</h2>
            <p>Nhập email đăng ký của bạn.<br>Chúng tôi sẽ gửi mã xác nhận về hộp thư.</p>
        </div>

        <!-- Form -->
        <div class="card-box">
            <h4>Quên mật khẩu</h4>
            <p class="desc">Nhập email của bạn để nhận mã OTP xác nhận</p>

            <!-- Step indicator -->
            <div class="steps">
                <div class="step active">1</div>
                <div class="step-line"></div>
                <div class="step inactive">2</div>
            </div>
            <div class="d-flex justify-content-between mb-3">
                <span class="step-label active">Nhập email</span>
                <span class="step-label">Đặt lại mật khẩu</span>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle me-1"></i> ${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/forgot-password/send-otp" method="post">
                <div class="mb-3">
                    <label class="form-label">Email đăng ký</label>
                    <input type="email" name="email" class="form-control"
                           placeholder="Nhập email của bạn"
                           value="${param.email}" required autofocus>
                </div>
                <button type="submit" class="btn-main">Gửi mã xác nhận</button>
            </form>

            <div class="bottom-link">
                <a href="${pageContext.request.contextPath}/login">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại đăng nhập
                </a>
            </div>
        </div>

    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
