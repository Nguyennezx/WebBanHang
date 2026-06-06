<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap');

    .detail-wrap {
        padding: 32px 28px;
        font-family: 'Be Vietnam Pro', sans-serif;
        max-width: 680px;
    }

    /* ── Back + title ── */
    .detail-topbar {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 28px;
    }

    .btn-back {
        width: 34px;
        height: 34px;
        border-radius: 8px;
        border: 1px solid #e5e7eb;
        background: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        font-size: 15px;
        color: #374151;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        transition: all .15s;
    }
    .btn-back:hover { background: #f3f4f6; border-color: #d1d5db; }

    .detail-topbar h4 {
        font-size: 20px;
        font-weight: 700;
        color: #111827;
        margin: 0;
        letter-spacing: -.3px;
    }

    /* ── Error alert ── */
    .alert-error {
        display: flex;
        align-items: center;
        gap: 8px;
        background: #fef2f2;
        border: 1px solid #fecaca;
        color: #dc2626;
        border-radius: 8px;
        padding: 10px 16px;
        font-size: 13px;
        font-weight: 500;
        margin-bottom: 20px;
    }

    /* ── Profile hero ── */
    .profile-hero {
        background: linear-gradient(135deg, #1e3a5f 0%, #2563eb 100%);
        border-radius: 12px;
        padding: 24px;
        display: flex;
        align-items: center;
        gap: 18px;
        margin-bottom: 16px;
        color: white;
    }

    .profile-hero.admin-hero {
        background: linear-gradient(135deg, #7f1d1d 0%, #dc2626 100%);
    }

    .hero-avatar {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background: rgba(255,255,255,0.2);
        border: 2px solid rgba(255,255,255,0.4);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        font-weight: 700;
        flex-shrink: 0;
        text-transform: uppercase;
    }

    .hero-info { flex: 1; }
    .hero-name { font-size: 18px; font-weight: 700; margin-bottom: 4px; }
    .hero-username { font-size: 13px; opacity: .75; margin-bottom: 8px; }

    .hero-badges { display: flex; gap: 8px; flex-wrap: wrap; }

    .hero-badge {
        padding: 3px 10px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: .3px;
        background: rgba(255,255,255,0.2);
        color: white;
        border: 1px solid rgba(255,255,255,0.3);
    }

    .hero-badge.locked { background: rgba(251,146,60,0.3); border-color: rgba(251,146,60,0.5); }

    /* ── Card ── */
    .detail-card {
        background: #fff;
        border-radius: 12px;
        border: 1px solid #e5e7eb;
        box-shadow: 0 1px 4px rgba(0,0,0,0.05);
        margin-bottom: 14px;
        overflow: hidden;
    }

    .detail-card-header {
        padding: 14px 20px;
        border-bottom: 1px solid #f3f4f6;
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 13px;
        font-weight: 600;
        color: #374151;
        background: #fafafa;
    }

    .detail-card-body { padding: 0; }

    .info-row {
        display: flex;
        align-items: center;
        padding: 13px 20px;
        border-bottom: 1px solid #f3f4f6;
        font-size: 13.5px;
    }
    .info-row:last-child { border-bottom: none; }

    .info-label {
        width: 140px;
        flex-shrink: 0;
        color: #6b7280;
        font-weight: 500;
        font-size: 12.5px;
    }

    .info-value { color: #111827; font-weight: 500; }

    .role-badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 3px 10px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
    }
    .role-badge.admin    { background: #fef2f2; color: #dc2626; }
    .role-badge.customer { background: #eff6ff; color: #2563eb; }

    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 11.5px;
        font-weight: 500;
    }
    .status-badge.active { background: #f0fdf4; color: #16a34a; }
    .status-badge.locked { background: #fff7ed; color: #c2410c; }
    .status-dot { width: 6px; height: 6px; border-radius: 50%; }
    .status-badge.active .status-dot { background: #22c55e; }
    .status-badge.locked .status-dot { background: #f97316; }

    .date-value { color: #6b7280; font-size: 12.5px; font-family: monospace; }

    /* ── Reset password ── */
    .reset-body { padding: 18px 20px; }

    .reset-field {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .reset-input {
        flex: 1;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        padding: 9px 14px;
        font-size: 13.5px;
        font-family: 'Be Vietnam Pro', sans-serif;
        color: #111827;
        outline: none;
        transition: border .15s;
    }
    .reset-input:focus { border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59,130,246,0.1); }
    .reset-input::placeholder { color: #9ca3af; }

    .btn-reset {
        padding: 9px 18px;
        background: #2563eb;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 13px;
        font-weight: 600;
        font-family: 'Be Vietnam Pro', sans-serif;
        cursor: pointer;
        white-space: nowrap;
        transition: background .15s;
    }
    .btn-reset:hover { background: #1d4ed8; }

    /* ── Toggle active ── */
    .toggle-body { padding: 18px 20px; }

    .btn-toggle {
        width: 100%;
        padding: 11px;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        font-family: 'Be Vietnam Pro', sans-serif;
        cursor: pointer;
        transition: all .15s;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .btn-toggle.lock {
        background: #fff7ed;
        color: #c2410c;
        border: 1px solid #fed7aa;
    }
    .btn-toggle.lock:hover { background: #ffedd5; }

    .btn-toggle.unlock {
        background: #f0fdf4;
        color: #15803d;
        border: 1px solid #bbf7d0;
    }
    .btn-toggle.unlock:hover { background: #dcfce7; }
</style>

<div class="detail-wrap">

    <!-- Top bar -->
    <div class="detail-topbar">
        <a href="${pageContext.request.contextPath}/admin/users" class="btn-back">←</a>
        <h4>Chi tiết người dùng</h4>
    </div>

    <!-- Error -->
    <c:if test="${not empty error}">
        <div class="alert-error">⚠️ ${error}</div>
    </c:if>

    <!-- Profile  -->
    <div class="profile-hero ${user.role == 'admin' ? 'admin-hero' : ''}">
        <div class="hero-avatar">
            ${fn:substring(user.userName, 0, 1)}
        </div>
        <div class="hero-info">
            <div class="hero-name">${user.fullName}</div>
            <div class="hero-username">@${user.userName}</div>
            <div class="hero-badges">
                <span class="hero-badge">${user.role}</span>
                <c:choose>
                    <c:when test="${user.isActive}">
                        <span class="hero-badge">✅ Hoạt động</span>
                    </c:when>
                    <c:otherwise>
                        <span class="hero-badge locked">🔒 Bị khóa</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Info card -->
    <div class="detail-card">
        <div class="detail-card-header">
            👤 Thông tin tài khoản
        </div>
        <div class="detail-card-body">
            <div class="info-row">
                <span class="info-label">Tên đăng nhập</span>
                <span class="info-value">${user.userName}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Họ tên</span>
                <span class="info-value">${user.fullName}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Email</span>
                <span class="info-value">${user.email}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Số điện thoại</span>
                <span class="info-value">${user.phone}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Role</span>
                <span class="role-badge ${user.role == 'admin' ? 'admin' : 'customer'}">
                    ${user.role == 'admin' ? '⭐ ' : ''}${user.role}
                </span>
            </div>
            <div class="info-row">
                <span class="info-label">Trạng thái</span>
                <span class="status-badge ${user.isActive ? 'active' : 'locked'}">
                    <span class="status-dot"></span>
                    ${user.isActive ? 'Hoạt động' : 'Bị khóa'}
                </span>
            </div>
            <div class="info-row">
                <span class="info-label">Ngày tạo</span>
                <span class="date-value">${user.createdDate}</span>
            </div>
        </div>
    </div>

    <!-- Reset password -->
    <div class="detail-card">
        <div class="detail-card-header">
            🔑 Reset mật khẩu
        </div>
        <div class="reset-body">
            <form action="${pageContext.request.contextPath}/admin/users/${user.userId}/reset-password"
                  method="post">
                <div class="reset-field">
                    <input type="password" name="newPassword" class="reset-input"
                           placeholder="Nhập mật khẩu mới..." required>
                    <button type="submit" class="btn-reset">🔄 Reset</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Toggle active - chi hien thi neu khong phai admin -->
    <c:if test="${user.role != 'admin'}">
    <div class="detail-card">
        <div class="toggle-body">
            <form action="${pageContext.request.contextPath}/admin/users/${user.userId}/toggle-active"
                  method="post">
                <button type="submit"
                        class="btn-toggle ${user.isActive ? 'lock' : 'unlock'}">
                    ${user.isActive ? '🔒 Khóa tài khoản này' : '🔓 Mở khóa tài khoản này'}
                </button>
            </form>
        </div>
    </div>
    </c:if>

</div>

<%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>
