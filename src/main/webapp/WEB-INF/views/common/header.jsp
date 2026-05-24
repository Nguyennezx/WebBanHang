<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopNBH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary: #1a73e8;
            --primary-dark: #0d47a1;
        }

        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; }

        /* ── TOPBAR ── */
        .topbar {
            background: var(--primary-dark);
            color: #fff;
            font-size: 0.8rem;
            padding: 5px 0;
        }
        .topbar a { color: #ffd54f; text-decoration: none; }
        .topbar a:hover { text-decoration: underline; }

        /* ── HEADER ── */
        .main-header {
            background: var(--primary);
            padding: 12px 0;
            position: sticky;
            top: 0;
            z-index: 999;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }

        .main-header .logo {
            font-size: 1.6rem;
            font-weight: 800;
            color: #fff;
            text-decoration: none;
            letter-spacing: -1px;
        }
        .main-header .logo span { color: #ffd54f; }

        /* Search */
        .search-bar { flex: 1; max-width: 480px; margin: 0 24px; }
        .search-bar .form-control {
            border-radius: 8px 0 0 8px;
            border: none;
            padding: 9px 14px;
            font-size: 0.95rem;
        }
        .search-bar .form-control:focus { box-shadow: none; }
        .search-bar .btn-search {
            background: #ffd54f;
            border: none;
            border-radius: 0 8px 8px 0;
            padding: 9px 18px;
            color: #333;
            font-weight: 600;
        }
        .search-bar .btn-search:hover { background: #ffca28; }

        /* Header actions */
        .header-actions { display: flex; align-items: center; gap: 16px; }

        .header-actions .action-btn {
            color: #fff;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 0.75rem;
            position: relative;
            transition: opacity 0.2s;
        }
        .header-actions .action-btn:hover { opacity: 0.85; }
        .header-actions .action-btn i { font-size: 1.4rem; }

        .cart-badge {
            position: absolute;
            top: -4px; right: -8px;
            background: #ff3d00;
            color: #fff;
            font-size: 0.65rem;
            font-weight: 700;
            border-radius: 50%;
            width: 18px; height: 18px;
            display: flex; align-items: center; justify-content: center;
            transition: all 0.2s ease;
        }
        
        .cart-badge.bounce {
            animation: badgeBounce 0.4s ease-out;
        }
        
        @keyframes badgeBounce {
            0% { transform: scale(1); }
            50% { transform: scale(1.4); }
            100% { transform: scale(1); }
        }

        /* Dropdown user */
        .user-dropdown .dropdown-toggle {
            color: #fff;
            background: none;
            border: 1.5px solid rgba(255,255,255,0.5);
            border-radius: 8px;
            padding: 6px 14px;
            font-size: 0.85rem;
            display: flex; align-items: center; gap: 6px;
        }
        .user-dropdown .dropdown-toggle:hover { background: rgba(255,255,255,0.15); }
        .user-dropdown .dropdown-toggle::after { display: none; }

        /* ── NAVBAR ── */
        .main-nav {
            background: #fff;
            border-bottom: 1px solid #e0e0e0;
        }
        .main-nav .nav-link {
            color: #333;
            font-size: 0.9rem;
            font-weight: 500;
            padding: 10px 16px;
            transition: color 0.2s;
        }
        .main-nav .nav-link:hover { color: var(--primary); }
        .main-nav .nav-link.active { color: var(--primary); border-bottom: 2px solid var(--primary); }

        /* Toast Notification */
        .toast-container {
            position: fixed;
            top: 90px;
            right: 24px;
            z-index: 9999;
            display: flex;
            flex-direction: column;
            gap: 12px;
            pointer-events: none;
        }
        .custom-toast {
            background: #2e7d32;
            color: #fff;
            padding: 14px 24px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            font-size: 0.95rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
            opacity: 0;
            transform: translateY(-20px);
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            pointer-events: auto;
        }
        .custom-toast.show {
            opacity: 1;
            transform: translateY(0);
        }
        .custom-toast.error {
            background: #d32f2f;
        }
    </style>
</head>
<body>

<!-- Topbar -->
<div class="topbar">
    <div class="container d-flex justify-content-between">
        <span>Chào mừng đến với ShopNBH!</span>
        <span>
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    Xin chào, <strong>${sessionScope.loggedInUser.fullName}</strong>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">Đăng nhập</a> |
                    <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </span>
    </div>
</div>

<!-- Main Header -->
<header class="main-header">
    <div class="container d-flex align-items-center">

        <!-- Logo -->
        <a href="${pageContext.request.contextPath}/home" class="logo me-4">
            Shop<span>NBH</span>
        </a>

        <!-- Search -->
         <div class="search-bar d-flex">
            <form action="${pageContext.request.contextPath}/products" method="get" class="d-flex w-100">
                <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm sản phẩm..." value="${keyword != null ? keyword : ''}">
                <button type="submit" class="btn-search"><i class="bi bi-search"></i></button>
            </form>
        </div>

        <!-- Actions -->
        <div class="header-actions ms-auto">

            <!-- Giỏ hàng -->
            <a href="${pageContext.request.contextPath}/cart" class="action-btn">
                <span style="position:relative">
                    <i class="bi bi-cart3"></i>
                    <span class="cart-badge">${cartSize != null ? cartSize : 0}</span>
                </span>
                <span>Giỏ hàng</span>
            </a>

            <!-- Đơn hàng -->
            <a href="${pageContext.request.contextPath}/order/history" class="action-btn">
                <i class="bi bi-receipt"></i>
                <span>Đơn hàng</span>
            </a>

            <!-- User menu -->
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <div class="user-dropdown dropdown">
                        <button type="button" class="dropdown-toggle">
                            <i class="bi bi-person-circle"></i>
                            ${sessionScope.loggedInUser.fullName}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                <i class="bi bi-person me-2"></i>Tài khoản của tôi
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/order/history">
                                <i class="bi bi-bag me-2"></i>Đơn hàng của tôi
                            </a></li>
                            <c:if test="${sessionScope.loggedInUser.role == 'admin'}">
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/admin/dashboard">
                                    <i class="bi bi-speedometer2 me-2"></i>Quản trị
                                </a></li>
                            </c:if>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                            </a></li>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="action-btn">
                        <i class="bi bi-person-circle"></i>
                        <span>Đăng nhập</span>
                    </a>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</header>

<!-- Navbar danh mục -->
<nav class="main-nav">
    <div class="container">
        <ul class="nav">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/home">
                    <i class="bi bi-house me-1"></i>Trang chủ
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/products">
                    <i class="bi bi-grid me-1"></i>Sản phẩm
                </a>
            </li>
            <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" role="button" aria-expanded="false" onclick="return false;">
    <i class="bi bi-list me-1"></i>Danh mục
</a>
       
    <ul class="dropdown-menu">
        <c:forEach var="cat" items="${categories}">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products/category/${cat.categoryId}">${cat.categoryName}</a></li>
        </c:forEach>
    </ul>
</li>
        </ul>
    </div>
</nav>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- ✅ THÊM SCRIPT NÀY -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Xử lý dropdown thủ công
    const dropdownToggles = document.querySelectorAll('.dropdown-toggle');
    const userDropdownToggles = document.querySelectorAll('.user-dropdown > .dropdown-toggle');

    userDropdownToggles.forEach(toggle => {
        toggle.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            toggleUserDropdown(this);
        });
    });
    
    dropdownToggles.forEach(toggle => {
        if (toggle.closest('.user-dropdown')) {
            return;
        }

        toggle.addEventListener('click', function(e) {
            e.preventDefault();
            console.log("✅ Dropdown clicked!");
            
            const menu = this.nextElementSibling;
            if (menu && menu.classList.contains('dropdown-menu')) {
                menu.classList.toggle('show');
                this.setAttribute('aria-expanded', this.getAttribute('aria-expanded') === 'true' ? 'false' : 'true');
            }
        });
    });
    
    // Đóng dropdown khi click ngoài
    document.addEventListener('click', function(e) {
        dropdownToggles.forEach(toggle => {
            const menu = toggle.nextElementSibling;
            if (menu && !toggle.contains(e.target) && !menu.contains(e.target)) {
                menu.classList.remove('show');
                toggle.setAttribute('aria-expanded', 'false');
            }
        });
    });
});

function toggleUserDropdown(button) {
    const menu = button.nextElementSibling;
    if (menu && menu.classList.contains('dropdown-menu')) {
        menu.classList.toggle('show');
        button.setAttribute('aria-expanded', menu.classList.contains('show') ? 'true' : 'false');
    }
}

// Hàm hiển thị Toast thông báo đẹp mắt
function showToast(message, type = 'success') {
    let container = document.getElementById("toastContainer");
    if (!container) {
        container = document.createElement("div");
        container.id = "toastContainer";
        container.className = "toast-container";
        document.body.appendChild(container);
    }
    
    const toast = document.createElement("div");
    toast.className = "custom-toast " + (type === 'error' ? 'error' : '');
    
    const icon = type === 'error' 
        ? '<i class="bi bi-exclamation-triangle-fill"></i>' 
        : '<i class="bi bi-check-circle-fill"></i>';
        
    toast.innerHTML = icon + ' <span>' + message + '</span>';
    container.appendChild(toast);
    
    // Trigger reflow
    void toast.offsetWidth;
    toast.classList.add("show");
    
    // Tự động ẩn sau 3 giây
    setTimeout(() => {
        toast.classList.remove("show");
        setTimeout(() => {
            toast.remove();
        }, 300);
    }, 3000);
}

// Hàm thêm vào giỏ hàng toàn cục dùng AJAX
function addToCartGlobal(productId, qty) {
    qty = qty || 1;
    const contextPath = "${pageContext.request.contextPath}";
    
    // Tạo form url encoded data
    const params = new URLSearchParams();
    params.append("productId", productId);
    params.append("quantity", qty);
    
    fetch(contextPath + "/cart/add-ajax", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        },
        body: params.toString()
    })
    .then(response => response.text())
    .then(data => {
        if (data === "not_logged_in") {
            showToast("Vui lòng đăng nhập để thêm vào giỏ hàng!", "error");
            setTimeout(() => {
                window.location.href = contextPath + "/login";
            }, 1000);
        } else if (data === "product_not_found") {
            showToast("Không tìm thấy sản phẩm này!", "error");
        } else if (data.startsWith("success:")) {
            const newCount = data.split(":")[1];
            const badge = document.querySelector(".cart-badge");
            if (badge) {
                badge.textContent = newCount;
                // Kích hoạt hiệu ứng bounce
                badge.classList.remove("bounce");
                void badge.offsetWidth; // Trigger reflow
                badge.classList.add("bounce");
            }
            showToast("Đã thêm sản phẩm vào giỏ hàng thành công!");
        } else {
            showToast("Có lỗi xảy ra khi thêm vào giỏ hàng!", "error");
        }
    })
    .catch(error => {
        console.error("Error adding to cart:", error);
        showToast("Lỗi kết nối hệ thống!", "error");
    });
}
</script>
</body>
</html>
