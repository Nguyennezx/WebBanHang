<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="mb-0"><i class="bi bi-people me-2"></i>Quản lý người dùng</h5>
        <span class="text-muted" style="font-size:0.85rem;">Tổng: ${users.size()} tài khoản</span>
    </div>

    <c:if test="${not empty param.resetSuccess}">
        <div class="alert alert-success py-2">
            <i class="bi bi-check-circle me-1"></i> Reset mật khẩu thành công
        </div>
    </c:if>

    <div class="card border-0 shadow-sm rounded-3">
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-primary">
                    <tr>
                        <th>#</th>
                        <th>Tên đăng nhập</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Role</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}" varStatus="s">
                        <tr>
                            <td class="text-muted" style="font-size:0.85rem;">${s.index + 1}</td>
                            <td><strong>${u.userName}</strong></td>
                            <td>${u.fullName}</td>
                            <td style="font-size:0.85rem;">${u.email}</td>
                            <td style="font-size:0.85rem;">${u.phone}</td>
                            <td>
                                <span class="badge ${u.role == 'admin' ? 'bg-danger' : 'bg-secondary'}">
                                    ${u.role}
                                </span>
                            </td>
                            <td>
                                <span class="badge ${u.isActive ? 'bg-success' : 'bg-warning text-dark'}">
                                    ${u.isActive ? 'Hoạt động' : 'Bị khóa'}
                                </span>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/users/${u.userId}"
                                   class="btn btn-sm btn-outline-primary me-1">
                                    <i class="bi bi-eye"></i>
                                </a>
                                <form action="${pageContext.request.contextPath}/admin/users/${u.userId}/toggle-active"
                                      method="post" style="display:inline">
                                    <button type="submit"
                                            class="btn btn-sm ${u.isActive ? 'btn-outline-warning' : 'btn-outline-success'}">
                                        <i class="bi ${u.isActive ? 'bi-lock' : 'bi-unlock'}"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr><td colspan="8" class="text-center text-muted py-4">Chưa có người dùng nào</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
