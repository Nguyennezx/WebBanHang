<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap');

    .order-detail-wrap {
        padding: 32px 28px;
        font-family: 'Be Vietnam Pro', sans-serif;
    }

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
    }

    .page-header h4 {
        font-size: 20px;
        font-weight: 700;
        color: #111827;
        margin: 0;
    }
    
    .back-link {
        font-size: 13px;
        color: #6b7280;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 4px;
    }
    .back-link:hover { color: #3b82f6; }

    .grid-container {
        display: grid;
        grid-template-columns: 2fr 1fr;
        gap: 24px;
    }

    .card {
        background: #fff;
        border-radius: 12px;
        border: 1px solid #e5e7eb;
        padding: 24px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.04);
        margin-bottom: 24px;
    }

    .card-title {
        font-size: 16px;
        font-weight: 700;
        color: #111827;
        margin-bottom: 16px;
        padding-bottom: 12px;
        border-bottom: 1px solid #f3f4f6;
    }

    /* Product Table */
    table.product-list {
        width: 100%;
        border-collapse: collapse;
        font-size: 13.5px;
    }
    table.product-list th {
        text-align: left;
        padding: 12px 8px;
        color: #6b7280;
        font-weight: 600;
        border-bottom: 1px solid #e5e7eb;
    }
    table.product-list td {
        padding: 16px 8px;
        border-bottom: 1px solid #f3f4f6;
        vertical-align: middle;
    }
    .product-img {
        width: 48px;
        height: 48px;
        border-radius: 8px;
        object-fit: cover;
    }
    .product-name {
        font-weight: 600;
        color: #1f2937;
    }

    /* Total Section */
    .total-row {
        display: flex;
        justify-content: space-between;
        padding: 12px 0;
        font-size: 14px;
    }
    .total-row.grand {
        font-size: 18px;
        font-weight: 700;
        color: #dc2626;
        border-top: 1px solid #e5e7eb;
        padding-top: 16px;
        margin-top: 8px;
    }

    /* Info Row */
    .info-row {
        display: flex;
        flex-direction: column;
        gap: 4px;
        margin-bottom: 16px;
    }
    .info-label {
        font-size: 12px;
        color: #6b7280;
        font-weight: 500;
    }
    .info-value {
        font-size: 14px;
        color: #1f2937;
        font-weight: 500;
    }

    /* Actions */
    .action-group {
        display: flex;
        gap: 12px;
        margin-top: 24px;
    }
    .btn {
        flex: 1;
        padding: 10px 0;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        border: none;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        transition: all 0.2s;
    }
    .btn-confirm {
        background: #2563eb;
        color: #fff;
    }
    .btn-confirm:hover { background: #1d4ed8; }
    
    .btn-cancel {
        background: #fee2e2;
        color: #dc2626;
    }
    .btn-cancel:hover { background: #fecaca; }

    .status-badge {
        display: inline-flex;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 600;
    }
    .status-badge.pending { background: #fef9c3; color: #a16207; }
    .status-badge.confirmed { background: #dbeafe; color: #1d4ed8; }
    .status-badge.cancelled { background: #fee2e2; color: #b91c1c; }
</style>

<div class="order-detail-wrap">
    <div class="page-header">
        <div>
            <a href="${pageContext.request.contextPath}/admin/orders" class="back-link">← Quay lại danh sách</a>
            <h4 style="margin-top: 8px;">Chi tiết Đơn hàng #${order.orderId}</h4>
        </div>
        <div>
            <span class="status-badge ${order.status}">
                <c:choose>
                    <c:when test="${order.status == 'pending'}">Đang đợi xác nhận</c:when>
                    <c:when test="${order.status == 'confirmed'}">Đã xác nhận</c:when>
                    <c:when test="${order.status == 'cancelled'}">Đã hủy</c:when>
                </c:choose>
            </span>
        </div>
    </div>

    <div class="grid-container">
        <!-- Left Column: Products -->
        <div class="left-col">
            <div class="card">
                <div class="card-title">Danh sách sản phẩm</div>
                <table class="product-list">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th style="text-align:center">Số lượng</th>
                            <th style="text-align:right">Đơn giá</th>
                            <th style="text-align:right">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${orderItems}">
                            <tr>
                                <td>
                                    <div style="display:flex; align-items:center; gap:12px">
                                        <img src="${pageContext.request.contextPath}/${item.product.imageUrl}" class="product-img" onerror="this.src='https://placehold.co/100x100?text=No+Image'"/>
                                        <span class="product-name">${item.product.productName}</span>
                                    </div>
                                </td>
                                <td style="text-align:center">${item.quantity}</td>
                                <td style="text-align:right"><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/>₫</td>
                                <td style="text-align:right; font-weight:600"><fmt:formatNumber value="${item.price.doubleValue() * item.quantity}" type="number" groupingUsed="true"/>₫</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div style="margin-top:20px; max-width:300px; margin-left:auto;">
                    <div class="total-row grand">
                        <span>Tổng cộng:</span>
                        <span><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column: Info -->
        <div class="right-col">
            <div class="card">
                <div class="card-title">Thông tin khách hàng</div>
                <div class="info-row">
                    <span class="info-label">Tên khách hàng</span>
                    <span class="info-value">${order.user.fullName}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Số điện thoại</span>
                    <span class="info-value">${order.receiverPhone}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Địa chỉ giao hàng</span>
                    <span class="info-value">${order.shippingAddress}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Ghi chú</span>
                    <span class="info-value">${empty order.notes ? 'Không có' : order.notes}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Ngày đặt</span>
                    <span class="info-value">${order.orderDate}</span>
                </div>

                <c:if test="${order.status == 'pending'}">
                    <div class="action-group">
                        <form action="${pageContext.request.contextPath}/admin/orders/${order.orderId}/update-status" method="post" style="flex:1">
                            <input type="hidden" name="status" value="confirmed"/>
                            <button type="submit" class="btn btn-confirm">✅ Xác nhận</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/admin/orders/${order.orderId}/update-status" method="post" style="flex:1">
                            <input type="hidden" name="status" value="cancelled"/>
                            <button type="submit" class="btn btn-cancel" onclick="return confirm('Bạn có chắc muốn hủy đơn này?')">❌ Hủy đơn</button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>
