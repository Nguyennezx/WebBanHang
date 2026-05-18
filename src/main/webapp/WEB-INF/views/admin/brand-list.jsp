<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<c:if test="${param.success != null}">
    <div class="alert alert-success">✓ ${param.success}</div>
</c:if>

<div class="page-header">
    <h1 class="page-title">🏷️ Quản lý thương hiệu</h1>
    <a href="/WebBanHang/admin/brands/create" class="btn-primary"> Thêm thương hiệu</a>
</div>

<div class="content-card">
    <c:choose>
        <c:when test="${empty brands}">
            <p style="text-align: center; padding: 40px; color: #999;">
                Không có thương hiệu nào. <a href="/WebBanHang/admin/brands/create">Thêm thương hiệu mới</a>
            </p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th style="width: 50px;">ID</th>
                        <th>Tên thương hiệu</th>
                        <th>Mô tả</th>
                        <th style="width: 70px;">Trạng thái</th>
                        <th style="width: 120px;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="brand" items="${brands}">
                        <tr>
                            <td>${brand.brandId}</td>
                            <td><strong>${brand.brandName}</strong></td>
                            <td>${brand.description}</td>
                            <td>
                                <span class="status-badge ${brand.isActive ? 'status-active' : 'status-inactive'}">
                                    ${brand.isActive ? '✓ Active' : '✕ Inactive'}
                                </span>
                            </td>
                            <td>
                                <a href="/WebBanHang/admin/brands/${brand.brandId}/edit" class="btn-sm btn-edit"> Sửa</a>
                                <a href="/WebBanHang/admin/brands/${brand.brandId}/delete" class="btn-sm btn-delete" 
                                   onclick="return confirm('Xóa thương hiệu này?')"> Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>