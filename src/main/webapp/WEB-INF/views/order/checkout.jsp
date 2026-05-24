<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận đặt hàng - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root { --primary: #1a73e8; --primary-dark: #0d47a1; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; }

        .checkout-wrapper {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 16px;
        }

        .page-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 20px;
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

        .item-row {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 0;
            border-bottom: 1px solid #f5f5f5;
        }

        .item-row:last-child { border-bottom: none; }

        .item-img {
            width: 55px;
            height: 55px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #eee;
        }

        .item-name {
            flex: 1;
            font-weight: 600;
            font-size: 0.92rem;
            color: #222;
        }

        .item-qty {
            font-size: 0.85rem;
            color: #888;
        }

        .item-price {
            font-weight: 700;
            color: #e53935;
            font-size: 0.95rem;
        }

        .address-input,
        .phone-input,
        .notes-input {
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px 14px;
            font-size: 0.92rem;
            resize: none;
            font-family: 'Segoe UI', sans-serif;
        }

        .phone-input {
            resize: none;
        }

        .checkout-field {
            margin-bottom: 14px;
        }

        .checkout-field label {
            display: flex;
            align-items: center;
            gap: 6px;
            color: #374151;
            font-size: 0.9rem;
            font-weight: 700;
            margin-bottom: 7px;
        }

        .required-mark {
            color: #e53935;
        }

        .address-input {
            min-height: 92px;
        }

        .field-hint {
            color: #6b7280;
            font-size: 0.84rem;
            margin-top: 8px;
        }

        .address-input:focus,
        .phone-input:focus,
        .notes-input:focus {
            outline: none;
            border-color: var(--primary);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.92rem;
            color: #555;
            margin-bottom: 8px;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 1.2rem;
            font-weight: 700;
            color: #e53935;
            padding-top: 10px;
            border-top: 1px solid #f0f0f0;
            margin-top: 8px;
        }

        .btn-place {
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

        .btn-place:hover { background: var(--primary-dark); }

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

        .alert-error {
            background: #fdecea;
            color: #c62828;
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 16px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="checkout-wrapper">
    <a href="${pageContext.request.contextPath}/cart" class="btn-back">
        <i class="bi bi-arrow-left"></i> Quay lại giỏ hàng
    </a>

    <div class="page-title">
        <i class="bi bi-bag-check me-2"></i>Xác nhận đặt hàng
    </div>

    <%-- Hiển thị lỗi nếu có --%>
    <c:if test="${not empty error}">
        <div class="alert-error">
            <i class="bi bi-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/order/place" method="post">

        <%-- Dia chi giao hang --%>
        <div class="card-section">
            <h5><i class="bi bi-truck me-2"></i>Th&#244;ng tin nh&#7853;n h&#224;ng</h5>
            <div class="checkout-field">
                <label for="receiverPhone">
                    <i class="bi bi-telephone"></i>
                    S&#7889; &#273;i&#7879;n tho&#7841;i nh&#7853;n h&#224;ng
                    <span class="required-mark">*</span>
                </label>
                <input class="phone-input"
                       id="receiverPhone"
                       type="tel"
                       name="receiverPhone"
                       value="${receiverPhone}"
                       pattern="[0-9]{10}"
                       maxlength="10"
                       required
                       placeholder="V&#237; d&#7909;: 0901234567"/>
            </div>
            <div class="checkout-field">
                <label for="shippingAddress">
                    <i class="bi bi-geo-alt"></i>
                    &#272;&#7883;a ch&#7881; giao h&#224;ng
                    <span class="required-mark">*</span>
                </label>
                <textarea class="address-input"
                          id="shippingAddress"
                          name="shippingAddress"
                          rows="3"
                          required
                          placeholder="Nh&#7853;p s&#7889; nh&#224;, t&#234;n &#273;&#432;&#7901;ng, ph&#432;&#7901;ng/x&#227;, qu&#7853;n/huy&#7879;n, t&#7881;nh/th&#224;nh ph&#7889;...">${shippingAddress}</textarea>
            </div>
            <div class="field-hint">
                Vui l&#242;ng nh&#7853;p &#273;&#7883;a ch&#7881; r&#245; r&#224;ng &#273;&#7875; ShopNBH giao h&#224;ng ch&#237;nh x&#225;c.
            </div>
        </div>

        <%-- Danh sách sản phẩm --%>
        <div class="card-section">
            <h5><i class="bi bi-box-seam me-2"></i>Sản phẩm đặt hàng</h5>
            <c:forEach var="item" items="${cartItems}">
                <div class="item-row">
                    <img src="${pageContext.request.contextPath}/${item.product.imageUrl}"
                         class="item-img"
                         onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'"/>
                    <span class="item-name">${item.product.productName}</span>
                    <span class="item-qty">x${item.quantity}</span>
                    <span class="item-price">
                        <fmt:formatNumber
                            value="${item.product.price.doubleValue() * item.quantity}"
                            type="number" groupingUsed="true"/>đ
                    </span>
                </div>
            </c:forEach>
        </div>

        <%-- Ghi chú --%>
        <div class="card-section">
            <h5><i class="bi bi-chat-left-text me-2"></i>Ghi chú đơn hàng</h5>
            <textarea class="notes-input"
                      name="notes"
                      rows="3"
                      placeholder="Ghi chú thêm cho đơn hàng (không bắt buộc)..."></textarea>
        </div>

        <%-- Tổng tiền --%>
        <div class="card-section">
            <h5><i class="bi bi-receipt me-2"></i>Tóm tắt đơn hàng</h5>
            <div class="summary-row">
                <span>Tạm tính</span>
                <span><fmt:formatNumber value="${total}" type="number" groupingUsed="true"/>đ</span>
            </div>
            <div class="summary-row">
                <span>Phí vận chuyển</span>
                <span style="color:#2e7d32;">Miễn phí</span>
            </div>
            <div class="summary-total">
                <span>Tổng cộng</span>
                <span><fmt:formatNumber value="${total}" type="number" groupingUsed="true"/>đ</span>
            </div>

            <button type="submit" class="btn-place">
                <i class="bi bi-check-circle me-2"></i>Xác nhận đặt hàng
            </button>
        </div>

    </form>
</div>

<%@ include file="../common/footer.jsp" %>
