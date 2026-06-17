<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${pageContext.request.contextPath}">
    <title>Account Details - FinTrust Global</title>

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
        }
        .detail-label {
            font-size: 0.8rem;
            color: var(--text-secondary);
            margin-bottom: 0.2rem;
        }
        .detail-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--text-primary);
        }
        .stat-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1rem;
        }
        .stat-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 1.25rem;
            text-align: center;
        }
        .stat-card .stat-number {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--text-primary);
        }
        .stat-card .stat-label {
            font-size: 0.8rem;
            color: var(--text-secondary);
            margin-top: 0.25rem;
        }
        @media (max-width: 768px) {
            .detail-grid { grid-template-columns: 1fr; }
            .stat-grid { grid-template-columns: repeat(2, 1fr); }
        }
    </style>
</head>
<body class="page-transition">

<div class="dashboard-container">
    <aside class="sidebar">
        <div>
            <div class="sidebar-brand">
                <a href="${pageContext.request.contextPath}/" style="display:flex; align-items:center; gap:0.5rem; color:inherit; text-decoration:none;">
                    <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path></svg>
                    <span>FinTrust</span>
                </a>
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
                <li class="sidebar-item">
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
                    <c:out value="${fn:substring(sessionScope.user.fullName, 0, 1)}" default="U" />
                </div>
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

    <main class="dashboard-main">
        <header class="top-navbar">
            <div class="search-bar">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                <input type="text" placeholder="Search accounts, statements...">
            </div>

            <div class="navbar-actions">
                <button class="nav-icon-btn theme-toggle-btn" aria-label="Toggle Theme">
                    <svg class="moon-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path></svg>
                    <svg class="sun-icon" style="display:none;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707m2.828 0l-.707-.707m12.728-12.728l-.707-.707M12 8a4 4 0 100 8 4 4 0 000-8z"></path></svg>
                </button>
            </div>
        </header>

        <div class="dashboard-content">
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

            <div class="content-header">
                <div>
                    <h1 class="page-title">Account Details</h1>
                    <p class="page-subtitle">Complete information for account ${account.accountNumber}</p>
                </div>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary" style="display:inline-flex; align-items:center; gap:0.5rem;">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:18px;height:18px;"><path stroke-linecap="round" stroke-linejoin="round" d="M19 12H5m7 7l-7-7 7-7"/></svg>
                    Back to Dashboard
                </a>
            </div>

            <div class="main-grid">
                <div class="column-main" style="gap: 2rem; display: flex; flex-direction: column;">

                    <div class="card">
                        <h3 class="mb-4">Account Information</h3>
                        <div class="detail-grid">
                            <div>
                                <div class="detail-label">Account Number</div>
                                <div class="detail-value" style="font-family: monospace; font-size: 1.15rem; letter-spacing: 0.08em;">${account.accountNumber}</div>
                            </div>
                            <div>
                                <div class="detail-label">Account Type</div>
                                <div class="detail-value">${account.accountType}</div>
                            </div>
                            <div>
                                <div class="detail-label">Balance</div>
                                <div class="detail-value" style="color: var(--success-color);">
                                    ₹<fmt:formatNumber value="${account.balance}" pattern="#,##0.00"/>
                                </div>
                            </div>
                            <div>
                                <div class="detail-label">Status</div>
                                <div class="detail-value">
                                    <span class="badge
                                        <c:choose>
                                            <c:when test="${account.status == 'ACTIVE'}">badge-success</c:when>
                                            <c:when test="${account.status == 'PENDING'}">badge-warning</c:when>
                                            <c:otherwise>badge-danger</c:otherwise>
                                        </c:choose>">
                                        ${account.status}
                                    </span>
                                </div>
                            </div>
                            <div style="grid-column: span 2;">
                                <div class="detail-label">Created Date</div>
                                <div class="detail-value"><fmt:formatDate value="${account.createdAt}" pattern="MMMM dd, yyyy 'at' hh:mm a"/></div>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <h3 class="mb-4">Account Statistics</h3>
                        <div class="stat-grid">
                            <div class="stat-card">
                                <div class="stat-number">${totalTransactions}</div>
                                <div class="stat-label">Total Transactions</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number" style="color: var(--success-color);">${totalDeposits}</div>
                                <div class="stat-label">Total Deposits</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number" style="color: var(--danger-color);">${totalWithdrawals}</div>
                                <div class="stat-label">Total Withdrawals</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-number" style="color: var(--warning-color);">${totalTransfers}</div>
                                <div class="stat-label">Total Transfers</div>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <h3 class="mb-4">Recent Transactions</h3>
                        <c:choose>
                            <c:when test="${empty transactions}">
                                <p style="color: var(--text-secondary); margin: 1rem 0;">No transactions recorded for this account.</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Transaction ID</th>
                                                <th>Date & Time</th>
                                                <th>Type</th>
                                                <th>Amount</th>
                                                <th>Sender</th>
                                                <th>Receiver</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="txn" items="${transactions}">
                                                <tr>
                                                    <td class="table-title-cell">#${txn.transactionId}</td>
                                                    <td class="table-sub-cell">
                                                        <fmt:formatDate value="${txn.transactionDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                    </td>
                                                    <td>
                                                        <span class="badge
                                                            <c:choose>
                                                                <c:when test="${txn.transactionType == 'DEPOSIT'}">badge-success</c:when>
                                                                <c:when test="${txn.transactionType == 'TRANSFER'}">badge-warning</c:when>
                                                                <c:otherwise>badge-danger</c:otherwise>
                                                            </c:choose>">
                                                            ${txn.transactionType}
                                                        </span>
                                                    </td>
                                                    <td style="font-weight: 700;
                                                        <c:choose>
                                                            <c:when test="${txn.transactionType == 'DEPOSIT'}">color: var(--success-color);</c:when>
                                                            <c:when test="${txn.transactionType == 'TRANSFER' && txn.receiverAccount == account.accountNumber}">color: var(--success-color);</c:when>
                                                            <c:otherwise>color: var(--danger-color);</c:otherwise>
                                                        </c:choose>">
                                                        <c:choose>
                                                            <c:when test="${txn.transactionType == 'DEPOSIT'}">+</c:when>
                                                            <c:when test="${txn.transactionType == 'TRANSFER' && txn.receiverAccount == account.accountNumber}">+</c:when>
                                                            <c:otherwise>-</c:otherwise>
                                                        </c:choose>
                                                        ₹<fmt:formatNumber value="${txn.amount}" pattern="#,##0.00"/>
                                                    </td>
                                                    <td style="font-family: monospace; font-size: 0.85rem;">
                                                        <c:choose>
                                                            <c:when test="${txn.transactionType == 'TRANSFER' && txn.senderAccount == account.accountNumber}">You (Sender)</c:when>
                                                            <c:when test="${txn.transactionType == 'TRANSFER'}">${txn.senderAccount}</c:when>
                                                            <c:otherwise>${not empty txn.senderAccount ? txn.senderAccount : '-'}</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td style="font-family: monospace; font-size: 0.85rem;">
                                                        <c:choose>
                                                            <c:when test="${txn.transactionType == 'TRANSFER' && txn.receiverAccount == account.accountNumber}">You (Receiver)</c:when>
                                                            <c:when test="${txn.transactionType == 'TRANSFER'}">${txn.receiverAccount}</c:when>
                                                            <c:otherwise>${not empty txn.receiverAccount ? txn.receiverAccount : '-'}</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span class="badge
                                                            <c:choose>
                                                                <c:when test="${txn.status == 'SUCCESS'}">badge-success</c:when>
                                                                <c:otherwise>badge-danger</c:otherwise>
                                                            </c:choose>">
                                                            ${txn.status}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>
            </div>
        </div>
    </main>
</div>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
</body>
</html>
