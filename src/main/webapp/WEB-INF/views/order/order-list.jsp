<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đơn hàng của tôi - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root { --primary: #1a73e8; --primary-dark: #0d47a1; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; }

        .list-wrapper {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 16px;
        }

        .page-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 20px;
        }

        .order-card {
            background: #fff;
            border-radius: 12px;
            padding: 20px 24px;
            margin-bottom: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: box-shadow 0.2s;
        }

        .order-card:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.12); }

        .order-id {
            font-weight: 700;
            color: var(--primary);
            font-size: 0.95rem;
        }

        .order-date {
            font-size: 0.82rem;
            color: #888;
            margin-top: 4px;
        }

        .order-amount {
            font-weight: 700;
            color: #e53935;
            font-size: 1.05rem;
        }

        .badge-status {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .badge-pending  { background: #fff8e1; color: #f57f17; }
        .badge-confirmed{ background: #e8f5e9; color: #2e7d32; }
        .badge-cancelled{ background: #fdecea; color: #c62828; }

        .btn-detail {
            background: var(--primary);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 7px 18px;
            font-size: 0.85rem;
            text-decoration: none;
            transition: background 0.2s;
        }

        .btn-detail:hover { background: var(--primary-dark); color: #fff; }

        .empty-order {
            background: #fff;
            border-radius: 12px;
            padding: 60px 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .empty-order i { font-size: 4rem; color: #ccc; margin-bottom: 16px; }
        .empty-order p { color: #888; margin-bottom: 20px; }

        .btn-shop {
            background: var(--primary);
            color: #fff;
            border-radius: 8px;
            padding: 10px 28px;
            text-decoration: none;
            font-weight: 600;
        }

        .btn-shop:hover { background: var(--primary-dark); color: #fff; }
    </style>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="list-wrapper">
    <div class="page-title">
        <i class="bi bi-receipt me-2"></i>Đơn hàng của tôi
    </div>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="empty-order">
                <i class="bi bi-bag-x"></i>
                <p>Bạn chưa có đơn hàng nào!</p>
                <a href="${pageContext.request.contextPath}/products" class="btn-shop">
                    Mua sắm ngay
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <c:forEach var="order" items="${orders}">
                <div class="order-card">
                    <div>
                        <div class="order-id">
                            <i class="bi bi-hash"></i>Đơn hàng #${order.orderId}
                        </div>
                        <div class="order-date">
                            <i class="bi bi-calendar3 me-1"></i>${order.orderDate}
                        </div>
                    </div>

                    <div>
                        <%-- Badge trạng thái --%>
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
                    </div>

                    <div class="order-amount">
                        <fmt:formatNumber value="${order.totalAmount}"
                                          type="number" groupingUsed="true"/>đ
                    </div>

                    <a href="${pageContext.request.contextPath}/order/detail/${order.orderId}"
                       class="btn-detail">
                        <i class="bi bi-eye me-1"></i>Xem chi tiết
                    </a>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../common/footer.jsp" %>