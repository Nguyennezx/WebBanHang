<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root { --primary: #1a73e8; --primary-dark: #0d47a1; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; }

        .detail-wrapper {
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

        .item-name { flex: 1; font-weight: 600; font-size: 0.92rem; }
        .item-qty  { color: #888; font-size: 0.85rem; }
        .item-price{ font-weight: 700; color: #e53935; }

        .total-row {
            display: flex;
            justify-content: space-between;
            font-size: 1.15rem;
            font-weight: 700;
            color: #e53935;
            padding-top: 12px;
            border-top: 1px solid #f0f0f0;
            margin-top: 8px;
        }

        .badge-status {
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .badge-pending  { background: #fff8e1; color: #f57f17; }
        .badge-confirmed{ background: #e8f5e9; color: #2e7d32; }
        .badge-cancelled{ background: #fdecea; color: #c62828; }

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

        .btn-cancel {
            background: #fdecea;
            color: #c62828;
            border: none;
            border-radius: 8px;
            padding: 10px 24px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn-cancel:hover { background: #ffcdd2; }
    </style>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="detail-wrapper">

    <a href="${pageContext.request.contextPath}/order/history" class="btn-back">
        <i class="bi bi-arrow-left"></i> Quay lại danh sách đơn hàng
    </a>

    <div class="page-title">
        <i class="bi bi-receipt me-2"></i>Chi tiết đơn hàng #${order.orderId}
    </div>

    <%-- Thông tin đơn hàng --%>
    <div class="card-section">
        <h5><i class="bi bi-info-circle me-2"></i>Thông tin đơn hàng</h5>
        <div class="info-row">
            <span class="info-label">Địa chỉ giao hàng</span>
            <span class="info-value">${order.shippingAddress}</span>
        </div>
        <div class="info-row">
            <span class="info-label">Số điện thoại nhận hàng</span>
            <span class="info-value">${order.receiverPhone}</span>
        </div>
        <div class="info-row">
            <span class="info-label">Mã đơn hàng</span>
            <span class="info-value">#${order.orderId}</span>
        </div>
        <div class="info-row">
            <span class="info-label">Ngày đặt</span>
            <span class="info-value">${order.orderDate}</span>
        </div>
        <div class="info-row">
            <span class="info-label">Trạng thái</span>
            <span>
                <c:choose>
                    <c:when test="${order.status == 'pending'}">
                        <span class="badge-status badge-pending">
                            <i class="bi bi-clock me-1"></i>Chờ xác nhận
                        </span>
                    </c:when>
                    <c:when test="${order.status == 'confirmed'}">
                        <span class="badge-status badge-confirmed">
                            <i class="bi bi-check-circle me-1"></i>Đã xác nhận
                        </span>
                    </c:when>
                    <c:when test="${order.status == 'cancelled'}">
                        <span class="badge-status badge-cancelled">
                            <i class="bi bi-x-circle me-1"></i>Đã hủy
                        </span>
                    </c:when>
                </c:choose>
            </span>
        </div>
        <c:if test="${not empty order.notes}">
            <div class="info-row">
                <span class="info-label">Ghi chú</span>
                <span class="info-value">${order.notes}</span>
            </div>
        </c:if>
    </div>

    <%-- Danh sách sản phẩm --%>
    <div class="card-section">
        <h5><i class="bi bi-box-seam me-2"></i>Sản phẩm</h5>
        <c:forEach var="item" items="${orderItems}">
            <div class="item-row">
                <img src="${pageContext.request.contextPath}/${item.product.imageUrl}"
                     class="item-img"
                     onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'"/>
                <span class="item-name">${item.product.productName}</span>
                <span class="item-qty">x${item.quantity}</span>
                <span class="item-price">
                    <fmt:formatNumber
                        value="${item.price.doubleValue() * item.quantity}"
                        type="number" groupingUsed="true"/>đ
                </span>
            </div>
        </c:forEach>

        <div class="total-row">
            <span>Tổng cộng</span>
            <span>
                <fmt:formatNumber value="${order.totalAmount}"
                                  type="number" groupingUsed="true"/>đ
            </span>
        </div>
    </div>

    <%-- Nút thanh toán + hủy đơn (chỉ hiện khi pending) --%>
    <c:if test="${order.status == 'pending'}">
    <div class="card-section" style="display:flex; justify-content:space-between;">

        <%-- Nút thanh toán --%>
        <a href="${pageContext.request.contextPath}/payment/${order.orderId}"
           class="btn-checkout"
           style="background:#2e7d32; color:#fff; border-radius:8px;
                  padding:10px 24px; text-decoration:none; font-weight:600;">
            <i class="bi bi-credit-card me-2"></i>Thanh toán
        </a>

        <%-- Nút hủy đơn --%>
        <form action="${pageContext.request.contextPath}/order/cancel"
              method="post"
              onsubmit="return confirm('Bạn có chắc muốn hủy đơn hàng này?')">
            <input type="hidden" name="orderId" value="${order.orderId}"/>
            <button type="submit" class="btn-cancel">
                <i class="bi bi-x-circle me-2"></i>Hủy đơn hàng
            </button>
        </form>

    </div>
    </c:if>

</div>

<%@ include file="../common/footer.jsp" %>
