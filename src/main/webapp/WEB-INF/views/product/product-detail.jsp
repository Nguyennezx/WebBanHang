<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #1a73e8;
            --primary-dark: #0d47a1;
            --danger: #dc2626;
            --warning: #fbbf24;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f2f5;
        }

        /* ===== BREADCRUMB ===== */
        .breadcrumb-section {
            background: white;
            padding: 16px 0;
            border-bottom: 1px solid #e5e7eb;
            margin-bottom: 24px;
        }

        .breadcrumb {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
            font-size: 13px;
            color: #6b7280;
        }

        .breadcrumb a {
            color: #1a73e8;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        /* ===== MAIN CONTAINER ===== */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px 40px 20px;
        }

        .product-detail-container {
            background: white;
            border-radius: 8px;
            padding: 24px;
            display: grid;
            grid-template-columns: 450px 1fr;
            gap: 32px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
        }

        /* ===== LEFT SECTION: IMAGES ===== */
        .product-images {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .main-image-container {
            background: #f3f4f6;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        .main-image-container img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            padding: 20px;
        }

        .discount-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: var(--danger);
            color: white;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 700;
        }

        .thumbnail-images {
            display: flex;
            gap: 8px;
            overflow-x: auto;
            padding-bottom: 8px;
        }

        .thumbnail {
            width: 60px;
            height: 60px;
            border: 2px solid #e5e7eb;
            border-radius: 6px;
            cursor: pointer;
            background: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            transition: all 0.3s;
        }

        .thumbnail:hover,
        .thumbnail.active {
            border-color: var(--primary);
            background: white;
        }

        .thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            padding: 4px;
        }

        /* ===== RIGHT SECTION: PRODUCT INFO ===== */
        .product-info {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .product-brand {
            font-size: 12px;
            color: #9ca3af;
            text-transform: uppercase;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .product-name {
            font-size: 24px;
            font-weight: 700;
            color: #1f2937;
            line-height: 1.3;
        }

        .product-rating {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 14px;
        }

        .stars {
            color: #f59e0b;
            font-size: 16px;
        }

        .rating-count {
            color: #6b7280;
            font-size: 13px;
        }

        /* PRICE BOX */
        .price-box {
            background: #fef3c7;
            border: 1px solid #fcd34d;
            border-radius: 8px;
            padding: 16px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .current-price {
            font-size: 28px;
            font-weight: 700;
            color: var(--danger);
        }

        .old-price {
            font-size: 16px;
            color: #9ca3af;
            text-decoration: line-through;
        }

        .discount-percent {
            background: var(--danger);
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 700;
            white-space: nowrap;
        }

        /* STOCK INFO */
        .stock-info {
            background: #dcfce7;
            border: 1px solid #86efac;
            border-radius: 8px;
            padding: 12px 16px;
            color: #166534;
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .stock-info i {
            font-size: 16px;
        }

        /* DESCRIPTION */
        .description-box {
            border-top: 1px solid #e5e7eb;
            border-bottom: 1px solid #e5e7eb;
            padding: 16px 0;
        }

        .description-title {
            font-size: 13px;
            font-weight: 700;
            color: var(--danger);
            margin-bottom: 8px;
            text-transform: uppercase;
        }

        .description-text {
            font-size: 13px;
            color: #6b7280;
            line-height: 1.6;
        }

        /* QUANTITY SELECTOR */
        .quantity-section {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .quantity-label {
            font-size: 13px;
            font-weight: 600;
            color: #1f2937;
            min-width: 70px;
        }

        .quantity-input {
            display: flex;
            align-items: center;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            height: 36px;
        }

        .quantity-input button {
            width: 36px;
            height: 36px;
            border: none;
            background: white;
            cursor: pointer;
            font-weight: 600;
            color: #6b7280;
            transition: all 0.2s;
        }

        .quantity-input button:hover {
            color: var(--primary);
        }

        .quantity-input input {
            width: 50px;
            height: 36px;
            border: none;
            text-align: center;
            font-weight: 600;
            font-size: 14px;
            outline: none;
        }

        /* ACTION BUTTONS */
        .action-buttons {
            display: flex;
            gap: 12px;
        }

        .btn-action {
            flex: 1;
            padding: 12px 16px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .btn-cart {
            background: var(--primary);
            color: white;
        }

        .btn-cart:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(26, 115, 232, 0.3);
        }

        .btn-buy {
            background: #fbbf24;
            color: #000;
        }

        .btn-buy:hover {
            background: #f59e0b;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(251, 191, 36, 0.3);
        }

        /* ===== RELATED PRODUCTS ===== */
        .related-section {
            margin-top: 40px;
            padding-top: 32px;
            border-top: 2px solid #e5e7eb;
        }

        .related-title {
            font-size: 18px;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 20px;
        }

        .related-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 16px;
        }

        .related-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            overflow: hidden;
            cursor: pointer;
            transition: all 0.3s;
        }

        .related-card:hover {
            border-color: var(--primary);
            box-shadow: 0 8px 24px rgba(26, 115, 232, 0.15);
            transform: translateY(-4px);
        }

        .related-image {
            background: #f3f4f6;
            height: 180px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .related-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .related-info {
            padding: 12px;
        }

        .related-brand {
            font-size: 11px;
            color: #9ca3af;
            text-transform: uppercase;
            font-weight: 500;
            margin-bottom: 4px;
        }

        .related-name {
            font-size: 13px;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 8px;
            line-height: 1.3;
            min-height: 32px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .related-price {
            font-size: 14px;
            font-weight: 700;
            color: var(--danger);
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 1024px) {
            .product-detail-container {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .main-container {
                padding: 0 12px 24px 12px;
            }

            .product-detail-container {
                padding: 16px;
                gap: 16px;
            }

            .main-image-container {
                height: 300px;
            }

            .product-name {
                font-size: 18px;
            }

            .current-price {
                font-size: 24px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .related-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 12px;
            }
        }
    </style>
</head>
<body>

<!-- ===== INCLUDE HEADER (FILE CHUNG) ===== -->
<jsp:include page="../common/header.jsp" />

<!-- ===== BREADCRUMB ===== -->
<div class="breadcrumb-section">
    <div class="breadcrumb">
        <a href="/WebBanHang/products">Sản Phẩm</a> > 
        <c:if test="${product.category != null}">
            <a href="/WebBanHang/products?categoryId=${product.category.categoryId}">
                ${product.category.categoryName}
            </a> > 
        </c:if>
        <span>${product.productName}</span>
    </div>
</div>

<!-- ===== MAIN CONTAINER ===== -->
<div class="main-container">
    <!-- PRODUCT DETAIL -->
    <div class="product-detail-container">
        <!-- LEFT: IMAGES -->
        <div class="product-images">
            <div class="main-image-container">
    <img id="mainImage" 
src="${pageContext.request.contextPath}${product.imageUrl}"
        alt="${product.productName}"
        onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'">
</div>

            
        </div>

        <!-- RIGHT: PRODUCT INFO -->
        <div class="product-info">
            <p class="product-brand">${product.brand.brandName}</p>
            <h1 class="product-name">${product.productName}</h1>

            <div class="product-rating">
                <span class="stars">★★★★☆</span>
                <span class="rating-count">4.8 (248 đánh giá)</span>
            </div>

            <!-- PRICE BOX -->
            <div class="mb-3">
    <span class="current-price">
        <fmt:formatNumber value="${product.price}" type="currency" 
                        currencySymbol="" maxFractionDigits="0"/>đ
    </span>
</div>

           
            <!-- DESCRIPTION -->
            <div class="description-box">
                <div class="description-title">Mô tả sản phẩm</div>
                <div class="description-text">
                    ${product.description != null ? product.description : 'Sản phẩm chính hãng, bảo hành 12 tháng. Đảm bảo chất lượng tốt nhất.'}
                </div>
            </div>

            <!-- QUANTITY SELECTOR -->
            <div class="quantity-section">
                <span class="quantity-label">Số lượng:</span>
                <div class="quantity-input">
                    <button onclick="decreaseQty()">−</button>
                    <input type="number" id="qty" value="1" min="1" max="${product.quantityStock}">
                    <button onclick="increaseQty()">+</button>
                </div>
            </div>

            <!-- ACTION BUTTONS -->
            <div class="action-buttons">
                <button class="btn-action btn-cart" onclick="addToCart()">
                    <i class="fas fa-shopping-cart"></i> Thêm vào giỏ
                </button>
                <button class="btn-action btn-buy" onclick="buyNow()">
                    <i class="fas fa-bolt"></i> Mua ngay
                </button>
            </div>
        </div>
    </div>

    <!-- RELATED PRODUCTS -->
    <c:if test="${not empty relatedProducts}">
        <div class="related-section">
            <h2 class="related-title">Sản phẩm liên quan</h2>
            <div class="related-grid">
                <c:forEach var="related" items="${relatedProducts}">
                    <div class="related-card" onclick="window.location='/WebBanHang/products/${related.productId}'">
                        <div class="related-image">
                            <img src="${pageContext.request.contextPath}${related.imageUrl}"
     alt="${related.productName}"
     onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'">
                        </div>
                        <div class="related-info">
                            <p class="related-brand">${related.brand.brandName}</p>
                            <p class="related-name">${related.productName}</p>
                            <p class="related-price">
                                <fmt:formatNumber value="${related.price}" type="currency" 
                                                currencySymbol="" maxFractionDigits="0"/>đ
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
</div>

<!-- ===== INCLUDE FOOTER (FILE CHUNG) ===== -->
<jsp:include page="../common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Thay đổi ảnh chính
    function changeImage(element) {
        document.querySelectorAll('.thumbnail').forEach(el => el.classList.remove('active'));
        element.classList.add('active');
        
        const imgSrc = element.querySelector('img').src;
        document.getElementById('mainImage').src = imgSrc;
    }

    // Giảm số lượng
    function decreaseQty() {
        const input = document.getElementById('qty');
        if (parseInt(input.value) > 1) {
            input.value = parseInt(input.value) - 1;
        }
    }

    // Tăng số lượng
    function increaseQty() {
        const input = document.getElementById('qty');
        const max = parseInt(input.max);
        if (parseInt(input.value) < max) {
            input.value = parseInt(input.value) + 1;
        }
    }

    // Thêm vào giỏ
    function addToCart() {
        const qty = document.getElementById('qty').value;
        addToCartGlobal(${product.productId}, qty);
    }

    // Mua ngay
    function buyNow() {
        const qty = document.getElementById('qty').value;
        const productId = ${product.productId};
        const contextPath = "${pageContext.request.contextPath}";

        const params = new URLSearchParams();
        params.append("productId", productId);
        params.append("quantity", qty);

        fetch(contextPath + "/cart/add-ajax", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
            },
            body: params.toString()
        })
        .then(response => response.text())
        .then(data => {
            if (data === "not_logged_in") {
                showToast("Vui lòng đăng nhập để mua ngay!", "error");
                setTimeout(() => {
                    window.location.href = contextPath + "/login";
                }, 1000);
            } else if (data === "product_not_found") {
                showToast("Không tìm thấy sản phẩm này!", "error");
            } else if (data.startsWith("success:")) {
                // Chuyển hướng trực tiếp tới trang checkout
                window.location.href = contextPath + "/order/checkout";
            } else {
                showToast("Có lỗi xảy ra khi xử lý mua ngay!", "error");
            }
        })
        .catch(error => {
            console.error("Error in buyNow:", error);
            showToast("Lỗi kết nối hệ thống!", "error");
        });
    }
</script>
<!-- ✅ THÊM SCRIPT NÀY -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Xử lý dropdown thủ công
    const dropdownToggles = document.querySelectorAll('.dropdown-toggle');
    
    dropdownToggles.forEach(toggle => {
        toggle.addEventListener('click', function(e) {
            e.preventDefault();
            console.log("✅ Dropdown clicked!");
            
            const menu = this.nextElementSibling;
            if (menu && menu.classList.contains('dropdown-menu')) {
                menu.classList.toggle('show');
                this.setAttribute('aria-expanded', this.getAttribute('aria-expanded') === 'true' ? 'false' : 'true');
            }
        });
    });
    
    // Đóng dropdown khi click ngoài
    document.addEventListener('click', function(e) {
        dropdownToggles.forEach(toggle => {
            if (!toggle.contains(e.target) && !toggle.nextElementSibling.contains(e.target)) {
                toggle.nextElementSibling.classList.remove('show');
                toggle.setAttribute('aria-expanded', 'false');
            }
        });
    });
});
</script>
</body>
</html>
