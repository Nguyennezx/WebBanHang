<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toan - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root { --primary: #1a73e8; --primary-dark: #0d47a1; --momo: #ae2070; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; }

        .pay-wrapper { max-width: 640px; margin: 32px auto; padding: 0 16px; }

        .pay-card {
            background: #fff;
            border-radius: 12px;
            padding: 28px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        .pay-card h5 {
            font-size: 1rem;
            font-weight: 700;
            color: var(--primary);
            border-bottom: 2px solid #e8eaed;
            padding-bottom: 10px;
            margin-bottom: 16px;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 7px 0;
            border-bottom: 1px dashed #f0f0f0;
            font-size: 0.92rem;
        }
        .info-row:last-child { border-bottom: none; }
        .info-label { color: #5f6368; }
        .info-value { font-weight: 600; }
        .price-big { font-size: 1.15rem; color: #d93025; font-weight: 700; }

        .method-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 10px; margin-bottom: 20px; }
        .method-card {
            border: 2px solid #dadce0;
            border-radius: 10px;
            padding: 14px 8px;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s;
            background: #fff;
            position: relative;
        }
        .method-card input[type=radio] { position: absolute; opacity: 0; }
        .method-card i { font-size: 1.7rem; display: block; margin-bottom: 6px; }
        .method-card span { font-size: 0.82rem; font-weight: 600; color: #5f6368; }
        .method-card:hover { border-color: var(--primary); transform: translateY(-2px); }

        .method-card.active[data-method="COD"]     { border-color: #34a853; background: #f0fbf3; }
        .method-card.active[data-method="COD"] i,
        .method-card.active[data-method="COD"] span { color: #34a853; }

        .method-card.active[data-method="BANKING"]     { border-color: var(--primary); background: #e8f0fe; }
        .method-card.active[data-method="BANKING"] i,
        .method-card.active[data-method="BANKING"] span { color: var(--primary); }

        .method-card.active[data-method="MOMO"]     { border-color: var(--momo); background: #fce4ec; }
        .method-card.active[data-method="MOMO"] i,
        .method-card.active[data-method="MOMO"] span { color: var(--momo); }

        .method-pane { display: none; padding: 16px; border-radius: 10px; background: #f8f9fa; border: 1px solid #e8eaed; margin-bottom: 20px; }
        .method-pane.active { display: block; }

        .btn-pay {
            width: 100%; padding: 13px; border: none; border-radius: 8px;
            font-size: 0.95rem; font-weight: 600; color: #fff; cursor: pointer; transition: background 0.2s;
        }
        .btn-pay.cod     { background: #34a853; }
        .btn-pay.cod:hover { background: #2b8c44; }
        .btn-pay.banking { background: var(--primary); }
        .btn-pay.banking:hover { background: var(--primary-dark); }
        .btn-pay.momo    { background: var(--momo); }
        .btn-pay.momo:hover { background: #8c1456; }

        .btn-back { color: var(--primary); font-size: 0.88rem; text-decoration: none; font-weight: 600; }
        .btn-back:hover { text-decoration: underline; }

        .result-box { text-align: center; padding: 28px 10px; }
        .result-box .icon-ok   { font-size: 4rem; color: #34a853; display: block; margin-bottom: 12px; }
        .result-box .icon-fail { font-size: 4rem; color: #d93025; display: block; margin-bottom: 12px; }
        .btn-goto {
            display: inline-block; margin-top: 16px; padding: 11px 28px;
            background: var(--primary); color: #fff; border-radius: 8px;
            text-decoration: none; font-weight: 600; transition: background 0.2s;
        }
        .btn-goto:hover { background: var(--primary-dark); color: #fff; }
        .btn-goto.red { background: #d93025; }
        .btn-goto.red:hover { background: #b71c1c; color: #fff; }

        .overlay { position: fixed; inset: 0; background: rgba(255,255,255,.92); display: flex; flex-direction: column; align-items: center; justify-content: center; z-index: 9999; opacity: 0; pointer-events: none; transition: opacity .3s; }
        .overlay.show { opacity: 1; pointer-events: auto; }
        .spinner { width: 46px; height: 46px; border: 4px solid #eee; border-top-color: var(--primary); border-radius: 50%; animation: spin 1s linear infinite; margin-bottom: 14px; }
        @keyframes spin { to { transform: rotate(360deg); } }
        .overlay-text { font-weight: 600; font-size: 1rem; color: #333; }

        .redirect-note { display: flex; gap: 10px; align-items: flex-start; background: #e8f0fe; border: 1px solid #c5d9f8; border-radius: 8px; padding: 12px 14px; font-size: 0.85rem; color: #1565c0; margin-top: 10px; }
        .redirect-note.momo { background: #fce4ec; border-color: #f8bbd0; color: #880e4f; }
    </style>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="pay-wrapper">

    <%-- THANH CONG --%>
    <c:if test="${success == true}">
        <div class="pay-card">
            <div class="result-box">
                <i class="bi bi-check-circle-fill icon-ok"></i>
                <h4 class="fw-bold mb-2" style="color:#2e7d32;">Thanh toan thanh cong!</h4>
                <p class="text-muted mb-0">Cam on ban da mua hang tai ShopNBH.</p>
                <hr class="my-3">
                <div class="info-row">
                    <span class="info-label">Ma don hang</span>
                    <span class="info-value">#${order.orderId}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Phuong thuc</span>
                    <span class="info-value">${payment.paymentMethod}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Tong tien</span>
                    <span class="info-value price-big">
                        <fmt:formatNumber value="${payment.amount}" type="number" groupingUsed="true"/>d
                    </span>
                </div>
                <div class="info-row">
                    <span class="info-label">Trang thai</span>
                    <span class="info-value text-success">Dang xu ly</span>
                </div>
                <a href="${pageContext.request.contextPath}/order/history" class="btn-goto">
                    <i class="bi bi-bag-check me-1"></i> Xem lich su don hang
                </a>
            </div>
        </div>
    </c:if>

    <%-- DA THANH TOAN ROI --%>
    <c:if test="${not empty alreadyPaid}">
        <div class="pay-card">
            <div class="result-box">
                <i class="bi bi-check-circle-fill icon-ok"></i>
                <h4 class="fw-bold mb-2" style="color:#2e7d32;">Da thanh toan!</h4>
                <p class="text-muted">${alreadyPaid}</p>
                <a href="${pageContext.request.contextPath}/order/detail/${order.orderId}" class="btn-goto">
                    <i class="bi bi-arrow-left me-1"></i> Quay lai don hang
                </a>
            </div>
        </div>
    </c:if>

    <%-- LOI --%>
    <c:if test="${not empty error}">
        <div class="pay-card">
            <div class="result-box">
                <i class="bi bi-x-circle-fill icon-fail"></i>
                <h4 class="fw-bold mb-2">Thanh toan that bai!</h4>
                <p class="text-muted">${error}</p>
                <a href="${pageContext.request.contextPath}/order/detail/${order.orderId}" class="btn-goto red">
                    <i class="bi bi-arrow-left me-1"></i> Quay lai don hang
                </a>
            </div>
        </div>
    </c:if>

    <%-- CHON PHUONG THUC --%>
    <c:if test="${success != true and empty alreadyPaid and empty error}">

        <a href="${pageContext.request.contextPath}/order/detail/${order.orderId}" class="btn-back d-block mb-3">
            <i class="bi bi-arrow-left"></i> Quay lai chi tiet don hang
        </a>

        <div class="pay-card">
            <h5><i class="bi bi-receipt me-2"></i>Tom tat don hang</h5>
            <div class="info-row">
                <span class="info-label">Ma don hang</span>
                <span class="info-value">#${order.orderId}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Thoi gian dat</span>
                <span class="info-value">${order.orderDate}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Tong thanh toan</span>
                <span class="info-value price-big">
                    <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>d
                </span>
            </div>
        </div>

        <div class="pay-card">
            <h5><i class="bi bi-credit-card me-2"></i>Chon phuong thuc thanh toan</h5>

            <form id="payForm" action="${pageContext.request.contextPath}/payment/process" method="post">
                <input type="hidden" name="orderId" value="${order.orderId}">

                <div class="method-grid">
                    <div class="method-card active" data-method="COD">
                        <input type="radio" name="paymentMethod" value="COD" checked>
                        <i class="bi bi-cash-coin"></i>
                        <span>Tien mat (COD)</span>
                    </div>
                    <div class="method-card" data-method="BANKING">
                        <input type="radio" name="paymentMethod" value="BANKING">
                        <i class="bi bi-bank"></i>
                        <span>Chuyen khoan</span>
                    </div>
                    <div class="method-card" data-method="MOMO">
                        <input type="radio" name="paymentMethod" value="MOMO">
                        <i class="bi bi-phone"></i>
                        <span>Vi MoMo</span>
                    </div>
                </div>

                <div id="pane-COD" class="method-pane active">
                    <div class="text-center">
                        <i class="bi bi-truck text-success" style="font-size:2.2rem;"></i>
                        <p class="fw-bold text-success mb-1 mt-2">Thanh toan khi nhan hang (COD)</p>
                        <p class="text-muted small mb-0">
                            Vui long chuan bi chinh xac
                            <strong class="text-danger">
                                <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>d
                            </strong>
                            khi nhan hang. ShopNBH se lien he xac nhan.
                        </p>
                    </div>
                </div>

                <div id="pane-BANKING" class="method-pane">
                    <div class="text-center">
                        <i class="bi bi-shield-check text-primary" style="font-size:2.2rem;"></i>
                        <p class="fw-bold text-primary mb-1 mt-2">Thanh toan qua PayOS (VietQR)</p>
                    </div>
                    <div class="redirect-note">
                        <i class="bi bi-info-circle-fill flex-shrink-0 mt-1"></i>
                        <span>
                            Ban se duoc chuyen sang trang PayOS de quet ma VietQR.
                            So tien <strong><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>d</strong>
                            va noi dung chuyen khoan duoc dien san. Ho tro tat ca ngan hang Viet Nam.
                        </span>
                    </div>
                </div>

                <div id="pane-MOMO" class="method-pane">
                    <div class="text-center">
                        <i class="bi bi-wallet2" style="font-size:2.2rem; color:var(--momo);"></i>
                        <p class="fw-bold mb-1 mt-2" style="color:var(--momo);">Thanh toan online qua PayOS</p>
                    </div>
                    <div class="redirect-note momo">
                        <i class="bi bi-info-circle-fill flex-shrink-0 mt-1"></i>
                        <span>
                            Ban se duoc chuyen sang trang PayOS.
                            Ho tro tat ca vi dien tu va app ngan hang Viet Nam.
                            So tien <strong><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>d</strong> duoc dien san.
                        </span>
                    </div>
                </div>

                <button type="submit" id="btnPay" class="btn-pay cod">
                    <i class="bi bi-check-circle me-1"></i> Xac nhan &amp; Thanh toan COD
                </button>
            </form>
        </div>

    </c:if>

</div>

<div id="overlay" class="overlay">
    <div class="spinner"></div>
    <div id="overlayText" class="overlay-text">Dang xu ly...</div>
</div>

<%@ include file="../common/footer.jsp" %>

<script>
    const cards       = document.querySelectorAll('.method-card');
    const panes       = document.querySelectorAll('.method-pane');
    const btnPay      = document.getElementById('btnPay');
    const form        = document.getElementById('payForm');
    const overlay     = document.getElementById('overlay');
    const overlayText = document.getElementById('overlayText');

    panes.forEach(p => p.style.display = 'none');
    const initPane = document.querySelector('.method-pane.active');
    if (initPane) initPane.style.display = 'block';

    cards.forEach(card => {
        card.addEventListener('click', function () {
            cards.forEach(c => c.classList.remove('active'));
            panes.forEach(p => { p.classList.remove('active'); p.style.display = 'none'; });
            this.classList.add('active');
            const radio = this.querySelector('input[type=radio]');
            radio.checked = true;
            const m = radio.value;
            const pane = document.getElementById('pane-' + m);
            if (pane) { pane.classList.add('active'); pane.style.display = 'block'; }
            if (m === 'COD') {
                btnPay.className = 'btn-pay cod';
                btnPay.innerHTML = '<i class="bi bi-check-circle me-1"></i> Xac nhan &amp; Thanh toan COD';
            } else if (m === 'BANKING') {
                btnPay.className = 'btn-pay banking';
                btnPay.innerHTML = '<i class="bi bi-bank me-1"></i> Thanh toan qua PayOS (VietQR) &#8594;';
            } else if (m === 'MOMO') {
                btnPay.className = 'btn-pay momo';
                btnPay.innerHTML = '<i class="bi bi-wallet2 me-1"></i> Thanh toan online qua PayOS &#8594;';
            }
        });
    });

    if (form) {
        form.addEventListener('submit', function () {
            const sel = document.querySelector("input[name='paymentMethod']:checked").value;
            overlay.classList.add('show');
            overlayText.textContent = sel === 'COD' ? 'Dang tao don hang...' : 'Dang ket noi PayOS...';
        });
    }
</script>

</body>
</html>