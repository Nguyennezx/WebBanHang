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

                    .detail-wrapper {
                        padding: 30px;
                        max-width: 900px;
                        margin: auto;
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
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
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

                    .info-row:last-child {
                        border-bottom: none;
                    }

                    .info-label {
                        color: #888;
                    }

                    .info-value {
                        font-weight: 600;
                        color: #222;
                    }

                    .item-row {
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        padding: 10px 0;
                        border-bottom: 1px solid #f5f5f5;
                    }

                    .item-row:last-child {
                        border-bottom: none;
                    }

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
                    }

                    .item-qty {
                        color: #888;
                        font-size: 0.85rem;
                    }

                    .item-price {
                        font-weight: 700;
                        color: #e53935;
                    }

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

                    .btn-back {
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                        color: var(--primary);
                        text-decoration: none;
                        font-size: 0.9rem;
                        margin-bottom: 16px;
                    }

                    .btn-back:hover {
                        text-decoration: underline;
                    }
                </style>

                <div class="container-fluid detail-wrapper">

                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn-back">
                        <i class="bi bi-arrow-left"></i> Quay lại danh sách
                    </a>

                    <div class="page-title">
                        <i class="bi bi-receipt me-2"></i>Chi tiết đơn hàng #${order.orderId}
                    </div>

                    <c:if test="${param.success == 'true'}">
                        <div class="alert alert-success">Cập nhật trạng thái thành công!</div>
                    </c:if>
                    <c:if test="${param.error == 'true'}">
                        <div class="alert alert-danger">Cập nhật trạng thái thất bại!</div>
                    </c:if>

                    <%-- Thông tin đơn hàng --%>
                        <div class="card-section">
                            <h5><i class="bi bi-info-circle me-2"></i>Thông tin chung</h5>
                            <div class="info-row">
                                <span class="info-label">Khách hàng</span>
                                <!-- Fix cache -->
                                <span class="info-value">${order.user.userName} (Email: ${order.user.email})</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Địa chỉ giao hàng</span>
                                <span class="info-value">${order.shippingAddress}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Số điện thoại nhận hàng</span>
                                <span class="info-value">${order.receiverPhone}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Ngày đặt</span>
                                <span class="info-value">${order.orderDate}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Trạng thái hiện tại</span>
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

                        <%-- Thông tin thanh toán (nếu có) --%>
                            <c:if test="${not empty payment}">
                                <div class="card-section" style="border: 2px solid #2e7d32;">
                                    <h5 style="color: #2e7d32;"><i class="bi bi-credit-card me-2"></i>Thông tin thanh
                                        toán của khách</h5>
                                    <div class="info-row">
                                        <span class="info-label">Phương thức</span>
                                        <span class="info-value text-success">${payment.paymentMethod}</span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Trạng thái giao dịch</span>
                                        <span class="info-value text-success">${payment.paymentStatus}</span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Ngày thanh toán</span>
                                        <span class="info-value">${payment.paymentDate}</span>
                                    </div>
                                </div>
                            </c:if>

                            <%-- Cập nhật trạng thái --%>
                                <div class="card-section">
                                    <h5><i class="bi bi-gear me-2"></i>Thao tác</h5>
                                    <form
                                        action="${pageContext.request.contextPath}/admin/orders/${order.orderId}/update-status"
                                        method="post" class="d-flex align-items-center gap-3">
                                        <select name="status" class="form-select w-auto">
                                            <option value="pending" ${order.status=='pending' ? 'selected' : '' }>Chờ
                                                xác nhận</option>
                                            <option value="confirmed" ${order.status=='confirmed' ? 'selected' : '' }>
                                                Xác nhận (Thành công)</option>
                                            <option value="cancelled" ${order.status=='cancelled' ? 'selected' : '' }>
                                                Hủy đơn</option>
                                        </select>
                                        <button type="submit" class="btn btn-primary">
                                            Cập nhật trạng thái
                                        </button>
                                    </form>
                                </div>

                                <%-- Danh sách sản phẩm --%>
                                    <div class="card-section">
                                        <h5><i class="bi bi-box-seam me-2"></i>Sản phẩm trong đơn</h5>
                                        <c:forEach var="item" items="${orderItems}">
                                            <div class="item-row">
                                                <img src="${pageContext.request.contextPath}/${item.product.imageUrl}"
                                                    class="item-img"
                                                    onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'" />
                                                <span class="item-name">${item.product.productName}</span>
                                                <span class="item-qty">x${item.quantity}</span>
                                                <span class="item-price">
                                                    <fmt:formatNumber
                                                        value="${item.price.doubleValue() * item.quantity}"
                                                        type="number" groupingUsed="true" />đ
                                                </span>
                                            </div>
                                        </c:forEach>

                                        <div class="total-row">
                                            <span>Tổng cộng</span>
                                            <span>
                                                <fmt:formatNumber value="${order.totalAmount}" type="number"
                                                    groupingUsed="true" />đ
                                            </span>
                                        </div>
                                    </div>

                </div>

                <%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>