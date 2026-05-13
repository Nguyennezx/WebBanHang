<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-primary text-white py-3">
                    <h5 class="mb-0"><i class="bi bi-lock me-2"></i>Đổi mật khẩu</h5>
                </div>
                <div class="card-body p-4">

                    <c:if test="${not empty success}">
                        <div class="alert alert-success py-2">
                            <i class="bi bi-check-circle me-1"></i> ${success}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2">
                            <i class="bi bi-exclamation-circle me-1"></i> ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/profile/change-password" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold" style="font-size:0.85rem;">Mật khẩu cũ</label>
                            <div class="input-group">
                                <input type="password" name="oldPassword" id="pw0" class="form-control" required>
                                <span class="input-group-text bg-white" style="cursor:pointer" onclick="togglePw('pw0','eye0')">
                                    <i class="bi bi-eye text-muted" id="eye0"></i>
                                </span>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold" style="font-size:0.85rem;">Mật khẩu mới</label>
                            <div class="input-group">
                                <input type="password" name="newPassword" id="pw1" class="form-control" required>
                                <span class="input-group-text bg-white" style="cursor:pointer" onclick="togglePw('pw1','eye1')">
                                    <i class="bi bi-eye text-muted" id="eye1"></i>
                                </span>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-semibold" style="font-size:0.85rem;">Xác nhận mật khẩu mới</label>
                            <div class="input-group">
                                <input type="password" name="confirmPassword" id="pw2" class="form-control" required>
                                <span class="input-group-text bg-white" style="cursor:pointer" onclick="togglePw('pw2','eye2')">
                                    <i class="bi bi-eye text-muted" id="eye2"></i>
                                </span>
                            </div>
                        </div>
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi bi-check-lg me-1"></i>Xác nhận
                            </button>
                            <a href="${pageContext.request.contextPath}/profile"
                               class="btn btn-outline-secondary px-4">
                                <i class="bi bi-arrow-left me-1"></i>Quay lại
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    function togglePw(inputId, iconId) {
        const input = document.getElementById(inputId);
        const icon  = document.getElementById(iconId);
        input.type  = input.type === 'password' ? 'text' : 'password';
        icon.className = input.type === 'text' ? 'bi bi-eye-slash text-muted' : 'bi bi-eye text-muted';
    }
</script>
