<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm - ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root { --primary: #1a73e8; --primary-dark: #0d47a1; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; }

        /* ===== MAIN LAYOUT ===== */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 24px 20px;
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 24px;
        }

        /* ===== SIDEBAR FILTER ===== */
        .sidebar {
            background: white;
            border-radius: 8px;
            padding: 20px;
            height: fit-content;
            position: sticky;
            top: 80px; /* Điều chỉnh tùy theo độ cao header của bạn */
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
        }
        .filter-title { display: flex; align-items: center; gap: 8px; font-size: 14px; font-weight: 600; margin-bottom: 20px; padding-bottom: 16px; border-bottom: 2px solid #e5e7eb; }
        .filter-section { margin-bottom: 24px; }
        .filter-section h4 { font-size: 13px; font-weight: 600; color: #374151; margin-bottom: 12px; text-transform: uppercase; }
        
        .price-group { display: flex; gap: 8px; }
        .price-input { flex: 1; width: 0; min-width: 0; padding: 8px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 12px; }
        
        .filter-checkbox { display: flex; align-items: center; gap: 10px; margin-bottom: 10px; font-size: 13px; cursor: pointer; }
        .filter-checkbox input { width: 17px; height: 17px; accent-color: var(--primary); }

        .apply-btn { width: 100%; padding: 10px; background: var(--primary); color: white; border: none; border-radius: 6px; font-weight: 600; margin-top: 10px; transition: 0.3s; }
        .apply-btn:hover { background: var(--primary-dark); }
        
        .reset-filter-btn { width: 100%; padding: 8px; background: #f3f4f6; border: none; border-radius: 6px; font-size: 12px; margin-top: 10px; color: #6b7280; }

        /* ===== MAIN CONTENT & GRID ===== */
        .main-content { background: white; border-radius: 8px; padding: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.08); }
        .content-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid #e5e7eb; }
        
        .sort-select { padding: 8px 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 13px; outline: none; }

        .products-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 16px; }
        .product-card { border: 1px solid #e5e7eb; border-radius: 8px; overflow: hidden; transition: 0.3s; display: flex; flex-direction: column; background: #fff; text-decoration: none; color: inherit; }
        .product-card:hover { border-color: var(--primary); transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.1); }

        .product-image-container { position: relative; height: 200px; background: #f8f9fa; display: flex; align-items: center; justify-content: center; }
        .product-image { width: 100%; height: 100%; object-fit: cover; }
        
        .product-details { padding: 15px; flex: 1; display: flex; flex-direction: column; }
        .product-name { font-size: 14px; font-weight: 600; margin: 8px 0; line-height: 1.4; height: 40px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }
        .product-price { margin-top: auto; }
        .current-price { color: #dc2626; font-weight: 700; font-size: 16px; }
        

        .add-to-cart-btn { width: 100%; padding: 8px; background: var(--primary); color: #fff; border: none; border-radius: 4px; font-size: 12px; margin-top: 10px; }

        /* ===== PAGINATION ===== */
        .pagination { display: flex; justify-content: center; gap: 5px; margin-top: 30px; }
        .pagination button { border: 1px solid #d1d5db; background: white; padding: 6px 12px; border-radius: 4px; cursor: pointer; }
        .pagination button.active { background: var(--primary); color: white; border-color: var(--primary); }
        .pagination a { text-decoration: none; color: inherit; }

        @media (max-width: 1024px) { .main-container { grid-template-columns: 1fr; } .sidebar { display: none; } }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="main-container">
    <aside class="sidebar">
        <div class="filter-title"><i class="fas fa-sliders-h"></i> BỘ LỌC</div>

        <div class="filter-section">
            <h4>Giá</h4>
            <div class="price-group">
                <input type="number" id="minPrice" placeholder="Từ" class="price-input" value="${minPrice}">
                <input type="number" id="maxPrice" placeholder="Đến" class="price-input" value="${maxPrice}">
            </div>
            <button class="apply-btn" onclick="applyPriceFilter()">Áp dụng</button>
        </div>

        <div class="filter-section">
            <h4>Danh mục</h4>
            <c:forEach var="cat" items="${categories}">
                <div class="filter-checkbox">
                    <input type="checkbox" ${selectedCategory == cat.categoryId ? 'checked' : ''} 
                           onchange="updateFilter('categoryId', '${cat.categoryId}', this.checked)">
                    <label>${cat.categoryName}</label>
                </div>
            </c:forEach>
        </div>

        <div class="filter-section">
            <h4>Thương hiệu</h4>
            <c:forEach var="brand" items="${brands}">
                <div class="filter-checkbox">
                    <input type="checkbox" ${selectedBrand == brand.brandId ? 'checked' : ''} 
                           onchange="updateFilter('brandId', '${brand.brandId}', this.checked)">
                    <label>${brand.brandName}</label>
                </div>
            </c:forEach>
        </div>

        <button class="reset-filter-btn" onclick="resetAllFilters()">Xóa tất cả bộ lọc</button>
    </aside>

    <div class="main-content">
        <div class="content-header">
             <%-- <div class="product-count">Tìm thấy <strong>${products.size()}</strong> sản phẩm</div> --%> 
            <select class="sort-select" onchange="applySortFilter(this.value)">
                <option value="">Sắp xếp mặc định</option>
                <option value="price_asc" ${sortType == 'price_asc' ? 'selected' : ''}>Giá: Thấp → Cao</option>
                <option value="price_desc" ${sortType == 'price_desc' ? 'selected' : ''}>Giá: Cao → Thấp</option>
                <option value="newest" ${sortType == 'newest' ? 'selected' : ''}>Mới nhất</option>
            </select>
        </div>

        <div class="products-grid">
            <c:choose>
                <c:when test="${empty products}">
                    <div style="grid-column: 1/-1; text-align: center; padding: 50px;">
                        <i class="fas fa-box-open" style="font-size: 40px; color: #ccc;"></i>
                        <p>Không tìm thấy sản phẩm nào phù hợp.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="product" items="${products}">
                        <a href="${pageContext.request.contextPath}/products/${product.productId}" class="product-card">
                            <div class="product-image-container">
                                <img src="${pageContext.request.contextPath}${not empty product.imageUrl ? product.imageUrl : '/images/placeholder.jpg'}" class="product-image">
                            </div>
                            <div class="product-details">
                                <span style="font-size: 11px; color: #999;">${product.brand.brandName}</span>
                                <h4 class="product-name">${product.productName}</h4>
                                <div class="product-price">
                                    <span class="current-price"><fmt:formatNumber value="${product.price}" type="number"/>đ</span>
                                    
                                </div>
                                <button class="add-to-cart-btn" onclick="event.preventDefault(); addToCartGlobal(${product.productId}, 1);">
                                    Thêm vào giỏ
                                </button>
                            </div>
                        </a>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="pagination">
            <c:forEach var="i" begin="1" end="${totalPages}">
                <a href="?page=${i}&categoryId=${selectedCategory}&brandId=${selectedBrand}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sortType}">
                    <button class="${i == currentPage ? 'active' : ''}">${i}</button>
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />

<script>
function updateFilter(name, value, checked) {
    let url = new URL(window.location);
    if (checked) url.searchParams.set(name, value);
    else url.searchParams.delete(name);
    url.searchParams.set('page', 1);
    window.location = url.href;
}

function applyPriceFilter() {
    let url = new URL(window.location);
    url.searchParams.set('minPrice', document.getElementById('minPrice').value);
    url.searchParams.set('maxPrice', document.getElementById('maxPrice').value);
    url.searchParams.set('page', 1);
    window.location = url.href;
}

function applySortFilter(val) {
    let url = new URL(window.location);
    if (val) url.searchParams.set('sort', val);
    else url.searchParams.delete('sort');
    window.location = url.href;
}

function resetAllFilters() {
    window.location = window.location.pathname;
}
</script>
</body>
</html>