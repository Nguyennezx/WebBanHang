<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
       * { box-sizing: border-box; 
            margin: 0; 
            padding: 0; }
            
       body 
        { 
         font-family: 'Segoe UI', sans-serif; 
         min-height: 100vh; 
         display: flex; 
         flex-direction: column; 
        }

       .topbar
         { 
         background: #fff; 
         padding: 10px 0; 
         }
         
       .topbar .logo 
        {
          font-size: 1.6rem; 
          font-weight: 800; color: #1a73e8;
          text-decoration: none; 
          letter-spacing: -1px; 
         }
         
       .topbar .logo span 
        { 
        color: #ffd54f; 
        }
        
       .topbar .topbar-title 
        {
         font-size: 1rem;
         color: rgba(255,255,255,0.85);
         border-left: 1px solid rgba(255,255,255,0.4);
         padding-left: 16px; 
         margin-left: 16px;
        }
        
       .topbar .help-link
         { 
         color: #0d47a1; 
         text-decoration: none; 
         font-size: 0.9rem; 
         }
         
       .topbar .help-link:hover 
        { 
        text-decoration: underline; 
        }

       .main-area {
            background: linear-gradient(135deg, #1a73e8 0%, #0d47a1 100%);
            flex: 1; 
            display: flex;
            align-items: center; 
            padding: 40px 0 60px;
         }

       .inner {
            display: flex; 
            align-items: center; 
            justify-content: space-between;
            width: 100%; 
            max-width: 960px; 
            margin: 0 auto; 
            padding: 0 16px; 
            gap: 32px;
        }

        .banner { 
        flex: 1; 
        color: #fff;
         padding-right: 16px; 
         }
         
        .banner .icon { 
         font-size: 7rem;
         display: block; 
         margin-bottom: 16px; 
         filter: drop-shadow(0 4px 12px rgba(0,0,0,0.2));
          }
          
        .banner h2 { 
        font-size: 2rem; 
        font-weight: 700;
         margin-bottom: 8px; 
         }
         
        .banner p { 
        font-size: 1rem; 
        opacity: 0.9; 
        line-height: 1.6;
         }

        .card-box {
            background: #fff; 
            border-radius: 4px; 
            padding: 32px 32px 24px;
            width: 400px; 
            flex-shrink: 0; 
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        
        .card-box h4 { 
         font-size: 1.25rem;
         font-weight: 500; 
         color: #333;
         margin-bottom: 8px; 
          }
          
        .card-box .desc { 
        font-size: 0.85rem; 
        color: #888; 
        margin-bottom: 20px; 
        line-height: 1.5; 
        }

        .card-box .form-control {
            border-radius: 2px; 
            border: 1px solid #ddd; 
            padding: 10px 14px; 
            font-size: 0.9rem;
        }
        
        .card-box .form-control:focus { 
        border-color: #1a73e8;
         box-shadow: 0 0 0 2px rgba(26,115,232,0.15); 
         }

        /* OTP input lớn */
        .otp-input {
            font-size: 1.5rem !important;
            font-weight: 700 !important;
            letter-spacing: 8px; 
            text-align: center;
        }

        .pw-wrapper { 
          position: relative; 
          }
          
        .pw-wrapper .form-control { 
          padding-right: 42px; 
        }
        
        .pw-toggle { 
          position: absolute; 
          right: 12px; 
          top: 50%; 
          transform: translateY(-50%); 
          color: #999; 
          cursor: pointer; 
          }

        .btn-main {
            background: #1a73e8; 
            border: none; 
            border-radius: 2px; 
            padding: 11px;
            font-size: 0.95rem; 
            font-weight: 600; 
            color: #fff; 
            width: 100%;
            text-transform: uppercase; 
            letter-spacing: 0.5px; 
            transition: background 0.2s; 
            margin-top: 4px;
        }
        
        .btn-main:hover { 
          background: #1557b0; 
          color: #fff; 
          }

        .bottom-link { 
          text-align: center; 
          font-size: 0.88rem; 
          color: #999; 
          margin-top: 16px; 
          }
          
        .bottom-link a { 
          color: #1a73e8; 
          text-decoration: none; 
          font-weight: 500; 
          }
          
        .bottom-link a:hover { 
           text-decoration: underline; 
           }

        .alert {
         border-radius: 2px; 
         font-size: 0.88rem; 
         padding: 9px 12px; 
         margin-bottom: 16px; 
         }
         
        .form-label { 
         font-size: 0.82rem; 
         color: #555; 
         margin-bottom: 4px;
          }

        .steps { 
          display: flex; 
          align-items: center; 
          gap: 8px; 
          margin-bottom: 8px; }
        .step { width: 28px; height: 28px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 0.8rem; font-weight: 700; }
        .step.active { background: #1a73e8; color: #fff; }
        .step.done { background: #43a047; color: #fff; }
        .step-line { flex: 1; height: 2px; background: #1a73e8; }
        .step-label { font-size: 0.78rem; color: #999; }
        .step-label.active { color: #1a73e8; font-weight: 600; }
        .step-label.done { color: #43a047; }

        /* Countdown */
        .countdown { font-size: 0.82rem; color: #888; text-align: center; margin-top: 8px; }
        .countdown span { color: #1a73e8; font-weight: 600; }
        .resend-link { color: #1a73e8; cursor: pointer; text-decoration: underline; display: none; font-size: 0.82rem; }

        .email-hint {
            background: #e8f0fe; border-radius: 4px; padding: 8px 12px;
            font-size: 0.82rem; color: #1a73e8; margin-bottom: 16px;
        }
    </style>
</head>
<body>

<div class="topbar">
    <div class="container d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center">
            <a href="${pageContext.request.contextPath}/home" class="logo">Shop<span>NBH</span></a>
            <span class="topbar-title">Đặt lại mật khẩu</span>
        </div>
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

        <!-- Form -->
        <div class="card-box">
            <h4>Đặt lại mật khẩu</h4>
            <p class="desc">Nhập mã OTP và mật khẩu mới của bạn</p>

            <!-- Step indicator -->
            <div class="steps">
                <div class="step done"><i class="bi bi-check"></i></div>
                <div class="step-line"></div>
                <div class="step active">2</div>
            </div>
            <div class="d-flex justify-content-between mb-3">
                <span class="step-label done">Nhập email</span>
                <span class="step-label active">Đặt lại mật khẩu</span>
            </div>

            <!-- Email hint -->
            <div class="email-hint">
                <i class="bi bi-envelope me-1"></i>
                Mã đã gửi đến: <strong>${email}</strong>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle me-1"></i> ${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/forgot-password/reset" method="post">

                <div class="mb-3">
                    <label class="form-label">Mã OTP (6 số)</label>
                    <input type="text" name="otp" class="form-control otp-input"
                           placeholder="• • • • • •" maxlength="6"
                           inputmode="numeric" pattern="[0-9]{6}" required autofocus>
                </div>

                <!-- Countdown 5 phút -->
                <div class="countdown mb-3">
                    Mã hết hạn sau: <span id="timer">05:00</span>
                    &nbsp;|&nbsp;
                    <a class="resend-link" id="resendLink"
                       href="${pageContext.request.contextPath}/forgot-password">
                        Gửi lại
                    </a>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mật khẩu mới</label>
                    <div class="pw-wrapper">
                        <input type="password" name="newPassword" id="pw1"
                               class="form-control" placeholder="Tối thiểu 6 ký tự" required>
                        <span class="pw-toggle" onclick="togglePw('pw1','eye1')">
                            <i class="bi bi-eye" id="eye1"></i>
                        </span>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Xác nhận mật khẩu mới</label>
                    <div class="pw-wrapper">
                        <input type="password" name="confirmPassword" id="pw2"
                               class="form-control" placeholder="Nhập lại mật khẩu" required>
                        <span class="pw-toggle" onclick="togglePw('pw2','eye2')">
                            <i class="bi bi-eye" id="eye2"></i>
                        </span>
                    </div>
                </div>

                <button type="submit" class="btn-main">Xác nhận</button>
            </form>

            <div class="bottom-link">
                <a href="${pageContext.request.contextPath}/forgot-password">
                    <i class="bi bi-arrow-left me-1"></i>Nhập lại email
                </a>
            </div>
        </div>

    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    // Hiện/ẩn mật khẩu
    function togglePw(inputId, iconId) {
        const input = document.getElementById(inputId);
        const icon  = document.getElementById(iconId);
        input.type  = input.type === 'password' ? 'text' : 'password';
        icon.className = input.type === 'text' ? 'bi bi-eye-slash' : 'bi bi-eye';
    }

    // Đếm ngược 5 phút
    let seconds = 300;
    const timerEl    = document.getElementById('timer');
    const resendLink = document.getElementById('resendLink');

    const countdown = setInterval(() => {
        seconds--;
        const m = String(Math.floor(seconds / 60)).padStart(2, '0');
        const s = String(seconds % 60).padStart(2, '0');
        timerEl.textContent = m + ':' + s;

        if (seconds <= 0) {
            clearInterval(countdown);
            timerEl.textContent = '00:00';
            timerEl.style.color = '#dc3545';
            resendLink.style.display = 'inline';
        }
    }, 1000);

    // Chỉ cho nhập số trong ô OTP
    document.querySelector('.otp-input').addEventListener('input', function () {
        this.value = this.value.replace(/\D/g, '').slice(0, 6);
    });
</script>
</body>
</html>
