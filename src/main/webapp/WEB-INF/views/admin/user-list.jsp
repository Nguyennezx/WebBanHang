<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap');

    .users-wrap {
        padding: 32px 28px;
        font-family: 'Be Vietnam Pro', sans-serif;
    }

    /* ── Page header ── */
    .users-page-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 28px;
    }

    .users-page-header h4 {
        font-size: 20px;
        font-weight: 700;
        color: #111827;
        margin: 0 0 4px;
        letter-spacing: -0.3px;
    }

    .users-page-header .subtitle {
        font-size: 13px;
        color: #6b7280;
        font-weight: 400;
    }

    /* ── Stats pills ── */
    .stats-row {
        display: flex;
        gap: 14px;
        margin-bottom: 24px;
    }

    .stat-pill {
        display: flex;
        align-items: center;
        gap: 10px;
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 10px;
        padding: 12px 18px;
        flex: 1;
        max-width: 180px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.04);
    }

    .stat-pill .pill-icon {
        width: 36px;
        height: 36px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 16px;
        flex-shrink: 0;
    }

    .stat-pill.total   .pill-icon { background: #eff6ff; }
    .stat-pill.active  .pill-icon { background: #f0fdf4; }
    .stat-pill.locked  .pill-icon { background: #fff7ed; }

    .stat-pill .pill-label { font-size: 11px; color: #9ca3af; font-weight: 500; text-transform: uppercase; letter-spacing: .4px; }
    .stat-pill .pill-value { font-size: 20px; font-weight: 700; color: #111827; line-height: 1.1; }

    /* ── Alert ── */
    .alert-success-custom {
        display: flex;
        align-items: center;
        gap: 8px;
        background: #f0fdf4;
        border: 1px solid #bbf7d0;
        color: #15803d;
        border-radius: 8px;
        padding: 10px 16px;
        font-size: 13px;
        font-weight: 500;
        margin-bottom: 20px;
    }

    /* ── Table card ── */
    .users-card {
        background: #fff;
        border-radius: 12px;
        border: 1px solid #e5e7eb;
        box-shadow: 0 1px 4px rgba(0,0,0,0.05);
        overflow: hidden;
    }

    .users-card table {
        width: 100%;
        border-collapse: collapse;
        font-size: 13.5px;
        font-family: 'Be Vietnam Pro', sans-serif;
    }

    .users-card thead tr {
        background: #f9fafb;
        border-bottom: 1px solid #e5e7eb;
    }

    .users-card thead th {
        padding: 11px 16px;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: .5px;
        color: #6b7280;
        white-space: nowrap;
    }

    .users-card tbody td {
        padding: 14px 16px;
        border-bottom: 1px solid #f3f4f6;
        color: #374151;
        vertical-align: middle;
    }

    .users-card tbody tr:last-child td { border-bottom: none; }

    .users-card tbody tr:hover { background: #fafafa; }

    /* username */
    .username-cell {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .avatar-circle {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        background: linear-gradient(135deg, #3b82f6, #6366f1);
        color: white;
        font-size: 12px;
        font-weight: 700;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        text-transform: uppercase;
    }

    .avatar-circle.admin-av {
        background: linear-gradient(135deg, #ef4444, #f97316);
    }

    .username-text { font-weight: 600; color: #111827; }

    /* role badge */
    .role-badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 3px 10px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: .3px;
    }

    .role-badge.admin    { background: #fef2f2; color: #dc2626; }
    .role-badge.customer { background: #eff6ff; color: #2563eb; }

    /* status badge */
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

    .status-dot {
        width: 6px;
        height: 6px;
        border-radius: 50%;
    }

    .status-badge.active .status-dot { background: #22c55e; }
    .status-badge.locked .status-dot { background: #f97316; }

    /* action buttons */
    .action-group { display: flex; align-items: center; gap: 6px; justify-content: center; }

    .action-btn {
        width: 30px;
        height: 30px;
        border-radius: 6px;
        border: 1px solid #e5e7eb;
        background: #fff;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 13px;
        transition: all .15s;
        text-decoration: none;
    }

    .action-btn:hover { border-color: #3b82f6; background: #eff6ff; }
    .action-btn.lock:hover { border-color: #f59e0b; background: #fffbeb; }
    .action-btn.unlock:hover { border-color: #22c55e; background: #f0fdf4; }

    /* empty */
    .empty-row td {
        text-align: center;
        padding: 48px 16px !important;
        color: #9ca3af;
        font-size: 13px;
    }

    .row-num { color: #9ca3af; font-size: 12px; font-weight: 500; }
</style>

<div class="users-wrap">

    <!-- Page header -->
    <div class="users-page-header">
        <div>
            <h4>👥 Quản lý người dùng</h4>
            <span class="subtitle">Danh sách tất cả tài khoản trong hệ thống</span>
        </div>
    </div>

    <!-- Stats pills -->
    <div class="stats-row">
        <div class="stat-pill total">
            <div class="pill-icon">📋</div>
            <div>
                <div class="pill-label">Tổng</div>
                <div class="pill-value">${users.size()}</div>
            </div>
        </div>
        <div class="stat-pill active">
            <div class="pill-icon">✅</div>
            <div>
                <div class="pill-label">Hoạt động</div>
                <div class="pill-value">
                    <c:set var="activeCount" value="0"/>
                    <c:forEach var="u" items="${users}">
                        <c:if test="${u.isActive}"><c:set var="activeCount" value="${activeCount + 1}"/></c:if>
                    </c:forEach>
                    ${activeCount}
                </div>
            </div>
        </div>
        <div class="stat-pill locked">
            <div class="pill-icon">🔒</div>
            <div>
                <div class="pill-label">Bị khóa</div>
                <div class="pill-value">${users.size() - activeCount}</div>
            </div>
        </div>
    </div>

    <!-- Success alert -->
    <c:if test="${not empty param.resetSuccess}">
        <div class="alert-success-custom">
            ✅ Reset mật khẩu thành công
        </div>
    </c:if>

    <!-- Table -->
    <div class="users-card">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Tên đăng nhập</th>
                    <th>Họ tên</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Role</th>
                    <th>Trạng thái</th>
                    <th style="text-align:center">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${users}" varStatus="s">
                    <tr>
                        <td class="row-num">${s.index + 1}</td>
                        <td>
                            <div class="username-cell">
                                <div class="avatar-circle ${u.role == 'admin' ? 'admin-av' : ''}">
                                    ${fn:substring(u.userName, 0, 1)}
                                </div>
                                <span class="username-text">${u.userName}</span>
                            </div>
                        </td>
                        <td>${u.fullName}</td>
                        <td style="color:#6b7280">${u.email}</td>
                        <td style="color:#6b7280">${u.phone}</td>
                        <td>
                            <span class="role-badge ${u.role == 'admin' ? 'admin' : 'customer'}">
                                ${u.role == 'admin' ? '⭐ ' : ''}${u.role}
                            </span>
                        </td>
                        <td>
                            <span class="status-badge ${u.isActive ? 'active' : 'locked'}">
                                <span class="status-dot"></span>
                                ${u.isActive ? 'Hoạt động' : 'Bị khóa'}
                            </span>
                        </td>
                        <td>
                            <div class="action-group">
                                <a href="${pageContext.request.contextPath}/admin/users/${u.userId}"
                                   class="action-btn" title="Xem chi tiết">👁️</a>
                                <form action="${pageContext.request.contextPath}/admin/users/${u.userId}/toggle-active"
                                      method="post" style="margin:0">
                                    <button type="submit"
                                            class="action-btn ${u.isActive ? 'lock' : 'unlock'}"
                                            title="${u.isActive ? 'Khóa tài khoản' : 'Mở khóa'}">
                                        ${u.isActive ? '🔒' : '🔓'}
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty users}">
                    <tr class="empty-row">
                        <td colspan="8">😶 Chưa có người dùng nào</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

</div>

<%@ include file="/WEB-INF/views/admin/layout/footer.jsp" %>


