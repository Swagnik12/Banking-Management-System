<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${pageContext.request.contextPath}">
    <title>Customer Details - Admin Portal</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">
    <style>
        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        .detail-row {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }
        .detail-label {
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-muted);
        }
        .detail-value {
            font-size: 0.95rem;
            font-weight: 500;
            color: var(--text-primary);
        }
        .profile-header {
            display: flex;
            align-items: center;
            gap: 1.25rem;
            margin-bottom: 2rem;
        }
        .profile-avatar {
            width: 64px;
            height: 64px;
            border-radius: var(--radius-full);
            background-color: rgba(20, 184, 166, 0.1);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            font-weight: 700;
            flex-shrink: 0;
        }
        .summary-strip {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .summary-item {
            padding: 1rem 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .summary-icon {
            width: 36px;
            height: 36px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .summary-icon svg { width: 18px; height: 18px; fill: none; stroke: currentColor; stroke-width: 2; }
        .summary-label { font-size: 0.75rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-muted); }
        .summary-value { font-size: 1.4rem; font-weight: 700; color: var(--text-primary); line-height: 1; }
        @media (max-width: 768px) {
            .detail-grid { grid-template-columns: 1fr; }
            .summary-strip { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <!-- Sidebar -->
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

    <!-- Main -->
    <main class="dashboard-main">
        <!-- Top Navbar -->
        <header class="top-navbar">
            <div class="search-bar">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                <input type="text" placeholder="Search system database records...">
            </div>
            <div class="navbar-actions">
                <button class="nav-icon-btn theme-toggle-btn" aria-label="Toggle Theme">
                    <svg class="moon-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path></svg>
                    <svg class="sun-icon" style="display:none;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707m2.828 0l-.707-.707m12.728-12.728l-.707-.707M12 8a4 4 0 100 8 4 4 0 000-8z"></path></svg>
                </button>
                <div class="notification-wrapper">
                    <button class="nav-icon-btn notification-btn" aria-label="View Notifications">
                        <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path></svg>
                        <span class="notification-badge">0</span>
                    </button>
                    <div class="notification-dropdown">
                        <div class="notification-header">
                            <h4>Notifications</h4>
                            <span class="notification-count-text">0 New</span>
                        </div>
                        <div class="notification-body" id="notification-list"></div>
                        <div class="notification-footer">
                            <a href="#" id="clear-all-notifications" style="display:none; margin-right:15px; color:var(--danger-color);">Clear All</a>
                            <a href="${pageContext.request.contextPath}/admin/notifications">View All Notifications</a>
                        </div>
                    </div>
                </div>
                <button class="btn btn-primary" onclick="window.location.reload();" style="width:auto; padding:0.5rem 1rem; font-size:0.85rem;">System Refresh</button>
            </div>
        </header>

        <div class="dashboard-content">

            <!-- Breadcrumb -->
            <div style="display:flex; align-items:center; gap:0.5rem; margin-bottom:1.5rem; font-size:0.85rem; color:var(--text-muted);">
                <a href="${pageContext.request.contextPath}/admin/users" style="color:var(--text-muted);">Customers</a>
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:14px;height:14px;"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>
                <span style="color:var(--text-primary); font-weight:600;">${customer.fullName}</span>
            </div>

            <div class="content-header">
                <div>
                    <h1 class="page-title">Customer Details</h1>
                    <p class="page-subtitle">Full profile, accounts and transaction history for this customer.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary" style="width:auto; padding:0.5rem 1.25rem; font-size:0.85rem;">
                    &larr; Back to Customers
                </a>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <!-- Summary strip -->
            <div class="summary-strip">
                <div class="card summary-item">
                    <div class="summary-icon" style="background:rgba(20,184,166,0.1); color:var(--primary-color);">
                        <svg viewBox="0 0 24 24"><path d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/></svg>
                    </div>
                    <div>
                        <div class="summary-label">Total Accounts</div>
                        <div class="summary-value">${accounts.size()}</div>
                    </div>
                </div>
                <div class="card summary-item">
                    <div class="summary-icon" style="background:var(--success-bg); color:var(--success-color);">
                        <svg viewBox="0 0 24 24"><path d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                    </div>
                    <div>
                        <div class="summary-label">Total Balance</div>
                        <div class="summary-value" style="color:var(--success-color);">₹<fmt:formatNumber value="${totalBalance}" pattern="#,##0.00"/></div>
                    </div>
                </div>
                <div class="card summary-item">
                    <div class="summary-icon" style="background:var(--warning-bg); color:var(--warning-color);">
                        <svg viewBox="0 0 24 24"><path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/></svg>
                    </div>
                    <div>
                        <div class="summary-label">Transactions</div>
                        <div class="summary-value">${transactions.size()}</div>
                    </div>
                </div>
            </div>

            <!-- Profile card -->
            <div class="card glass-card" style="margin-bottom:1.5rem;">
                <div class="profile-header">
                    <div class="profile-avatar">${customer.fullName.substring(0,1).toUpperCase()}</div>
                    <div>
                        <div style="font-size:1.25rem; font-weight:700; color:var(--text-primary);">${customer.fullName}</div>
                        <div style="font-size:0.85rem; color:var(--text-secondary); margin-top:0.2rem;">${customer.email}</div>
                        <div style="margin-top:0.5rem;">
                            <c:choose>
                                <c:when test="${customer.status == 'ACTIVE'}"><span class="badge badge-success">ACTIVE</span></c:when>
                                <c:when test="${customer.status == 'PENDING'}"><span class="badge badge-warning">PENDING</span></c:when>
                                <c:otherwise><span class="badge badge-danger">${customer.status}</span></c:otherwise>
                            </c:choose>
                            <span class="badge badge-info" style="margin-left:0.4rem;">${customer.role}</span>
                        </div>
                    </div>
                </div>
                <div class="detail-grid">
                    <div class="detail-row">
                        <span class="detail-label">User ID</span>
                        <span class="detail-value">#${customer.userId}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Phone</span>
                        <span class="detail-value">${not empty customer.phone ? customer.phone : '—'}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Email</span>
                        <span class="detail-value">${customer.email}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Address</span>
                        <span class="detail-value">${not empty customer.address ? customer.address : '—'}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Member Since</span>
                        <span class="detail-value"><fmt:formatDate value="${customer.createdAt}" pattern="dd MMM yyyy"/></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Account Status</span>
                        <span class="detail-value">${customer.status}</span>
                    </div>
                </div>
            </div>

            <!-- Accounts table -->
            <div class="card glass-card" style="margin-bottom:1.5rem;">
                <div class="card-header" style="margin-bottom:1rem;">
                    <h3>Bank Accounts</h3>
                </div>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Account ID</th>
                                <th>Account Number</th>
                                <th>Type</th>
                                <th>Balance</th>
                                <th>Status</th>
                                <th>Opened</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="acc" items="${accounts}">
                                <tr>
                                    <td style="color:var(--text-muted);">#${acc.accountId}</td>
                                    <td style="font-family:monospace; font-weight:600; color:var(--primary-color);">${acc.accountNumber}</td>
                                    <td><span style="font-weight:500;">${acc.accountType}</span></td>
                                    <td style="font-weight:700; color:var(--success-color);">₹<fmt:formatNumber value="${acc.balance}" pattern="#,##0.00"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${acc.status == 'ACTIVE'}"><span class="badge badge-success">ACTIVE</span></c:when>
                                            <c:when test="${acc.status == 'FROZEN'}"><span class="badge badge-danger">FROZEN</span></c:when>
                                            <c:when test="${acc.status == 'PENDING'}"><span class="badge badge-warning">PENDING</span></c:when>
                                            <c:otherwise><span class="badge badge-secondary">${acc.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="color:var(--text-muted); font-size:0.85rem;"><fmt:formatDate value="${acc.createdAt}" pattern="dd MMM yyyy"/></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty accounts}">
                                <tr>
                                    <td colspan="6" style="text-align:center; padding:2rem; color:var(--text-secondary);">No accounts found for this customer.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Transactions table -->
            <div class="card glass-card">
                <div class="card-header" style="margin-bottom:1rem;">
                    <h3>Transaction History</h3>
                </div>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Type</th>
                                <th>Amount</th>
                                <th>From</th>
                                <th>To</th>
                                <th>Status</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="txn" items="${transactions}">
                                <tr>
                                    <td style="color:var(--text-muted);">#${txn.transactionId}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${txn.transactionType == 'DEPOSIT'}"><span class="badge badge-success">DEPOSIT</span></c:when>
                                            <c:when test="${txn.transactionType == 'WITHDRAWAL'}"><span class="badge badge-danger">WITHDRAWAL</span></c:when>
                                            <c:otherwise><span class="badge badge-info">TRANSFER</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="font-weight:700;">₹<fmt:formatNumber value="${txn.amount}" pattern="#,##0.00"/></td>
                                    <td style="font-family:monospace; font-size:0.85rem;">${not empty txn.senderAccount ? txn.senderAccount : '—'}</td>
                                    <td style="font-family:monospace; font-size:0.85rem;">${not empty txn.receiverAccount ? txn.receiverAccount : '—'}</td>
                                    <td><span class="badge badge-success">${txn.status}</span></td>
                                    <td style="color:var(--text-muted); font-size:0.85rem; white-space:nowrap;"><fmt:formatDate value="${txn.transactionDate}" pattern="dd MMM yyyy HH:mm"/></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty transactions}">
                                <tr>
                                    <td colspan="7" style="text-align:center; padding:2rem; color:var(--text-secondary);">No transactions found for this customer.</td>
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
