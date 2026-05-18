<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<div class="page-header">
    <h1 class="page-title">${isCreate ? ' Thêm thương hiệu' : ' Sửa thương hiệu'}</h1>
</div>

<div class="content-card" style="max-width: 600px;">
<!-- KHUNG BÁO LỖI -->
    <c:if test="${not empty param.error}">
        <div style="background-color: #fff2f0; color: #ff4d4f; padding: 12px 16px; margin-bottom: 16px; border: 1px solid #ffccc7; border-radius: 4px;">
            ❌ Lỗi: ${param.error}
        </div>
    </c:if>
    <form action="/WebBanHang/admin/brands/${isCreate ? 'create' : brand.brandId}${isCreate ? '' : '/edit'}" method="POST">

        
        <div style="margin-bottom: 16px;">
            <label style="display: block; margin-bottom: 8px; font-weight: 600;">Tên thương hiệu *</label>
            <input type="text" name="brandName" value="${brand.brandName}" required 
                   style="width: 100%; padding: 8px; border: 1px solid #d9d9d9; border-radius: 4px;">
        </div>

        <div style="margin-bottom: 16px;">
            <label style="display: block; margin-bottom: 8px; font-weight: 600;">Mô tả</label>
            <textarea name="description" style="width: 100%; padding: 8px; border: 1px solid #d9d9d9; border-radius: 4px; min-height: 100px;">${brand.description}</textarea>
        </div>

        <div style="display: flex; gap: 12px;">
            <a href="/WebBanHang/admin/brands" style="padding: 8px 16px; background: #d9d9d9; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; color: #333;">Hủy</a>
            <button type="submit" class="btn-primary" style="flex: 1;">${isCreate ? ' Thêm' : ' Cập nhật'}</button>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>