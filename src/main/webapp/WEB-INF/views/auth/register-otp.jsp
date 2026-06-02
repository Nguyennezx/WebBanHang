<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận email - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .topbar { background: #fff; padding: 10px 0; border-bottom: 1px solid #f0f0f0; }
        .topbar .logo {
            font-size: 1.6rem; font-weight: 800; color: #1a73e8;
            text-decoration: none; letter-spacing: -1px;
        }
        .topbar .logo span { color: #ffd54f; }
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
        .banner .icon {
            font-size: 7rem; display: block; margin-bottom: 16px;
            filter: drop-shadow(0 4px 12px rgba(0,0,0,0.2));
        }
        .banner h2 { font-size: 2rem; font-weight: 700; margin-bottom: 8px; }
        .banner p { font-size: 1rem; opacity: 0.9; line-height: 1.6; }

        .card-box {
            background: #fff; border-radius: 4px;
            padding: 32px 32px 24px; width: 400px;
            flex-shrink: 0; box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .card-box h4 { font-size: 1.25rem; font-weight: 500; color: #333; margin-bottom: 8px; }
        .card-box .desc { font-size: 0.85rem; color: #888; margin-bottom: 20px; line-height: 1.5; }

        .steps { display: flex; align-items: center; gap: 8px; margin-bottom: 8px; }
        .step {
            width: 28px; height: 28px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.8rem; font-weight: 700;
        }
        .step.done   { background: #43a047; color: #fff; }
        .step.active { background: #1a73e8; color: #fff; }
        .step-line   { flex: 1; height: 2px; background: #1a73e8; }
        .step-label  { font-size: 0.78rem; color: #999; }
        .step-label.done   { color: #43a047; }
        .step-label.active { color: #1a73e8; font-weight: 600; }

        .email-hint {
            background: #e8f0fe; border-radius: 4px;
            padding: 8px 12px; font-size: 0.82rem;
            color: #1a73e8; margin-bottom: 16px;
        }

        .card-box .form-control {
            border-radius: 2px; border: 1px solid #ddd;
            padding: 10px 14px; font-size: 0.9rem;
        }
        .card-box .form-control:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 0 2px rgba(26,115,232,0.15);
        }

        .otp-input {
            font-size: 1.6rem !important; font-weight: 700 !important;
            letter-spacing: 10px; text-align: center;
        }

        .countdown { font-size: 0.82rem; color: #888; text-align: center; margin-top: 8px; }
        .countdown .time { color: #1a73e8; font-weight: 600; }
        .countdown .time.expired { color: #dc3545; }

   
        .btn-main {
            background: #1a73e8; border: none; border-radius: 2px;
            padding: 11px; font-size: 0.95rem; font-weight: 600;
            color: #fff; width: 100%; text-transform: uppercase;
            letter-spacing: 0.5px; transition: background 0.2s; margin-top: 4px;
        }
        .btn-main:hover { background: #1557b0; color: #fff; }
        .btn-main:disabled { background: #9ec4f8; cursor: not-allowed; }

        .btn-resend {
            background: transparent; border: 1px solid #1a73e8;
            border-radius: 2px; padding: 9px; font-size: 0.88rem;
            font-weight: 600; color: #1a73e8; width: 100%;
            letter-spacing: 0.3px; transition: all 0.2s; margin-top: 8px;
            cursor: pointer;
        }
        .btn-resend:hover:not(:disabled) { background: #e8f0fe; }
        .btn-resend:disabled { color: #9ca3af; border-color: #d1d5db; cursor: not-allowed; }

        .bottom-link { text-align: center; font-size: 0.88rem; color: #999; margin-top: 16px; }
        .bottom-link a { color: #1a73e8; text-decoration: none; font-weight: 500; }
        .bottom-link a:hover { text-decoration: underline; }

        .alert { border-radius: 2px; font-size: 0.88rem; padding: 9px 12px; margin-bottom: 16px; }
        .form-label { font-size: 0.82rem; color: #555; margin-bottom: 4px; }
        .alert-info-custom {
            background: #e8f0fe; border: 1px solid #c5d8fb;
            color: #1a56db; border-radius: 4px;
            padding: 9px 12px; font-size: 0.85rem; margin-bottom: 16px;
        }
    </style>
</head>
<body>

<div class="topbar">
    <div class="container d-flex align-items-center justify-content-between">
        <a href="${pageContext.request.contextPath}/home" class="logo">Shop<span>NBH</span></a>
        <a href="#" class="help-link">Bạn cần giúp đỡ?</a>
    </div>
</div>

<div class="main-area">
    <div class="inner">

        <!-- Banner trái -->
        <div class="banner">
            <i class="bi bi-envelope-check-fill icon"></i>
            <h2>Kiểm tra email</h2>
            <p>Mã OTP đã được gửi đến hộp thư của bạn.<br>Mã có hiệu lực trong <strong>5 phút</strong>.</p>
        </div>

        <!-- Form nhập OTP -->
        <div class="card-box">
            <h4>Xác nhận email</h4>
            <p class="desc">Hoàn tất bước cuối để tạo tài khoản</p>

            <div class="steps">
                <div class="step done"><i class="bi bi-check"></i></div>
                <div class="step-line"></div>
                <div class="step active">2</div>
            </div>
            <div class="d-flex justify-content-between mb-3">
                <span class="step-label done">Điền thông tin</span>
                <span class="step-label active">Xác nhận email</span>
            </div>

            <div class="email-hint">
                <i class="bi bi-envelope me-1"></i>
                Mã đã gửi đến: <strong>${email}</strong>
            </div>

            <!-- Thông báo gửi lại thành công -->
            <c:if test="${not empty param.resent}">
                <div class="alert-info-custom">
                    <i class="bi bi-arrow-repeat me-1"></i>
                    Đã gửi lại mã OTP mới. Vui lòng kiểm tra email.
                </div>
            </c:if>

            <!-- Thông báo lỗi -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-circle me-1"></i> ${error}
                </div>
            </c:if>

            <!-- Form OTP -->
            <form action="${pageContext.request.contextPath}/register/verify-otp" method="post" id="otpForm">
                <div class="mb-2">
                    <label class="form-label">Mã OTP (6 số)</label>
                    <input type="text" name="otp" id="otpInput"
                           class="form-control otp-input"
                           placeholder="• • • • • •" maxlength="6"
                           inputmode="numeric" pattern="[0-9]{6}"
                           required autofocus
                           <c:if test="${expired == true}">disabled</c:if>>
                </div>

                <div class="countdown mb-3">
                    Mã hết hạn sau: <span class="time" id="timerDisplay">05:00</span>
                </div>

                <button type="submit" class="btn-main" id="submitBtn"
                        <c:if test="${expired == true}">disabled</c:if>>
                    <i class="bi bi-check-circle me-1"></i> Xác nhận
                </button>
            </form>

            <!-- Form gửi lại OTP -->
            <form action="${pageContext.request.contextPath}/register/resend-otp" method="post">
                <button type="submit" class="btn-resend" id="resendBtn" disabled>
                    <i class="bi bi-arrow-repeat me-1"></i>
                    <span id="resendText">Gửi lại (<span id="resendCountdown">60</span>s)</span>
                </button>
            </form>

            <div class="bottom-link">
                <a href="${pageContext.request.contextPath}/register">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại đăng ký
                </a>
            </div>
        </div>

    </div>
</div>

<script>
    // ── Countdown 5 phút ──
    <c:choose>
        <c:when test="${expired == true}">
            // OTP da het han, hien thi 00:00
            document.getElementById('timerDisplay').textContent = '00:00';
            document.getElementById('timerDisplay').classList.add('expired');
        </c:when>
        <c:otherwise>
            let seconds = 300;
            const timerEl = document.getElementById('timerDisplay');
            const submitBtn = document.getElementById('submitBtn');
            const otpInput  = document.getElementById('otpInput');

            const countdown = setInterval(() => {
                seconds--;
                const m = String(Math.floor(seconds / 60)).padStart(2, '0');
                const s = String(seconds % 60).padStart(2, '0');
                timerEl.textContent = m + ':' + s;

                if (seconds <= 0) {
                    clearInterval(countdown);
                    timerEl.textContent = '00:00';
                    timerEl.classList.add('expired');
                    submitBtn.disabled = true;
                    otpInput.disabled  = true;
                }
            }, 1000);
        </c:otherwise>
    </c:choose>

    // ── Nút Gửi lại: đếm ngược 60s trước khi bật ──
    let resendSec = 60;
    const resendBtn       = document.getElementById('resendBtn');
    const resendText      = document.getElementById('resendText');
    const resendCountdown = document.getElementById('resendCountdown');

    const resendTimer = setInterval(() => {
        resendSec--;
        resendCountdown.textContent = resendSec;
        if (resendSec <= 0) {
            clearInterval(resendTimer);
            resendBtn.disabled = false;
            resendText.innerHTML = '<i class="bi bi-arrow-repeat me-1"></i> Gửi lại mã mới';
        }
    }, 1000);

    // ── Chỉ cho nhập số ──
    document.getElementById('otpInput').addEventListener('input', function () {
        this.value = this.value.replace(/\D/g, '').slice(0, 6);
    });
</script>

</body>
</html>
