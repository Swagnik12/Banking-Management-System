<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${pageContext.request.contextPath}">
    <title>Manage Customers - Admin Portal</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">
</head>
<body>

  <div class="dashboard-container">
        <!-- Sidebar Left Panel -->
        <aside class="sidebar">
            <div>
            <div class="sidebar-brand">
                <a href="${pageContext.request.contextPath}/admin/dashboard" style="display:flex; align-items:center; gap:0.5rem; color:inherit; text-decoration:none;">
                    <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path></svg>
                    <span>Admin Portal</span>
                </a>
            </div>
                
                <ul class="sidebar-menu">
                    <li class="sidebar-item">
                        <a href="${pageContext.request.contextPath}/admin/dashboard">
                            <svg viewBox="0 0 24 24"><path d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/></svg>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="sidebar-item active">
                        <a href="${pageContext.request.contextPath}/admin/users">
                            <svg viewBox="0 0 24 24"><path d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0-.001h6v-1a6 6 0 00-9-5.197M12 7a3 3 0 100-6 3 3 0 000 6z"/></svg>
                            <span>Customers</span>
                        </a>
                    </li>
                    <li class="sidebar-item">
                        <a href="${pageContext.request.contextPath}/admin/accounts">
                            <svg viewBox="0 0 24 24"><path d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/></svg>
                            <span>Accounts</span>
                        </a>
                    </li>
                    <li class="sidebar-item">
                        <a href="${pageContext.request.contextPath}/admin/notifications">
                            <svg viewBox="0 0 24 24"><path d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/></svg>
                            <span>Notifications</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="sidebar-footer">
                <div class="sidebar-profile">
                    <div class="avatar avatar-green">${sessionScope.user.fullName.substring(0,1)}</div>
                    <div class="sidebar-profile-info">
                        <div class="sidebar-profile-name">${sessionScope.user.fullName}</div>
                        <div class="sidebar-profile-role">${sessionScope.user.role} Account</div>
                    </div>
                </div>
                <ul class="sidebar-menu">
                    <li class="sidebar-item">
                        <a href="${pageContext.request.contextPath}/logout" style="color: var(--danger-color)">
                            <svg viewBox="0 0 24 24" stroke="currentColor"><path d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/></svg>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </div>
        </aside>

        <!-- Main Dashboard View -->
        <main class="dashboard-main">
            <!-- Top Utility Navbar -->
            <header class="top-navbar">
                <form action="${pageContext.request.contextPath}/admin/users" method="get" class="search-bar">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                    <input type="text" name="search" value="${searchQuery}" placeholder="Search system database records...">
                    <button type="submit" style="display:none;"></button>
                </form>

                <div class="navbar-actions">
                    <!-- Theme Toggle Switch -->
                    <button class="nav-icon-btn theme-toggle-btn" aria-label="Toggle Theme">
                        <svg class="moon-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path></svg>
                        <svg class="sun-icon" style="display:none;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707m2.828 0l-.707-.707m12.728-12.728l-.707-.707M12 8a4 4 0 100 8 4 4 0 000-8z"></path></svg>
                    </button>
                    <!-- Bell Icon with Dropdown -->
                    <div class="notification-wrapper">
                        <button class="nav-icon-btn notification-btn" aria-label="View Notifications">
                            <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path></svg>
                            <span class="notification-badge">3</span>
                        </button>

                        <div class="notification-dropdown">
                            <div class="notification-header">
                                <h4>Notifications</h4>
                                <span class="notification-count-text">0 New</span>
                            </div>
                            <div class="notification-body" id="notification-list">
                                <!-- Populated by JS -->
                            </div>
                            <div class="notification-footer">
                                <a href="#" id="clear-all-notifications" style="display:none; margin-right: 15px; color: var(--danger-color);">Clear All</a>
                                <a href="${pageContext.request.contextPath}/admin/notifications">View All Notifications</a>
                            </div>
                        </div>
                    </div>
                    
                    <button class="btn btn-primary" onclick="window.location.reload();" style="width: auto; padding: 0.5rem 1rem; font-size: 0.85rem;">System Refresh</button>
                </div>
            </header>
            <div class="dashboard-content">

            <div class="content-header">
    <div>
        <h1 class="page-title">Customer Management</h1>
        <p class="page-subtitle">
            Manage customer registrations and account access.
        </p>
    </div>
</div>

<c:if test="${not empty success}">
    <div class="alert alert-success">${success}</div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert alert-error">${error}</div>
</c:if>

<div class="card glass-card">
      <div class="card-header">
        <h3>Customer Registrations</h3>
    </div>

	<div class="table-responsive">
    <table class="table">
        <thead>
            <tr>
                <th>User ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Status</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="usr" items="${users}">
                <tr>
                    <td>#${usr.userId}</td>
                    <td style="font-weight: 500;"><a href="${pageContext.request.contextPath}/customer-details?id=${usr.userId}" style="color:var(--primary-color); text-decoration:none; font-weight:600;">${usr.fullName}</a></td>
                    <td>${usr.email}</td>
                    <td>${usr.phone}</td>
                    <td>
                        <span style="font-size: 0.85rem; font-weight: 600;">
                            ${usr.role}
                        </span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${usr.status == 'ACTIVE'}">
                                <span class="badge badge-success">
                                    ACTIVE
                                </span>
                            </c:when>

                            <c:when test="${usr.status == 'PENDING'}">
                                <span class="badge badge-warning">
                                    PENDING
                                </span>
                            </c:when>

                            <c:otherwise>
                                <span class="badge badge-danger">
                                    SUSPENDED
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <fmt:formatDate value="${usr.createdAt}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        <c:if test="${usr.role != 'ADMIN'}">
                            <form action="${pageContext.request.contextPath}/admin/users" method="post" style="display:inline;">
                                <input type="hidden" name="userId" value="${usr.userId}">

                                <c:choose>
                                    <c:when test="${usr.status == 'PENDING'}">
                                        <input type="hidden" name="action" value="approve">
                                        <button type="submit" class="btn btn-success btn-sm">Approve User</button>
                                    </c:when>

                                    <c:when test="${usr.status == 'ACTIVE'}">
                                        <input type="hidden" name="action" value="suspend">
                                        <button type="submit" class="btn btn-danger btn-sm">Suspend User</button>
                                    </c:when>

                                    <c:when test="${usr.status == 'SUSPENDED'}">
                                        <input type="hidden" name="action" value="activate">
                                        <button type="submit" class="btn btn-primary btn-sm">Reactivate</button>
                                    </c:when>
                                </c:choose>
                            </form>
                            <a href="${pageContext.request.contextPath}/admin/users/details?id=${usr.userId}"
                               class="btn btn-secondary btn-sm" style="margin-left:0.4rem;">View</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty users}">
                <tr>
                    <td colspan="8" style="text-align: center; padding: 2rem; color: var(--text-secondary);">No users found.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
    </div>
</div>

</div>

</main>
</div>
    


<script src="${pageContext.request.contextPath}/js/theme.js"></script>
</body>
</html>
