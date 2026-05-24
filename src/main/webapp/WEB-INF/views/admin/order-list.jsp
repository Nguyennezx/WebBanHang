<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap');

    .orders-wrap {
        padding: 32px 28px;
        font-family: 'Be Vietnam Pro', sans-serif;
    }

    .orders-page-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 24px;
    }

    .orders-page-header h4 {
        font-size: 20px;
        font-weight: 700;
        color: #111827;
        margin: 0 0 4px;
        letter-spacing: -0.3px;
    }

    .orders-page-header .subtitle {
        font-size: 13px;
        color: #6b7280;
        font-weight: 400;
    }

    /* Tabs Filter */
    .filter-tabs {
        display: flex;
        gap: 8px;
        margin-bottom: 20px;
    }

    .filter-tab {
        padding: 8px 16px;
        background: #f3f4f6;
        color: #4b5563;
        border-radius: 8px;
        font-size: 13px;
        font-weight: 600;
        text-decoration: none;
        transition: all .2s;
    }

    .filter-tab:hover {
        background: #e5e7eb;
    }

    .filter-tab.active {
        background: #3b82f6;
        color: #fff;
    }

    /* Table card */
    .orders-card {
        background: #fff;
        border-radius: 12px;
        border: 1px solid #e5e7eb;
        box-shadow: 0 1px 4px rgba(0,0,0,0.05);
        overflow: hidden;
    }

    .orders-card table {
        width: 100%;
        border-collapse: collapse;
        font-size: 13.5px;
    }

    .orders-card thead tr {
        background: #f9fafb;
        border-bottom: 1px solid #e5e7eb;
    }

    .orders-card thead th {
        padding: 11px 16px;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
        color: #6b7280;
        text-align: left;
    }

    .orders-card tbody td {
        padding: 14px 16px;
        border-bottom: 1px solid #f3f4f6;
        color: #374151;
        vertical-align: middle;
    }

    .orders-card tbody tr:hover { background: #fafafa; }

    /* status badge */
    .status-badge {
        display: inline-flex;
        align-items: center;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 11.5px;
        font-weight: 600;
    }

    .status-badge.pending { background: #fef9c3; color: #a16207; }
    .status-badge.confirmed { background: #dbeafe; color: #1d4ed8; }
    .status-badge.cancelled { background: #fee2e2; color: #b91c1c; }

    .action-btn {
        padding: 6px 12px;
        border-radius: 6px;
        background: #eff6ff;
        color: #2563eb;
        font-size: 12px;
        font-weight: 600;
        text-decoration: none;
        border: 1px solid #bfdbfe;
        transition: all .2s;
    }
    
    .action-btn:hover {
        background: #dbeafe;
    }
</style>

<div class="orders-wrap">
    <div class="orders-page-header">
        <div>
            <h4>📋 Quản lý đơn hàng</h4>
            <span class="subtitle">Theo dõi và cập nhật trạng thái đơn hàng</span>
        </div>
    </div>

    <div class="filter-tabs">
        <a href="${pageContext.request.contextPath}/admin/orders" class="filter-tab ${currentStatus == 'all' ? 'active' : ''}">Tất cả</a>
        <a href="${pageContext.request.contextPath}/admin/orders?status=pending" class="filter-tab ${currentStatus == 'pending' ? 'active' : ''}">Đang đợi</a>
        <a href="${pageContext.request.contextPath}/admin/orders?status=confirmed" class="filter-tab ${currentStatus == 'confirmed' ? 'active' : ''}">Đã xác nhận</a>
        <a href="${pageContext.request.contextPath}/admin/orders?status=cancelled" class="filter-tab ${currentStatus == 'cancelled' ? 'active' : ''}">Đã hủy</a>
    </div>

    <div class="orders-card">
        <table>
            <thead>
                <tr>
                    <th>Mã ĐH</th>
                    <th>Khách hàng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td style="font-weight:600">#${order.orderId}</td>
                        <td>
                            <div style="font-weight:600; color:#111827">${order.user.fullName}</div>
                            <div style="font-size:12px; color:#6b7280">${order.receiverPhone}</div>
                        </td>
                        <td>${order.orderDate}</td>
                        <td style="font-weight:700; color:#dc2626"><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫</td>
                        <td>
                            <span class="status-badge ${order.status}">
                                <c:choose>
                                    <c:when test="${order.status == 'pending'}">Đang đợi</c:when>
                                    <c:when test="${order.status == 'confirmed'}">Đã xác nhận</c:when>
                                    <c:when test="${order.status == 'cancelled'}">Đã hủy</c:when>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/orders/${order.orderId}" class="action-btn">Chi tiết</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orders}">
                    <tr>
                        <td colspan="6" style="text-align:center; padding: 32px; color: #9ca3af">Không có đơn hàng nào</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>
