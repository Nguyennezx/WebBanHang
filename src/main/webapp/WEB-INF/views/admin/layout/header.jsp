<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #f5f5f5;
            color: #333;
        }

                .admin-wrapper {
            display: grid;
            grid-template-columns: 250px 1fr;
            grid-template-rows: auto 1fr; /* DÒNG PHÉP THUẬT SẼ ÉP CÁI HEADER NHỎ LẠI */
            min-height: 100vh;
        }


        /* ===== SIDEBAR ===== */
        .sidebar {
            background: #1e3a5f;
            color: white;
            padding: 20px 0;
            position: fixed;
            width: 250px;
            height: 100vh;
            overflow-y: auto;
        }

        .sidebar-logo {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 20px;
            font-size: 18px;
            font-weight: 700;
        }

        .sidebar-menu {
            list-style: none;
        }

        .sidebar-menu li {
            margin: 0;
        }

        .sidebar-menu a {
            display: block;
            padding: 12px 20px;
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }

        .sidebar-menu a:hover,
        .sidebar-menu a.active {
            background: rgba(255,255,255,0.1);
            color: white;
            border-left-color: #1890ff;
        }

        .sidebar-menu .icon {
            margin-right: 10px;
        }

        /* ===== HEADER ===== */
        .header {
            background: white;
            border-bottom: 1px solid #e0e0e0;
            padding: 16px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            grid-column: 2;
        }

        .header-title {
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }

        .header-user {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .header-user button {
            background: transparent;
            border: none;
            color: #666;
            cursor: pointer;
            font-size: 14px;
        }

        /* ===== MAIN CONTENT ===== */
        .content {
            grid-column: 2;
            padding: 24px;
            overflow-y: auto;
        }

        .content-card {
            background: white;
            border-radius: 4px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .page-title {
            font-size: 20px;
            font-weight: 600;
        }

        .btn-primary {
            background: #1890ff;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary:hover {
            background: #0050b3;
        }

        .alert {
            padding: 12px 16px;
            margin-bottom: 16px;
            border-radius: 4px;
        }

        .alert-success {
            background: #f6ffed;
            color: #52c41a;
            border: 1px solid #b7eb8f;
        }

        /* TABLE */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

        thead {
            background: #f5f5f5;
            border-bottom: 2px solid #d9d9d9;
        }

        th {
            padding: 12px;
            text-align: left;
            font-weight: 600;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #f0f0f0;
        }

        tbody tr:hover {
            background: #fafafa;
        }

        .btn-sm {
            padding: 4px 8px;
            margin-right: 6px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 11px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-edit {
            background: #1890ff;
            color: white;
        }

        .btn-delete {
            background: #f5222d;
            color: white;
        }

        .status-badge {
            padding: 4px 8px;
            border-radius: 3px;
            font-size: 11px;
            font-weight: 600;
        }

        .status-active {
            background: #f6ffed;
            color: #52c41a;
        }

        .status-inactive {
            background: #fff1f0;
            color: #f5222d;
        }

        @media (max-width: 768px) {
            .admin-wrapper {
                grid-template-columns: 1fr;
            }

            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
            }

            .header {
                grid-column: 1;
            }

            .content {
                grid-column: 1;
            }
        }
    </style>
</head>
<body>
    <div class="admin-wrapper">
        <!-- SIDEBAR -->
        <aside class="sidebar">
            <div class="sidebar-logo"> ShopNBH Admin</div>
            <ul class="sidebar-menu">
                <li><a href="/WebBanHang/admin/dashboard" class="active"><span class="icon">📊</span>Dashboard</a></li>
                <li><a href="/WebBanHang/admin/products"><span class="icon">📦</span>Sản phẩm</a></li>
                <li><a href="/WebBanHang/admin/categories"><span class="icon">📂</span>Danh mục</a></li>
                <li><a href="/WebBanHang/admin/brands"><span class="icon">🏷️</span>Thương hiệu</a></li>
                <li><a href="/WebBanHang/admin/users"><span class="icon">🏷️</span>Người Dùng</a></li>
                <li><a href="/WebBanHang/products"><span class="icon">👁️</span>Xem website</a></li>
                
            </ul>
        </aside>

        <!-- HEADER -->
        <header class="header">
            <div class="header-title">${pageTitle != null ? pageTitle : 'Admin'}</div>
            <div class="header-user">
                <span>👤 admin</span>
                <button>⚙️</button>
            </div>
        </header>

        <!-- CONTENT -->
        <main class="content">
