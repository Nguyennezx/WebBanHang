<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root { --primary: #1a73e8; --primary-dark: #0d47a1; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; }

        .payment-wrapper {
            max-width: 600px;
            margin: 40px auto;
            padding: 0 16px;
        }

        .card-section {
            background: #fff;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .card-section h5 {
            font-size: 1rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 16px;
            padding-bottom: 10px;
            border-bottom: 1px solid #f0f0f0;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.92rem;
            padding: 6px 0;
            border-bottom: 1px solid #f5f5f5;
        }

        .info-row:last-child { border-bottom: none; }
        .info-label { color: #888; }
        .info-value { font-weight: 600; color: #222; }

        .method-options {
            display: flex;
            gap: 12px;
            margin-top: 8px;
        }

        .method-option {
            flex: 1;
            border: 2px solid #ddd;
            border-radius: 10px;
            padding: 14px;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .method-option:has(input:checked) {
            border-color: var(--primary);
            background: #e8f0fe;
            color: var(--primary);
        }

        .method-option input {
            display: none;
        }

        .method-option i {
            font-size: 1.8rem;
            display: block;
            margin-bottom: 6px;
        }

        .btn-pay {
            width: 100%;
            background: var(--primary);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 13px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 16px;
        }

        .btn-pay:hover { background: var(--primary-dark); }

        /* Thành công */
        .success-box {
            text-align: center;
            padding: 30px 20px;
        }

        .success-box i {
            font-size: 4rem;
            color: #2e7d32;
            margin-bottom: 16px;
        }

        .success-box h4 {
            font-weight: 700;
            color: #2e7d32;
            margin-bottom: 8px;
        }

        .success-box p {
            color: #888;
            font-size: 0.92rem;
        }

        /* Thất bại */
        .error-box {
            text-align: center;
            padding: 30px 20px;
        }

        .error-box i {
            font-size: 4rem;
            color: #c62828;
            margin-bottom: 16px;
        }

        .error-box h4 {
            font-weight: 700;
            color: #c62828;
            margin-bottom: 8px;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: var(--primary);
            text-decoration: none;
            font-size: 0.9rem;
            margin-bottom: 16px;
        }

        .btn-back:hover { text-decoration: underline; }

        .btn-history {
            background: var(--primary);
            color: #fff;
            border-radius: 8px;
            padding: 10px 24px;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
            margin-top: 16px;
            transition: background 0.2s;
        }

        .btn-history:hover { background: var(--primary-dark); color: #fff; }
    </style>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="payment-wrapper">

    <c:choose>

        <%-- Hiển thị kết quả sau khi thanh toán --%>
        <c:when test="${success == true}">
            <div class="card-section">
                <div class="success-box">
                    <i class="bi bi-check-circle-fill"></i>
                    <h4>Thanh toán thành công!</h4>
                    <p>Đơn hàng #${order.orderId} đã được xác nhận</p>
                    <p>Phương thức: <strong>${payment.paymentMethod}</strong></p>
                    <p>Số tiền:
                        <strong style="color:#e53935;">
                            <fmt:formatNumber value="${payment.amount}"
                                             type="number" groupingUsed="true"/>đ
                        </strong>
                    </p>
                    <a href="${pageContext.request.contextPath}/order/history"
                       class="btn-history">
                        <i class="bi bi-receipt me-2"></i>Xem đơn hàng của tôi
                    </a>
                </div>
            </div>
        </c:when>

        <%-- Hiển thị lỗi --%>
        <c:when test="${not empty error}">
            <div class="card-section">
                <div class="error-box">
                    <i class="bi bi-x-circle-fill"></i>
                    <h4>Thanh toán thất bại!</h4>
                    <p>${error}</p>
                    <a href="${pageContext.request.contextPath}/order/detail/${order.orderId}"
                       class="btn-history" style="background:#c62828;">
                        <i class="bi bi-arrow-left me-2"></i>Quay lại đơn hàng
                    </a>
                </div>
            </div>
        </c:when>

        <%-- Form thanh toán --%>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/order/detail/${order.orderId}"
               class="btn-back">
                <i class="bi bi-arrow-left"></i> Quay lại đơn hàng
            </a>

            <div class="card-section">
                <h5><i class="bi bi-receipt me-2"></i>Thông tin đơn hàng</h5>
                <div class="info-row">
                    <span class="info-label">Mã đơn hàng</span>
                    <span class="info-value">#${order.orderId}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Ngày đặt</span>
                    <span class="info-value">${order.orderDate}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Tổng tiền</span>
                    <span class="info-value" style="color:#e53935;">
                        <fmt:formatNumber value="${order.totalAmount}"
                                         type="number" groupingUsed="true"/>đ
                    </span>
                </div>
            </div>

            <div class="card-section">
                <h5><i class="bi bi-credit-card me-2"></i>Chọn phương thức thanh toán</h5>

                <form action="${pageContext.request.contextPath}/payment/process"
                      method="post">
                    <input type="hidden" name="orderId" value="${order.orderId}"/>

                    <div class="method-options">
                        <label class="method-option">
                            <input type="radio" name="paymentMethod"
                                   value="COD" checked/>
                            <i class="bi bi-cash-coin"></i>
                            Tiền mặt (COD)
                        </label>
                        <label class="method-option">
                            <input type="radio" name="paymentMethod"
                                   value="BANKING"/>
                            <i class="bi bi-bank"></i>
                            Chuyển khoản
                        </label>
                        <label class="method-option">
                            <input type="radio" name="paymentMethod"
                                   value="MOMO"/>
                            <i class="bi bi-phone"></i>
                            MoMo
                        </label>
                    </div>

                    <button type="submit" class="btn-pay">
                        <i class="bi bi-lock me-2"></i>Xác nhận thanh toán
                    </button>
                </form>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<%@ include file="../common/footer.jsp" %>