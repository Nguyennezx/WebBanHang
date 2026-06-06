<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<div class="page-header">
    <h1 class="page-title">📊 Dashboard</h1>
</div>

<div class="content-card">
    <h2 style="margin-bottom: 20px;">Chào mừng đến Admin Panel</h2>
    
    <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 30px;">
        <div style="background: #f0f2f5; padding: 20px; border-radius: 4px; text-align: center;">
            <div style="font-size: 28px; font-weight: 700; color: #1890ff;">${totalProducts}</div>
            <div style="color: #666; font-size: 12px; margin-top: 8px;">Sản phẩm</div>
        </div>
        <div style="background: #f0f2f5; padding: 20px; border-radius: 4px; text-align: center;">
            <div style="font-size: 28px; font-weight: 700; color: #52c41a;">${totalCategories}</div>
            <div style="color: #666; font-size: 12px; margin-top: 8px;">Danh mục</div>
        </div>
        <div style="background: #f0f2f5; padding: 20px; border-radius: 4px; text-align: center;">
            <div style="font-size: 28px; font-weight: 700; color: #faad14;">${totalBrands}</div>
            <div style="color: #666; font-size: 12px; margin-top: 8px;">Thương hiệu</div>
        </div>
        <div style="background: #f0f2f5; padding: 20px; border-radius: 4px; text-align: center;">
            <div style="font-size: 28px; font-weight: 700; color: #f5222d;">${totalUsers}</div>
            <div style="color: #666; font-size: 12px; margin-top: 8px;">Users</div>
        </div>
    </div>

    <h3 style="margin-bottom: 16px;">Quản lý nhanh</h3>
    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px;">
        <a href="/WebBanHang/admin/products/create" class="btn-primary" style="text-align: center; padding: 12px;">
             Thêm sản phẩm
        </a>
        <a href="/WebBanHang/admin/categories/create" class="btn-primary" style="text-align: center; padding: 12px;">
             Thêm danh mục
        </a>
        <a href="/WebBanHang/admin/brands/create" class="btn-primary" style="text-align: center; padding: 12px;">
             Thêm thương hiệu
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>