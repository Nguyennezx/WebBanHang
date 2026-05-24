<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root { --primary: #1a73e8; --primary-dark: #0d47a1; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; }

        .cart-wrapper {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 16px;
        }

        .cart-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 20px;
        }

        .cart-table {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .cart-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .cart-table thead {
            background: var(--primary);
            color: #fff;
        }

        .cart-table thead th {
            padding: 14px 16px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .cart-table tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: background 0.2s;
        }

        .cart-table tbody tr:hover { background: #f8f9ff; }

        .cart-table tbody td {
            padding: 14px 16px;
            vertical-align: middle;
            font-size: 0.92rem;
        }

        .product-img {
            width: 65px;
            height: 65px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #eee;
        }

        .product-name {
            font-weight: 600;
            color: #222;
        }

        .qty-control {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .qty-control input {
            width: 55px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 4px 6px;
            font-size: 0.9rem;
        }

        .qty-control button {
            width: 28px;
            height: 28px;
            border: 1px solid #ddd;
            border-radius: 6px;
            background: #f5f5f5;
            cursor: pointer;
            font-size: 1rem;
            line-height: 1;
        }

        .qty-control button:hover { background: #e0e0e0; }

        .btn-remove {
            background: none;
            border: none;
            color: #e53935;
            font-size: 1.2rem;
            cursor: pointer;
            padding: 4px 8px;
            border-radius: 6px;
            transition: background 0.2s;
        }

        .btn-remove:hover { background: #fdecea; }

        .cart-summary {
            background: #fff;
            border-radius: 12px;
            padding: 20px 24px;
            margin-top: 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-label {
            font-size: 1rem;
            color: #555;
        }

        .total-amount {
            font-size: 1.5rem;
            font-weight: 700;
            color: #e53935;
        }

        .btn-checkout {
            background: var(--primary);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 12px 32px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
            text-decoration: none;
        }

        .btn-checkout:hover { background: var(--primary-dark); color: #fff; }

        .empty-cart {
            background: #fff;
            border-radius: 12px;
            padding: 60px 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .empty-cart i {
            font-size: 4rem;
            color: #ccc;
            margin-bottom: 16px;
        }

        .empty-cart p {
            font-size: 1rem;
            color: #888;
            margin-bottom: 20px;
        }

        .btn-shop {
            background: var(--primary);
            color: #fff;
            border-radius: 8px;
            padding: 10px 28px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.2s;
        }

        .btn-shop:hover { background: var(--primary-dark); color: #fff; }
        .delete-confirm-modal .modal-content {
            border: none;
            border-radius: 14px;
            box-shadow: 0 18px 50px rgba(20, 35, 60, 0.24);
        }
        .delete-confirm-modal .modal-body {
            padding: 28px 28px 22px;
            text-align: center;
        }
        .delete-confirm-icon {
            width: 58px;
            height: 58px;
            margin: 0 auto 14px;
            border-radius: 50%;
            background: #fff1f0;
            color: #d93025;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.65rem;
        }
        .delete-confirm-title {
            color: #1f2937;
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 8px;
        }
        .delete-confirm-text {
            color: #5f6b7a;
            font-size: 0.95rem;
            line-height: 1.6;
            margin: 0 auto 18px;
            max-width: 360px;
        }
        .delete-confirm-product {
            color: #1a73e8;
            font-weight: 700;
        }
        .delete-confirm-actions {
            display: flex;
            justify-content: center;
            gap: 12px;
            padding-top: 4px;
        }
        .btn-keep-item,
        .btn-confirm-delete {
            border: none;
            border-radius: 8px;
            padding: 10px 18px;
            font-weight: 700;
            min-width: 124px;
        }
        .btn-keep-item {
            background: #eef2f7;
            color: #334155;
        }
        .btn-keep-item:hover { background: #e2e8f0; }
        .btn-confirm-delete {
            background: #e53935;
            color: #fff;
            box-shadow: 0 8px 18px rgba(229, 57, 53, 0.24);
        }
        .btn-confirm-delete:hover { background: #c62828; }
    </style>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="cart-wrapper">
    <div class="cart-title">
        <i class="bi bi-cart3 me-2"></i>Giỏ hàng của tôi
    </div>

    <c:choose>
        <%-- Giỏ hàng trống --%>
        <c:when test="${empty cartItems}">
            <div class="empty-cart">
                <i class="bi bi-cart-x"></i>
                <p>Giỏ hàng của bạn đang trống!</p>
                <a href="${pageContext.request.contextPath}/products" class="btn-shop">
                    Tiếp tục mua sắm
                </a>
            </div>
        </c:when>

        <%-- Có sản phẩm trong giỏ --%>
        <c:otherwise>
            <div class="cart-table">
                <table>
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Tên</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <tr>
                                <%-- Ảnh sản phẩm --%>
                                <td>
                                    <img src="${pageContext.request.contextPath}/${item.product.imageUrl}"
                                         alt="${item.product.productName}"
                                         class="product-img"
                                         onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'"/>
                                </td>

                                <%-- Tên sản phẩm --%>
                                <td>
                                    <span class="product-name">${item.product.productName}</span>
                                </td>

                                <%-- Đơn giá --%>
                                <td>
                                    <fmt:formatNumber value="${item.product.price}"
                                                      type="number"
                                                      groupingUsed="true"/>đ
                                </td>

                                <%-- Số lượng --%>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart/update"
                                          method="post"
                                          class="qty-control">
                                        <input type="hidden" name="cartId" value="${item.cartId}"/>
                                        <button type="submit" name="quantity"
                                                value="${item.quantity - 1}">−</button>
                                        <input type="text"
                                               value="${item.quantity}"
                                               readonly/>
                                        <button type="submit" name="quantity"
                                                value="${item.quantity + 1}">+</button>
                                    </form>
                                </td>

                                <%-- Thành tiền --%>
                                <td style="color:#e53935; font-weight:600;">
                                    <fmt:formatNumber
                                        value="${item.product.price.doubleValue() * item.quantity}"
                                        type="number"
                                        groupingUsed="true"/>đ
                                </td>

                                <%-- Xóa --%>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart/remove"
                                          method="post"
                                          class="remove-form">
                                        <input type="hidden" name="cartId" value="${item.cartId}"/>
                                        <button type="submit" class="btn-remove"
                                                data-product-name="<c:out value='${item.product.productName}'/>"
                                                title="Xoa san pham">
                                            <i class="bi bi-trash3"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <%-- Tổng tiền + nút đặt hàng --%>
            <div class="cart-summary">
                <div>
                    <div class="total-label">Tổng tiền thanh toán:</div>
                    <div class="total-amount">
                        <fmt:formatNumber value="${total}"
                                          type="number"
                                          groupingUsed="true"/>đ
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/order/checkout"
                   class="btn-checkout">
                    <i class="bi bi-bag-check me-2"></i>Đặt hàng
                </a>
            </div>

        </c:otherwise>
    </c:choose>
</div>

<div class="modal fade delete-confirm-modal" id="deleteConfirmModal" tabindex="-1"
     aria-labelledby="deleteConfirmTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
                <div class="delete-confirm-icon">
                    <i class="bi bi-trash3-fill"></i>
                </div>
                <div class="delete-confirm-title" id="deleteConfirmTitle">
                    X&#225;c nh&#7853;n x&#243;a s&#7843;n ph&#7849;m
                </div>
                <p class="delete-confirm-text">
                    B&#7841;n c&#243; mu&#7889;n x&#243;a
                    <span class="delete-confirm-product" id="deleteProductName">s&#7843;n ph&#7849;m n&#224;y</span>
                    kh&#7887;i gi&#7887; h&#224;ng kh&#244;ng?
                </p>
                <div class="delete-confirm-actions">
                    <button type="button" class="btn-keep-item" data-bs-dismiss="modal">
                        Gi&#7919; l&#7841;i
                    </button>
                    <button type="button" class="btn-confirm-delete" id="confirmDeleteBtn">
                        X&#243;a s&#7843;n ph&#7849;m
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    let pendingDeleteForm = null;
    const deleteModalElement = document.getElementById("deleteConfirmModal");
    const deleteModal = deleteModalElement ? new bootstrap.Modal(deleteModalElement) : null;
    const deleteProductName = document.getElementById("deleteProductName");
    const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");

    document.querySelectorAll(".remove-form").forEach(function(form) {
        form.addEventListener("submit", function(event) {
            if (!deleteModal) {
                return;
            }

            event.preventDefault();
            pendingDeleteForm = form;

            const button = form.querySelector(".btn-remove");
            const productName = button ? button.getAttribute("data-product-name") : "";
            deleteProductName.textContent = productName || "s\u1ea3n ph\u1ea9m n\u00e0y";

            deleteModal.show();
        });
    });

    if (confirmDeleteBtn) {
        confirmDeleteBtn.addEventListener("click", function() {
            if (pendingDeleteForm) {
                confirmDeleteBtn.disabled = true;
                confirmDeleteBtn.textContent = "\u0110ang x\u00f3a...";
                pendingDeleteForm.submit();
            }
        });
    }

    if (deleteModalElement) {
        deleteModalElement.addEventListener("hidden.bs.modal", function() {
            pendingDeleteForm = null;
            if (confirmDeleteBtn) {
                confirmDeleteBtn.disabled = false;
                confirmDeleteBtn.textContent = "X\u00f3a s\u1ea3n ph\u1ea9m";
            }
        });
    }

    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('deleted') === 'true') {
        showToast("Đã xóa sản phẩm khỏi giỏ hàng thành công!");
        window.history.replaceState({}, document.title, window.location.pathname);
    } else if (urlParams.get('updated') === 'true') {
        showToast("Đã cập nhật số lượng sản phẩm!");
        window.history.replaceState({}, document.title, window.location.pathname);
    }
});
</script>
</body>
</html>
