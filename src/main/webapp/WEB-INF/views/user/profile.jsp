<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-7">

            <div class="card border-0 shadow-sm rounded-3">

                <div class="card-header bg-primary text-white py-3">
                    <h5 class="mb-0">
                        <i class="bi bi-person-circle me-2"></i>
                        Thông tin cá nhân
                    </h5>
                </div>

                <div class="card-body p-4">

                    <!-- SUCCESS / ERROR -->
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

                    <!-- VALIDATION ERRORS -->
                    <c:if test="${not empty validationErrors}">
                        <div class="alert alert-danger py-2">
                            <c:forEach items="${validationErrors}" var="err">
                                <div>${err.defaultMessage}</div>
                            </c:forEach>
                        </div>
                    </c:if>

                    <!-- FORM -->
                    <form action="${pageContext.request.contextPath}/profile/update"
                          method="post">

                        <!-- hidden ID -->
                        <input type="hidden" name="userId" value="${user.userId}">

                        <!-- USERNAME (readonly) -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold" style="font-size:0.85rem;">
                                Tên đăng nhập
                            </label>
                            <input type="text" class="form-control bg-light"
                                   value="${user.userName}" disabled>
                        </div>

                        <!-- FULL NAME -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold" style="font-size:0.85rem;">
                                Họ và tên
                            </label>
                            <input type="text" name="fullName"
                                   class="form-control"
                                   value="${user.fullName}" required>
                        </div>

                        <!-- EMAIL -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold" style="font-size:0.85rem;">
                                Email
                            </label>
                            <input type="email" name="email"
                                   class="form-control"
                                   value="${user.email}" required>
                        </div>

                        <!-- PHONE -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold" style="font-size:0.85rem;">
                                Số điện thoại
                            </label>
                            <input type="text" name="phone"
                                   class="form-control"
                                   value="${user.phone}">
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi bi-save me-1"></i> Lưu thay đổi
                            </button>

                            <a href="${pageContext.request.contextPath}/profile/change-password"
                               class="btn btn-outline-secondary px-4">
                                <i class="bi bi-lock me-1"></i> Đổi mật khẩu
                            </a>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
