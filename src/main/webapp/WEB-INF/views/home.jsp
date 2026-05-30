<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
    /* ========== GOOGLE FONT ========== */
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

    body { font-family: 'Inter', 'Segoe UI', sans-serif; }

    /* ========== HERO BANNER SLIDER ========== */
    .hero-section {
        position: relative;
        overflow: hidden;
        background: linear-gradient(135deg, #0d47a1 0%, #1a73e8 50%, #42a5f5 100%);
        min-height: 420px;
    }

    .hero-slider {
        display: flex;
        transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    .hero-slide {
        min-width: 100%;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 40px 80px;
        min-height: 420px;
        position: relative;
    }

    .slide-1 { background: linear-gradient(135deg, #0d47a1 0%, #1565c0 60%, #1976d2 100%); }
    .slide-2 { background: linear-gradient(135deg, #1a237e 0%, #283593 60%, #303f9f 100%); }
    .slide-3 { background: linear-gradient(135deg, #004d40 0%, #00695c 60%, #00796b 100%); }

    .hero-content { flex: 1; color: #fff; z-index: 2; }

    .hero-badge {
        display: inline-block;
        background: rgba(255,213,79,0.2);
        border: 1.5px solid #ffd54f;
        color: #ffd54f;
        font-size: 0.75rem;
        font-weight: 700;
        letter-spacing: 1px;
        text-transform: uppercase;
        padding: 4px 14px;
        border-radius: 20px;
        margin-bottom: 16px;
    }

    .hero-title {
        font-size: 2.6rem;
        font-weight: 800;
        line-height: 1.2;
        margin-bottom: 14px;
        text-shadow: 0 2px 8px rgba(0,0,0,0.2);
    }

    .hero-title span { color: #ffd54f; }

    .hero-desc {
        font-size: 1rem;
        opacity: 0.88;
        margin-bottom: 28px;
        max-width: 440px;
        line-height: 1.6;
    }

    .hero-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: #ffd54f;
        color: #0d47a1;
        font-weight: 700;
        font-size: 0.95rem;
        padding: 13px 30px;
        border-radius: 50px;
        text-decoration: none;
        transition: all 0.3s ease;
        box-shadow: 0 4px 20px rgba(255,213,79,0.4);
    }
    .hero-btn:hover {
        background: #fff;
        color: #0d47a1;
        transform: translateY(-2px);
        box-shadow: 0 8px 24px rgba(0,0,0,0.2);
    }

    .hero-image-side {
        flex: 0 0 360px;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
    }

    .hero-phone-mockup {
        width: 200px;
        height: 360px;
        background: rgba(255,255,255,0.1);
        border: 2px solid rgba(255,255,255,0.3);
        border-radius: 32px;
        backdrop-filter: blur(10px);
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: 12px;
        animation: float 3s ease-in-out infinite;
        box-shadow: 0 20px 60px rgba(0,0,0,0.3), inset 0 1px 0 rgba(255,255,255,0.2);
    }

    .hero-phone-mockup i {
        font-size: 5rem;
        color: rgba(255,255,255,0.9);
    }

    .hero-phone-mockup .price-tag {
        background: #ffd54f;
        color: #0d47a1;
        font-weight: 800;
        font-size: 1.1rem;
        padding: 6px 18px;
        border-radius: 20px;
    }

    @keyframes float {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-12px); }
    }

    /* Slider Controls */
    .hero-controls {
        position: absolute;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        gap: 8px;
        z-index: 10;
    }

    .hero-dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background: rgba(255,255,255,0.45);
        cursor: pointer;
        transition: all 0.3s;
        border: none;
        padding: 0;
    }

    .hero-dot.active {
        width: 28px;
        border-radius: 4px;
        background: #ffd54f;
    }

    .hero-arrow {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        background: rgba(255,255,255,0.15);
        border: 1.5px solid rgba(255,255,255,0.3);
        color: #fff;
        width: 44px;
        height: 44px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        font-size: 1.1rem;
        transition: all 0.3s;
        z-index: 10;
        backdrop-filter: blur(4px);
    }
    .hero-arrow:hover { background: rgba(255,255,255,0.3); transform: translateY(-50%) scale(1.1); }
    .hero-arrow.prev { left: 20px; }
    .hero-arrow.next { right: 20px; }

    /* ========== STATS BAR ========== */
    .stats-bar {
        background: #fff;
        border-bottom: 1px solid #e8ecf0;
        padding: 16px 0;
    }

    .stat-item {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 0 24px;
        border-right: 1px solid #e8ecf0;
    }
    .stat-item:last-child { border-right: none; }

    .stat-icon {
        width: 44px;
        height: 44px;
        border-radius: 12px;
        background: linear-gradient(135deg, #e3f2fd, #bbdefb);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #1a73e8;
        font-size: 1.3rem;
        flex-shrink: 0;
    }

    .stat-text strong {
        display: block;
        font-size: 0.95rem;
        font-weight: 700;
        color: #1a1a2e;
    }
    .stat-text span {
        font-size: 0.78rem;
        color: #777;
    }

    /* ========== SECTION TIÊU ĐỀ ========== */
    .section-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 24px;
    }

    .section-title {
        font-size: 1.4rem;
        font-weight: 800;
        color: #1a1a2e;
        position: relative;
        padding-left: 16px;
    }

    .section-title::before {
        content: '';
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 4px;
        height: 80%;
        background: linear-gradient(180deg, #1a73e8, #0d47a1);
        border-radius: 2px;
    }

    .section-link {
        color: #1a73e8;
        font-size: 0.88rem;
        font-weight: 600;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 4px;
        transition: gap 0.2s;
    }
    .section-link:hover { gap: 8px; color: #0d47a1; }

    /* ========== DANH MỤC GRID ========== */
    .category-section { background: #fff; padding: 36px 0; margin-bottom: 8px; }

    .category-grid {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    .category-card {
        flex: 1;
        min-width: 130px;
        max-width: 160px;
        background: #f8f9fc;
        border: 1.5px solid #e8ecf0;
        border-radius: 16px;
        padding: 20px 12px;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 10px;
        text-decoration: none;
        color: #333;
        transition: all 0.3s ease;
        cursor: pointer;
    }

    .category-card:hover {
        border-color: #1a73e8;
        background: linear-gradient(135deg, #e8f0fe, #fff);
        transform: translateY(-4px);
        box-shadow: 0 8px 24px rgba(26,115,232,0.15);
        color: #1a73e8;
    }

    .category-icon {
        width: 56px;
        height: 56px;
        border-radius: 16px;
        background: linear-gradient(135deg, #1a73e8, #0d47a1);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.6rem;
        color: #fff;
        transition: transform 0.3s;
    }

    .category-card:hover .category-icon { transform: scale(1.1) rotate(-5deg); }

    .category-name {
        font-size: 0.82rem;
        font-weight: 600;
        text-align: center;
        line-height: 1.3;
    }

    /* ========== BANNER GIỮA TRANG ========== */
    .promo-banner {
        background: linear-gradient(135deg, #ff6f00, #ff8f00, #ffa000);
        border-radius: 20px;
        padding: 28px 36px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin: 32px 0;
        overflow: hidden;
        position: relative;
    }

    .promo-banner::before {
        content: '';
        position: absolute;
        top: -40px;
        right: -40px;
        width: 200px;
        height: 200px;
        background: rgba(255,255,255,0.08);
        border-radius: 50%;
    }

    .promo-banner::after {
        content: '';
        position: absolute;
        bottom: -60px;
        right: 80px;
        width: 160px;
        height: 160px;
        background: rgba(255,255,255,0.05);
        border-radius: 50%;
    }

    .promo-content { z-index: 1; }

    .promo-badge {
        display: inline-block;
        background: rgba(255,255,255,0.25);
        color: #fff;
        font-size: 0.72rem;
        font-weight: 700;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        padding: 4px 12px;
        border-radius: 20px;
        margin-bottom: 10px;
    }

    .promo-title {
        font-size: 1.7rem;
        font-weight: 800;
        color: #fff;
        margin-bottom: 6px;
        text-shadow: 0 2px 8px rgba(0,0,0,0.15);
    }

    .promo-desc {
        color: rgba(255,255,255,0.9);
        font-size: 0.92rem;
        margin-bottom: 18px;
    }

    .promo-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: #fff;
        color: #ff6f00;
        font-weight: 700;
        font-size: 0.9rem;
        padding: 11px 24px;
        border-radius: 50px;
        text-decoration: none;
        transition: all 0.3s;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    .promo-btn:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,0.2); color: #e65100; }

    .promo-image-side {
        font-size: 6rem;
        opacity: 0.3;
        z-index: 1;
        animation: float 3.5s ease-in-out infinite;
    }

    /* ========== PRODUCT CARDS ========== */
    .products-section { padding: 36px 0; }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 16px;
    }

    .product-card {
        background: #fff;
        border: 1.5px solid #e8ecf0;
        border-radius: 16px;
        overflow: hidden;
        transition: all 0.3s ease;
        cursor: pointer;
        text-decoration: none;
        color: inherit;
        display: block;
        position: relative;
    }

    .product-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 16px 40px rgba(26,115,232,0.15);
        border-color: #1a73e8;
        color: inherit;
    }

    .product-card-badge {
        position: absolute;
        top: 12px;
        left: 12px;
        background: linear-gradient(135deg, #ff3d00, #ff6e40);
        color: #fff;
        font-size: 0.7rem;
        font-weight: 700;
        padding: 3px 10px;
        border-radius: 20px;
        z-index: 2;
        letter-spacing: 0.5px;
    }

    .product-img-wrap {
        position: relative;
        background: linear-gradient(135deg, #f8f9fc, #e8ecf0);
        height: 200px;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
    }

    .product-img-wrap img {
        width: 100%;
        height: 100%;
        object-fit: contain;
        padding: 12px;
        transition: transform 0.4s ease;
    }

    .product-card:hover .product-img-wrap img { transform: scale(1.06); }

    .product-img-placeholder {
        font-size: 4rem;
        color: #bdbdbd;
        transition: transform 0.4s ease;
    }

    .product-card:hover .product-img-placeholder { transform: scale(1.06); }

    .product-info {
        padding: 14px 16px 16px;
    }

    .product-category-tag {
        display: inline-block;
        background: #e3f2fd;
        color: #1565c0;
        font-size: 0.7rem;
        font-weight: 600;
        padding: 2px 8px;
        border-radius: 6px;
        margin-bottom: 6px;
    }

    .product-name {
        font-size: 0.9rem;
        font-weight: 600;
        color: #1a1a2e;
        margin-bottom: 10px;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        line-height: 1.4;
    }

    .product-price-wrap {
        display: flex;
        align-items: center;
        gap: 8px;
        flex-wrap: wrap;
    }

    .product-price {
        font-size: 1.05rem;
        font-weight: 800;
        color: #e53935;
    }

    .product-price-original {
        font-size: 0.8rem;
        color: #aaa;
        text-decoration: line-through;
    }

    .product-btn-cart {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        width: 100%;
        margin-top: 10px;
        background: linear-gradient(135deg, #1a73e8, #0d47a1);
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 9px;
        font-size: 0.85rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        text-decoration: none;
    }
    .product-btn-cart:hover {
        background: linear-gradient(135deg, #0d47a1, #0a2e6e);
        color: #fff;
        transform: none;
    }

    /* Empty state */
    .empty-products {
        text-align: center;
        padding: 60px 20px;
        color: #999;
        grid-column: 1 / -1;
    }
    .empty-products i { font-size: 4rem; margin-bottom: 16px; opacity: 0.3; }

    /* ========== BRAND SECTION ========== */
    .brands-section {
        background: #fff;
        padding: 36px 0;
        border-top: 1px solid #e8ecf0;
    }

    .brands-grid {
        display: flex;
        gap: 16px;
        flex-wrap: wrap;
        align-items: center;
        justify-content: center;
    }

    .brand-card {
        flex: 0 0 140px;
        background: #f8f9fc;
        border: 1.5px solid #e8ecf0;
        border-radius: 14px;
        padding: 18px 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 8px;
        text-decoration: none;
        color: #555;
        font-weight: 600;
        font-size: 0.88rem;
        transition: all 0.3s;
    }
    .brand-card:hover {
        border-color: #1a73e8;
        background: #e8f0fe;
        color: #1a73e8;
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(26,115,232,0.15);
    }

    .brand-icon {
        width: 48px;
        height: 48px;
        border-radius: 12px;
        background: linear-gradient(135deg, #e3f2fd, #bbdefb);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: #1a73e8;
    }

    /* ========== RESPONSIVE ========== */
    @media (max-width: 992px) {
        .hero-slide { padding: 40px 40px; }
        .hero-image-side { flex: 0 0 240px; }
        .hero-phone-mockup { width: 140px; height: 260px; }
        .hero-title { font-size: 2rem; }
        .product-grid { grid-template-columns: repeat(3, 1fr); }
    }

    @media (max-width: 768px) {
        .hero-image-side { display: none; }
        .hero-slide { padding: 40px 24px; }
        .hero-title { font-size: 1.7rem; }
        .product-grid { grid-template-columns: repeat(2, 1fr); }
        .promo-image-side { display: none; }
    }

    @media (max-width: 480px) {
        .product-grid { grid-template-columns: 1fr 1fr; gap: 10px; }
    }
    /* Ảnh sản phẩm trong hero banner */
.hero-product-showcase {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 14px;
    animation: float 3s ease-in-out infinite;
}

.hero-product-showcase img {
    width: 220px;
    height: 280px;
    object-fit: contain;
    filter: drop-shadow(0 20px 40px rgba(0,0,0,0.4));
    border-radius: 16px;
}

.hero-product-showcase .price-tag {
    background: #ffd54f;
    color: #0d47a1;
    font-weight: 800;
    font-size: 1.05rem;
    padding: 7px 20px;
    border-radius: 20px;
    white-space: nowrap;
}
</style>

<!-- ========== HERO BANNER ========== -->
<section class="hero-section">
    <div class="hero-slider" id="heroSlider">

        <%-- Slide 1: Tổng quát --%>
<div class="hero-slide slide-1">
    <div class="hero-content">
        <span class="hero-badge">🔥 Hàng mới về liên tục</span>
        <h1 class="hero-title">Công nghệ <span>chính hãng</span><br>giá tốt nhất!</h1>
        <p class="hero-desc">Hàng trăm sản phẩm công nghệ chính hãng. Bảo hành đầy đủ, giao hàng nhanh toàn quốc.</p>
        <a href="${pageContext.request.contextPath}/products" class="hero-btn">
            <i class="bi bi-bag-heart-fill"></i>
            Mua ngay
        </a>
    </div>
    <div class="hero-image-side">
        <c:choose>
            <c:when test="${not empty cheapestProduct and not empty cheapestProduct.imageUrl}">
                <div class="hero-product-showcase">
                    <img src="${pageContext.request.contextPath}${cheapestProduct.imageUrl}"
                         alt="${cheapestProduct.productName}"
                         onerror="this.parentElement.innerHTML='<i class=\'bi bi-box-seam\' style=\'font-size:5rem;color:rgba(255,255,255,0.8)\'></i>'">
                    <span class="price-tag">
                        Từ <fmt:formatNumber value="${cheapestProduct.price}" type="number" groupingUsed="true"/>₫
                    </span>
                </div>
            </c:when>
            <c:otherwise>
                <div class="hero-phone-mockup">
                    <i class="bi bi-box-seam"></i>
                    <c:if test="${not empty cheapestProduct}">
                        <span class="price-tag">
                            Từ <fmt:formatNumber value="${cheapestProduct.price}" type="number" groupingUsed="true"/>₫
                        </span>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%-- Slide 2: Chất lượng --%>
<div class="hero-slide slide-2">
    <div class="hero-content">
        <span class="hero-badge">🛡️ Cam kết chính hãng</span>
        <h1 class="hero-title">Sản phẩm <span>chất lượng</span><br>bảo hành chu đáo</h1>
        <p class="hero-desc">Tất cả sản phẩm đều có tem chính hãng. Bảo hành 12-24 tháng. Hỗ trợ kỹ thuật tận nơi.</p>
        <a href="${pageContext.request.contextPath}/products" class="hero-btn">
            <i class="bi bi-arrow-right-circle-fill"></i>
            Khám phá ngay
        </a>
    </div>
    <div class="hero-image-side">
        <div class="hero-phone-mockup" style="width:220px; height:220px; border-radius:50%;">
            <i class="bi bi-shield-check-fill" style="font-size:5rem;"></i>
        </div>
    </div>
</div>

<%-- Slide 3: Giao hàng --%>
<div class="hero-slide slide-3">
    <div class="hero-content">
        <span class="hero-badge">🚀 Giao hàng siêu tốc</span>
        <h1 class="hero-title">Đặt hàng online<br><span>nhận ngay tại nhà</span></h1>
        <p class="hero-desc">Giao hàng toàn quốc trong 24 giờ. Miễn phí đổi trả trong 7 ngày nếu có lỗi sản xuất.</p>
        <a href="${pageContext.request.contextPath}/products" class="hero-btn">
            <i class="bi bi-lightning-charge-fill"></i>
            Xem tất cả
        </a>
    </div>
    <div class="hero-image-side">
        <div class="hero-phone-mockup" style="width:220px; height:220px; border-radius:50%;">
            <i class="bi bi-truck" style="font-size:5rem;"></i>
        </div>
    </div>
</div>
    </div>

    <!-- Arrows -->
    <button class="hero-arrow prev" onclick="changeSlide(-1)">
        <i class="bi bi-chevron-left"></i>
    </button>
    <button class="hero-arrow next" onclick="changeSlide(1)">
        <i class="bi bi-chevron-right"></i>
    </button>

    <!-- Dots -->
    <div class="hero-controls">
        <button class="hero-dot active" onclick="goToSlide(0)"></button>
        <button class="hero-dot" onclick="goToSlide(1)"></button>
        <button class="hero-dot" onclick="goToSlide(2)"></button>
    </div>
</section>

<!-- ========== STATS BAR ========== -->
<section class="stats-bar">
    <div class="container">
        <div class="row g-0">
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <div class="stat-icon"><i class="bi bi-truck"></i></div>
                    <div class="stat-text">
                        <strong>Giao hàng siêu tốc</strong>
                        <span>Trong vòng 24 giờ</span>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <div class="stat-icon" style="background:linear-gradient(135deg,#e8f5e9,#c8e6c9); color:#2e7d32;">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <div class="stat-text">
                        <strong>Hàng chính hãng</strong>
                        <span>Bảo hành 12-24 tháng</span>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <div class="stat-icon" style="background:linear-gradient(135deg,#fff3e0,#ffe0b2); color:#e65100;">
                        <i class="bi bi-arrow-counterclockwise"></i>
                    </div>
                    <div class="stat-text">
                        <strong>Đổi trả dễ dàng</strong>
                        <span>Miễn phí trong 7 ngày</span>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="stat-item">
                    <div class="stat-icon" style="background:linear-gradient(135deg,#fce4ec,#f8bbd0); color:#c62828;">
                        <i class="bi bi-headset"></i>
                    </div>
                    <div class="stat-text">
                        <strong>Hỗ trợ 24/7</strong>
                        <span>Tổng đài: 0339297217</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ========== DANH MỤC NỔI BẬT ========== -->
<section class="category-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Danh mục sản phẩm</h2>
            <a href="${pageContext.request.contextPath}/products" class="section-link">
                Xem tất cả <i class="bi bi-arrow-right"></i>
            </a>
        </div>

        <c:if test="${not empty categories}">
            <div class="category-grid">
                <%-- Icon theo thứ tự danh mục --%>
                <c:set var="icons" value="phone,laptop,headphones,smartwatch,camera,tablet,earbuds,keyboard,mouse,speaker,tv,gamepad" />
                <c:forEach var="cat" items="${categories}" varStatus="loop">
                    <a href="${pageContext.request.contextPath}/products/category/${cat.categoryId}" class="category-card">
                        <div class="category-icon">
                            <c:choose>
                                <c:when test="${loop.index == 0}"><i class="bi bi-phone-fill"></i></c:when>
                                <c:when test="${loop.index == 1}"><i class="bi bi-laptop-fill"></i></c:when>
                                <c:when test="${loop.index == 2}"><i class="bi bi-headphones"></i></c:when>
                                <c:when test="${loop.index == 3}"><i class="bi bi-watch"></i></c:when>
                                <c:when test="${loop.index == 4}"><i class="bi bi-camera-fill"></i></c:when>
                                <c:when test="${loop.index == 5}"><i class="bi bi-tablet-fill"></i></c:when>
                                <c:when test="${loop.index == 6}"><i class="bi bi-speaker-fill"></i></c:when>
                                <c:otherwise><i class="bi bi-grid-fill"></i></c:otherwise>
                            </c:choose>
                        </div>
                        <span class="category-name">${cat.categoryName}</span>
                    </a>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${empty categories}">
            <p class="text-center text-muted py-3">Chưa có danh mục nào.</p>
        </c:if>
    </div>
</section>

<!-- ========== SẢN PHẨM NỔI BẬT ========== -->
<section class="products-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">🔥 Sản phẩm nổi bật</h2>
            <a href="${pageContext.request.contextPath}/products" class="section-link">
                Xem tất cả <i class="bi bi-arrow-right"></i>
            </a>
        </div>

        <div class="product-grid">
            <c:choose>
                <c:when test="${not empty featuredProducts}">
                    <c:forEach var="p" items="${featuredProducts}">
                        <a href="${pageContext.request.contextPath}/products/${p.productId}" class="product-card">
                            <c:if test="${p.productId % 3 == 0}">
                                <span class="product-card-badge">HOT</span>
                            </c:if>
                            <c:if test="${p.productId % 5 == 0}">
                                <span class="product-card-badge" style="background:linear-gradient(135deg,#2e7d32,#388e3c);">MỚI</span>
                            </c:if>

                            <div class="product-img-wrap">
                                <c:choose>
                                    <c:when test="${not empty p.imageUrl}">
                                        <img src="${pageContext.request.contextPath}${p.imageUrl}"
                                             alt="${p.productName}"
                                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                        <div class="product-img-placeholder" style="display:none; width:100%; height:100%; align-items:center; justify-content:center;">
                                            <i class="bi bi-box-seam"></i>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="product-img-placeholder">
                                            <i class="bi bi-box-seam"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="product-info">
                                <c:if test="${not empty p.category}">
                                    <span class="product-category-tag">${p.category.categoryName}</span>
                                </c:if>
                                <p class="product-name">${p.productName}</p>
                                <div class="product-price-wrap">
                                    <span class="product-price">
                                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫
                                    </span>
                                </div>
                                <span class="product-btn-cart">
                                    <i class="bi bi-cart-plus"></i>
                                    Xem chi tiết
                                </span>
                            </div>
                        </a>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-products">
                        <div><i class="bi bi-box-seam"></i></div>
                        <p>Chưa có sản phẩm nào. Hãy thêm sản phẩm qua trang quản trị!</p>
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-primary btn-sm">Thêm sản phẩm</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>



<!-- ========== THƯƠNG HIỆU ========== -->
<section class="brands-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Thương hiệu nổi bật</h2>
        </div>

        <c:if test="${not empty brands}">
            <div class="brands-grid">
                <c:forEach var="b" items="${brands}" varStatus="loop">
                    <a href="${pageContext.request.contextPath}/products/brand/${b.brandId}" class="brand-card">
                        <div class="brand-icon">
                            <c:choose>
                                <c:when test="${loop.index == 0}"><i class="bi bi-apple"></i></c:when>
                                <c:when test="${loop.index == 1}"><i class="bi bi-stars"></i></c:when>
                                <c:when test="${loop.index == 2}"><i class="bi bi-badge-4k-fill"></i></c:when>
                                <c:otherwise><i class="bi bi-building"></i></c:otherwise>
                            </c:choose>
                        </div>
                        ${b.brandName}
                    </a>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${empty brands}">
            <p class="text-center text-muted py-3">Chưa có thương hiệu nào.</p>
        </c:if>
    </div>
</section>

<!-- ========== SLIDER JAVASCRIPT ========== -->
<script>
    let currentSlide = 0;
    const totalSlides = 3;
    let autoSlideTimer;

    function goToSlide(index) {
        currentSlide = index;
        updateSlider();
    }

    function changeSlide(direction) {
        currentSlide = (currentSlide + direction + totalSlides) % totalSlides;
        updateSlider();
        resetAutoSlide();
    }

    function updateSlider() {
        const slider = document.getElementById('heroSlider');
        if (slider) {
            slider.style.transform = `translateX(-${currentSlide * 100}%)`;
        }

        // Update dots
        document.querySelectorAll('.hero-dot').forEach((dot, i) => {
            dot.classList.toggle('active', i === currentSlide);
        });
    }

    function startAutoSlide() {
        autoSlideTimer = setInterval(() => {
            currentSlide = (currentSlide + 1) % totalSlides;
            updateSlider();
        }, 4500);
    }

    function resetAutoSlide() {
        clearInterval(autoSlideTimer);
        startAutoSlide();
    }

    // Khởi chạy auto slide
    startAutoSlide();
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
