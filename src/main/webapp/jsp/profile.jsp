<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${pageContext.request.contextPath}">
    <title>My Profile - FinTrust Global</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">

    <style>
        .profile-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            align-items: start;
        }
        @media (max-width: 900px) {
            .profile-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body class="page-transition">

<div class="dashboard-container">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div>
            <div class="sidebar-brand">
                <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path></svg>
                <span>FinTrust</span>
            </div>
            <ul class="sidebar-menu">
                <li class="sidebar-item">
                    <a href="${pageContext.request.contextPath}/dashboard">
                        <svg viewBox="0 0 24 24"><path d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/></svg>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a href="${pageContext.request.contextPath}/transfer">
                        <svg viewBox="0 0 24 24"><path d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"/></svg>
                        <span>Transfer</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a href="${pageContext.request.contextPath}/deposit">
                        <svg viewBox="0 0 24 24"><path d="M12 4v16m8-8H4"/></svg>
                        <span>Deposit</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a href="${pageContext.request.contextPath}/withdraw">
                        <svg viewBox="0 0 24 24"><path d="M20 12H4"/></svg>
                        <span>Withdraw</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a href="${pageContext.request.contextPath}/transactions">
                        <svg viewBox="0 0 24 24"><path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"/></svg>
                        <span>Transactions</span>
                    </a>
                </li>
                <li class="sidebar-item active">
                    <a href="${pageContext.request.contextPath}/profile">
                        <svg viewBox="0 0 24 24"><path d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/></svg>
                        <span>My Profile</span>
                    </a>
                </li>
            </ul>
        </div>
        <div class="sidebar-footer">
            <div class="sidebar-profile">
                <div class="avatar avatar-blue">
                    <c:out value="${fn:substring(sessionScope.user.fullName, 0, 1)}" default="U"/>
                </div>
                <div class="sidebar-profile-info">
                    <div class="sidebar-profile-name">${sessionScope.user.fullName}</div>
                    <div class="sidebar-profile-role">${sessionScope.user.role} Account</div>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li class="sidebar-item">
                    <a href="${pageContext.request.contextPath}/logout" style="color:var(--danger-color)">
                        <svg viewBox="0 0 24 24" stroke="currentColor"><path d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/></svg>
                        <span>Logout</span>
                    </a>
                </li>
            </ul>
        </div>
    </aside>

    <!-- Main -->
    <main class="dashboard-main">
        <header class="top-navbar">
            <div class="search-bar">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                <input type="text" placeholder="Search features...">
            </div>
            <div class="navbar-actions">
                <button class="nav-icon-btn theme-toggle-btn" aria-label="Toggle Theme">
                    <svg class="moon-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path></svg>
                    <svg class="sun-icon" style="display:none;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707m2.828 0l-.707-.707m12.728-12.728l-.707-.707M12 8a4 4 0 100 8 4 4 0 000-8z"></path></svg>
                </button>

            </div>
        </header>

        <div class="dashboard-content">
            <div class="content-header">
                <div>
                    <h1 class="page-title">My Profile</h1>
                    <p class="page-subtitle">Manage your personal information and security settings</p>
                </div>
            </div>

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:20px;height:20px;flex-shrink:0;"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <span>${success}</span>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:20px;height:20px;flex-shrink:0;"><path stroke-linecap="round" stroke-linejoin="round" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <span>${error}</span>
                </div>
            </c:if>

            <div class="profile-grid">
                <!-- Profile Update Card -->
                <div class="card">
                    <h3 class="mb-4">Update Profile Details</h3>
                    <form action="${pageContext.request.contextPath}/profile" method="post">
                        <input type="hidden" name="action" value="updateProfile">

                        <div class="form-group">
                            <label for="email">Email Address (Cannot be changed)</label>
                            <div class="input-wrapper">
                                <input type="email" id="email" class="input-field" value="${profileUser.email}" disabled style="background:var(--border-color);cursor:not-allowed;">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="fullName">Full Name</label>
                            <div class="input-wrapper">
                                <input type="text" id="fullName" name="fullName" required value="${profileUser.fullName}" class="input-field">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <div class="input-wrapper">
                                <input type="text" id="phone" name="phone" required value="${profileUser.phone}" class="input-field">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="address">Residential Address</label>
                            <div class="input-wrapper">
                                <input type="text" id="address" name="address" required value="${profileUser.address}" class="input-field">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </form>
                </div>

                <!-- Password Change Card -->
                <div class="card">
                    <h3 class="mb-4">Change Password</h3>
                    <form action="${pageContext.request.contextPath}/profile" method="post">
                        <input type="hidden" name="action" value="changePassword">

                        <div class="form-group">
                            <label for="oldPassword">Current Password</label>
                            <div class="input-wrapper">
                                <input type="password" id="oldPassword" name="oldPassword" required placeholder="Enter current password" class="input-field">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="newPassword">New Password</label>
                            <div class="input-wrapper">
                                <input type="password" id="newPassword" name="newPassword" required placeholder="Min 6 characters" class="input-field">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmNewPassword">Confirm New Password</label>
                            <div class="input-wrapper">
                                <input type="password" id="confirmNewPassword" name="confirmNewPassword" required placeholder="Re-enter new password" class="input-field">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary">Update Password</button>
                    </form>
                </div>
            </div>
        </div>
    </main>
</div>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
</body>
</html>