<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="d-flex align-items-center mb-3 gap-2">
                <a href="${pageContext.request.contextPath}/admin/users"
                   class="btn btn-sm btn-outline-secondary">
                    <i class="bi bi-arrow-left"></i>
                </a>
                <h5 class="mb-0">Chi tiết người dùng</h5>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger py-2">
                    <i class="bi bi-exclamation-circle me-1"></i> ${error}
                </div>
            </c:if>

            <!-- Thông tin -->
            <div class="card border-0 shadow-sm rounded-3 mb-3">
                <div class="card-header bg-primary text-white py-3">
                    <h6 class="mb-0"><i class="bi bi-person me-2"></i>Thông tin tài khoản</h6>
                </div>
                <div class="card-body p-0">
                    <table class="table table-bordered mb-0" style="font-size:0.9rem;">
                        <tr><th class="bg-light" style="width:35%">Tên đăng nhập</th><td>${user.userName}</td></tr>
                        <tr><th class="bg-light">Họ tên</th><td>${user.fullName}</td></tr>
                        <tr><th class="bg-light">Email</th><td>${user.email}</td></tr>
                        <tr><th class="bg-light">Số điện thoại</th><td>${user.phone}</td></tr>
                        <tr><th class="bg-light">Role</th>
                            <td>
                                <span class="badge ${user.role == 'admin' ? 'bg-danger' : 'bg-secondary'}">
                                    ${user.role}
                                </span>
                            </td>
                        </tr>
                        <tr><th class="bg-light">Trạng thái</th>
                            <td>
                                <span class="badge ${user.isActive ? 'bg-success' : 'bg-warning text-dark'}">
                                    ${user.isActive ? 'Hoạt động' : 'Bị khóa'}
                                </span>
                            </td>
                        </tr>
                        <tr><th class="bg-light">Ngày tạo</th><td>${user.createdDate}</td></tr>
                    </table>
                </div>
            </div>

            <!-- Reset mật khẩu -->
            <div class="card border-0 shadow-sm rounded-3 mb-3">
                <div class="card-header bg-light py-3">
                    <h6 class="mb-0"><i class="bi bi-key me-2"></i>Reset mật khẩu</h6>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/users/${user.userId}/reset-password"
                          method="post" class="d-flex gap-2">
                        <input type="password" name="newPassword" class="form-control"
                               placeholder="Mật khẩu mới" required>
                        <button type="submit" class="btn btn-danger px-3">
                            <i class="bi bi-arrow-repeat me-1"></i>Reset
                        </button>
                    </form>
                </div>
            </div>

            <!-- Khóa / mở -->
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/users/${user.userId}/toggle-active"
                          method="post">
                        <button type="submit"
                                class="btn ${user.isActive ? 'btn-warning' : 'btn-success'} w-100">
                            <i class="bi ${user.isActive ? 'bi-lock' : 'bi-unlock'} me-2"></i>
                            ${user.isActive ? 'Khóa tài khoản này' : 'Mở khóa tài khoản này'}
                        </button>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
