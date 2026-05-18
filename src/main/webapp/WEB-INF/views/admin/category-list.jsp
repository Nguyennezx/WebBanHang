<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<c:if test="${param.success != null}">
    <div class="alert alert-success">✓ ${param.success}</div>
</c:if>

<div class="page-header">
    <h1 class="page-title">📂 Quản lý danh mục</h1>
    <a href="/WebBanHang/admin/categories/create" class="btn-primary"> Thêm danh mục</a>
</div>

<div class="content-card">
    <c:choose>
        <c:when test="${empty categories}">
            <p style="text-align: center; padding: 40px; color: #999;">
                Không có danh mục nào. <a href="/WebBanHang/admin/categories/create">Thêm danh mục mới</a>
            </p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th style="width: 50px;">ID</th>
                        <th>Tên danh mục</th>
                        <th>Mô tả</th>
                        <th style="width: 70px;">Trạng thái</th>
                        <th style="width: 120px;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cat" items="${categories}">
                        <tr>
                            <td>${cat.categoryId}</td>
                            <td><strong>${cat.categoryName}</strong></td>
                            <td>${cat.description}</td>
                            <td>
                                <span class="status-badge ${cat.isActive ? 'status-active' : 'status-inactive'}">
                                    ${cat.isActive ? '✓ Active' : '✕ Inactive'}
                                </span>
                            </td>
                            <td>
                                <a href="/WebBanHang/admin/categories/${cat.categoryId}/edit" class="btn-sm btn-edit"> Sửa</a>
                                <a href="/WebBanHang/admin/categories/${cat.categoryId}/delete" class="btn-sm btn-delete" 
                                   onclick="return confirm('Xóa danh mục này?')"> Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>