<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<c:if test="${param.success != null}">
    <div class="alert alert-success">✓ ${param.success}</div>
</c:if>

<div class="page-header" style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;">
    <h1 class="page-title" style="margin: 0; font-size: 20px;">📦 Quản lý (${products.size()} sản phẩm)</h1>
    
    <!-- THANH TÌM KIẾM -->
    <form action="/WebBanHang/admin/products" method="GET" style="display: flex; flex-grow: 1; max-width: 450px; gap: 8px;">
        <input type="text" name="keyword" value="${param.keyword}" placeholder="Nhập tên sản phẩm cần tìm..." 
               style="flex-grow: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px; outline: none; font-size: 14px;">
        <button type="submit" class="btn-primary" style="background: #17a2b8; border-color: #17a2b8;"> Tìm</button>
        <c:if test="${not empty param.keyword}">
            <a href="/WebBanHang/admin/products" class="btn-primary" style="background: #6c757d; border-color: #6c757d; padding: 8px 12px;">Hủy</a>
        </c:if>
    </form>

    <a href="/WebBanHang/admin/products/create" class="btn-primary"> Thêm sản phẩm</a>
</div>


<div class="content-card">
    <c:choose>
        <c:when test="${empty products}">
            <p style="text-align: center; padding: 40px; color: #999;">
                Không có sản phẩm nào. <a href="/WebBanHang/admin/products/create">Thêm sản phẩm mới</a>
            </p>
        </c:when>
        <c:otherwise>
            <div style="overflow-x: auto;">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 50px;">ID</th>
                            <th style="width: 50px;">Hình</th>
                            <th>Tên sản phẩm</th>
                            <th style="width: 80px;">Danh mục</th>
                            <th style="width: 80px;">Thương hiệu</th>
                            <th style="width: 100px;">Giá</th>
                            <th style="width: 60px;">Kho</th>
                            <th style="width: 70px;">Trạng thái</th>
                            <th style="width: 120px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td>${product.productId}</td>
                                <td>
                                    <img src="${pageContext.request.contextPath}${product.imageUrl != null ? product.imageUrl : '/images/placeholder.jpg'}" 
                                         alt="${product.productName}" 
                                         style="width: 40px; height: 40px; object-fit: cover; border-radius: 3px;">
                                </td>
                                <td>
                                    <strong>${product.productName}</strong>
                                    <br>
                                    <small style="color: #999;">
                                        <c:if test="${product.brand != null}">
                                            ${product.brand.brandName}
                                        </c:if>
                                    </small>
                                </td>
                                <td>
                                    <c:if test="${product.category != null}">
                                        ${product.category.categoryName}
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${product.brand != null}">
                                        ${product.brand.brandName}
                                    </c:if>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${product.quantityStock > 0}">
                                            <span style="color: #52c41a; font-weight: 600;">${product.quantityStock}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #f5222d; font-weight: 600;">0</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="status-badge ${product.isActive ? 'status-active' : 'status-inactive'}">
                                        ${product.isActive ? '✓ Active' : '✕ Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <a href="/WebBanHang/admin/products/${product.productId}/edit" class="btn-sm btn-edit"> Sửa</a>
                                    <a href="/WebBanHang/admin/products/${product.productId}/delete" class="btn-sm btn-delete" 
                                       onclick="return confirm('Xóa sản phẩm này?')"> Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>
