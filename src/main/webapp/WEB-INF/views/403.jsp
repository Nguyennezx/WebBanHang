<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5 text-center">
    <i class="bi bi-shield-x" style="font-size:5rem; color:#1a73e8;"></i>
    <h2 class="mt-3 fw-bold">403 - Không có quyền truy cập</h2>
    <p class="text-muted mt-2">Bạn không có quyền xem trang này.</p>
    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-3 px-4">
        <i class="bi bi-house me-1"></i>Về trang chủ
    </a>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
