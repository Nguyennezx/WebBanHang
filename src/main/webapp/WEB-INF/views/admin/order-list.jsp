<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

                <!-- Nạp Bootstrap CSS vì trang này dùng class của Bootstrap -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
                    rel="stylesheet">

                <style>
                    :root {
                        --primary: #1a73e8;
                        --primary-dark: #0d47a1;
                    }

                    .list-wrapper {
                        padding: 20px;
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
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        transition: box-shadow 0.2s;
                    }

                    .order-card:hover {
                        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
                    }

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

                    .badge-pending {
                        background: #fff8e1;
                        color: #f57f17;
                    }

                    .badge-confirmed {
                        background: #e8f5e9;
                        color: #2e7d32;
                    }

                    .badge-cancelled {
                        background: #fdecea;
                        color: #c62828;
                    }

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

                    .btn-detail:hover {
                        background: var(--primary-dark);
                        color: #fff;
                    }

                    .empty-order {
                        background: #fff;
                        border-radius: 12px;
                        padding: 60px 20px;
                        text-align: center;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                    }

                    .empty-order i {
                        font-size: 4rem;
                        color: #ccc;
                        margin-bottom: 16px;
                    }

                    .empty-order p {
                        color: #888;
                        margin-bottom: 20px;
                    }

                    .filter-section {
                        background: #fff;
                        padding: 15px;
                        border-radius: 10px;
                        margin-bottom: 20px;
                        display: flex;
                        gap: 10px;
                    }
                </style>

                <div class="container-fluid list-wrapper">
                    <div class="page-title">
                        <i class="bi bi-receipt me-2"></i>Quản lý Đơn hàng
                    </div>

                    <div class="filter-section">
                        <form action="${pageContext.request.contextPath}/admin/orders" method="get"
                            class="d-flex align-items-center gap-2">
                            <label class="fw-bold">Lọc trạng thái:</label>
                            <select name="status" class="form-select w-auto" onchange="this.form.submit()">
                                <option value="all" ${currentStatus=='all' ? 'selected' : '' }>Tất cả</option>
                                <option value="pending" ${currentStatus=='pending' ? 'selected' : '' }>Chờ xác nhận
                                </option>
                                <option value="confirmed" ${currentStatus=='confirmed' ? 'selected' : '' }>Đã xác nhận
                                </option>
                                <option value="cancelled" ${currentStatus=='cancelled' ? 'selected' : '' }>Đã hủy
                                </option>
                            </select>
                        </form>
                    </div>

                    <c:choose>
                        <c:when test="${empty orders}">
                            <div class="empty-order">
                                <i class="bi bi-bag-x"></i>
                                <p>Không có đơn hàng nào!</p>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="order" items="${orders}">
                                <div class="order-card">
                                    <div>
                                        <div class="order-id">
                                            <i class="bi bi-hash"></i>Đơn hàng #${order.orderId}
                                            <!-- Fix cache -->
                                            <span class="text-muted ms-2" style="font-size:0.85rem">Khách:
                                                ${order.user.userName}</span>
                                        </div>
                                        <div class="order-date">
                                            <i class="bi bi-calendar3 me-1"></i>${order.orderDate}
                                        </div>
                                    </div>

                                    <div>
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
                                        <fmt:formatNumber value="${order.totalAmount}" type="number"
                                            groupingUsed="true" />đ
                                    </div>

                                    <a href="${pageContext.request.contextPath}/admin/orders/${order.orderId}"
                                        class="btn-detail">
                                        <i class="bi bi-eye me-1"></i>Xem chi tiết
                                    </a>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>