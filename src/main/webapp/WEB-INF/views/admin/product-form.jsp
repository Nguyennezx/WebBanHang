<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>


<div class="page-header">
    <h1 class="page-title">${isCreate ? ' Thêm sản phẩm' : ' Sửa sản phẩm'}</h1>
</div>

<div class="content-card" style="max-width: 700px;">
<!-- KHUNG BÁO LỖI -->
<c:if test="${not empty param.error}">
    <div style="background-color: #fff2f0; color: #ff4d4f; padding: 12px 16px; margin-bottom: 16px; border: 1px solid #ffccc7; border-radius: 4px;">
        ❌ Lỗi: ${param.error}
    </div>
</c:if>

    <form action="/WebBanHang/admin/products/${isCreate ? 'create' : product.productId}${isCreate ? '' : '/edit'}" method="POST" enctype="multipart/form-data">
        
        <!-- TÊN SẢN PHẨM -->
        <div style="margin-bottom: 16px;">
            <label style="display: block; margin-bottom: 8px; font-weight: 600;">Tên sản phẩm *</label>
            <input type="text" name="productName" value="${product.productName}" required 
                   style="width: 100%; padding: 8px; border: 1px solid #d9d9d9; border-radius: 4px;">
        </div>

        <!-- GIÁ & KHO -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
            <div>
                <label style="display: block; margin-bottom: 8px; font-weight: 600;">Giá bán *</label>
                <input type="number" name="price" value="${product.price}" required step="1000"
                       style="width: 100%; padding: 8px; border: 1px solid #d9d9d9; border-radius: 4px;">
            </div>
            <div>
                <label style="display: block; margin-bottom: 8px; font-weight: 600;">Số lượng kho *</label>
                <input type="number" name="quantityStock" value="${product.quantityStock}" required
                       style="width: 100%; padding: 8px; border: 1px solid #d9d9d9; border-radius: 4px;">
            </div>
        </div>

        <!-- DANH MỤC & THƯƠNG HIỆU -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
            <div>
                <label style="display: block; margin-bottom: 8px; font-weight: 600;">Danh mục *</label>
                <select name="categoryId" required style="width: 100%; padding: 8px; border: 1px solid #d9d9d9; border-radius: 4px;">
                    <option value="">-- Chọn danh mục --</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.categoryId}" 
                                ${product.category != null && product.category.categoryId == cat.categoryId ? 'selected' : ''}>
                            ${cat.categoryName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label style="display: block; margin-bottom: 8px; font-weight: 600;">Thương hiệu *</label>
                <select name="brandId" required style="width: 100%; padding: 8px; border: 1px solid #d9d9d9; border-radius: 4px;">
                    <option value="">-- Chọn thương hiệu --</option>
                    <c:forEach var="brand" items="${brands}">
                        <option value="${brand.brandId}" 
                                ${product.brand != null && product.brand.brandId == brand.brandId ? 'selected' : ''}>
                            ${brand.brandName}
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <!-- UPLOAD HÌNH ÁNH -->
        <div style="margin-bottom: 16px;">
            <label style="display: block; margin-bottom: 8px; font-weight: 600;">Chọn hình ảnh</label>
            <input type="file" name="imageFile" accept="image/*" 
                   style="width: 100%; padding: 8px; border: 1px solid #d9d9d9; border-radius: 4px;">
            <small style="color: #999;">Định dạng: JPG, PNG</small>
        </div>

        <!-- MÔ TẢ -->
        <div style="margin-bottom: 16px;">
            <label style="display: block; margin-bottom: 8px; font-weight: 600;">Mô tả sản phẩm</label>
            <textarea name="description" style="width: 100%; padding: 8px; border: 1px solid #d9d9d9; border-radius: 4px; min-height: 120px;">${product.description}</textarea>
        </div>

        <!-- BUTTONS -->
        <div style="display: flex; gap: 12px;">
            <a href="/WebBanHang/admin/products" 
               style="padding: 8px 16px; background: #d9d9d9; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; color: #333;">
                 Hủy
            </a>
            <button type="submit" class="btn-primary" style="flex: 1; padding: 8px 16px;">
                ${isCreate ? ' Thêm sản phẩm' : ' Cập nhật'}
            </button>
        </div>
    </form>  
</div>
<%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>
