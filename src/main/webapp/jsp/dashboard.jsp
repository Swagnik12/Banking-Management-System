<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - FinTrust Global</title>
    
    <!-- Design System Resource Imports -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">
    
    <style>
        /* Sidebar styling enhancements */
        .sidebar-brand-icon {
            color: var(--primary-color);
        }
        
        .main-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            align-items: start;
        }

        .op-card-title {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1rem;
        }

        .quick-action-link {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1.25rem;
            border-radius: var(--radius-md);
            background-color: var(--bg-main);
            border: 1px solid var(--border-color);
            transition: all var(--transition-fast);
            margin-bottom: 0.75rem;
        }

        .quick-action-link:hover {
            transform: translateY(-2px);
            border-color: var(--primary-color);
            background-color: var(--bg-card);
            box-shadow: var(--shadow-sm);
        }

        .quick-action-info {
            display: flex;
            flex-direction: column;
            gap: 0.15rem;
        }

        .quick-action-title {
            font-weight: 700;
            font-size: 0.95rem;
            color: var(--text-primary);
        }

        .quick-action-desc {
            font-size: 0.75rem;
            color: var(--text-secondary);
        }

        .quick-action-arrow {
            color: var(--text-muted);
            transition: color var(--transition-fast);
        }

        .quick-action-link:hover .quick-action-arrow {
            color: var(--primary-color);
        }

        @media (max-width: 1024px) {
            .main-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body class="page-transition">

    <div class="dashboard-container">
        <!-- Sidebar Left Panel -->
        <aside class="sidebar">
            <div>
                <div class="sidebar-brand">
                    <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path></svg>
                    <span>FinTrust</span>
                </div>
                
                <ul class="sidebar-menu">
                    <li class="sidebar-item active">
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

        <!-- Main Dashboard View -->
        <main class="dashboard-main">
            <!-- Top Utility Navbar -->
            <header class="top-navbar">
                <div class="search-bar">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                    <input type="text" placeholder="Search accounts, statements...">
                </div>

                <div class="navbar-actions">
                    <!-- Theme Toggle Switch -->
                    <button class="nav-icon-btn theme-toggle-btn" aria-label="Toggle Theme">
                        <svg class="moon-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path></svg>
                        <svg class="sun-icon" style="display:none;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707m2.828 0l-.707-.707m12.728-12.728l-.707-.707M12 8a4 4 0 100 8 4 4 0 000-8z"></path></svg>
                    </button>
                    <!-- Bell Icon -->
                    <button class="nav-icon-btn" aria-label="View Notifications">
                        <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path></svg>
                    </button>
                </div>
            </header>

            <div class="dashboard-content">
                <!-- Session Success / Error Dialog Alerts -->
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
                        <h1 class="page-title">Welcome back, ${sessionScope.user.fullName}!</h1>
                        <p class="page-subtitle">Email: ${sessionScope.user.email} | Secure Customer Portal</p>
                    </div>
                </div>

                <!-- Main Layout Grid -->
                <div class="main-grid">
                    <div class="column-main" style="gap: 2rem; display: flex; flex-direction: column;">
                        <!-- My Bank Accounts Card -->
                        <div class="card">
                            <h3 class="mb-4">My Bank Accounts</h3>
                            
                            <c:choose>
                                <c:when test="${empty accounts}">
                                    <p style="color: var(--text-secondary); margin: 1rem 0;">You have no active accounts yet. Open one below.</p>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Account Number</th>
                                                    <th>Account Type</th>
                                                    <th>Balance</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="acc" items="${accounts}">
                                                    <tr>
                                                        <td class="table-title-cell" style="font-family: monospace; font-size: 1rem; letter-spacing: 0.05em;">
                                                            ${acc.accountNumber}
                                                        </td>
                                                        <td>
                                                            <div class="avatar-cell">
                                                                <span class="avatar avatar-gray" style="width:28px;height:28px;font-size:0.75rem;">
                                                                    <c:out value="${fn:substring(acc.accountType, 0, 2)}" default="BA"/>
                                                                </span>
                                                                <span>${acc.accountType}</span>
                                                            </div>
                                                        </td>
                                                        <td style="font-weight: 700; color: var(--success-color); font-size: 0.95rem;">
                                                            $<fmt:formatNumber value="${acc.balance}" pattern="#,##0.00"/>
                                                        </td>
                                                        <td>
                                                            <span class="badge 
                                                                <c:choose>
                                                                    <c:when test="${acc.status == 'ACTIVE'}">badge-success</c:when>
                                                                    <c:when test="${acc.status == 'PENDING'}">badge-warning</c:when>
                                                                    <c:otherwise>badge-danger</c:otherwise>
                                                                </c:choose>">
                                                                ${acc.status}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <!-- Create New Bank Account Form -->
                            <form action="${pageContext.request.contextPath}/dashboard" method="post" style="margin-top: 2rem; display: flex; align-items: center; justify-content: flex-end; gap: 0.75rem; border-top: 1px solid var(--border-color); padding-top: 1.5rem;">
                                <label style="margin-bottom: 0; font-size: 0.9rem; font-weight: 600;">Open a New Account:</label>
                                <select name="accountType" required class="input-field" style="width: 200px; margin-right: 0;">
                                    <option value="SAVINGS">Savings Account</option>
                                    <option value="CURRENT">Current Account</option>
                                </select>
                                <button type="submit" class="btn btn-primary" style="width: auto; padding: 0.65rem 1.5rem;">Apply Now</button>
                            </form>
                        </div>

                        <!-- Recent Transactions List Card -->
                        <div class="card">
                            <h3 class="mb-4">Recent Transactions</h3>
                            
                            <c:choose>
                                <c:when test="${empty recentTransactions}">
                                    <p style="color: var(--text-secondary); margin: 1rem 0;">No transactions found for your active accounts.</p>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Type</th>
                                                    <th>Amount</th>
                                                    <th>Details</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="txn" items="${recentTransactions}">
                                                    <tr>
                                                        <td class="table-sub-cell">
                                                            <fmt:formatDate value="${txn.transactionDate}" pattern="yyyy-MM-dd HH:mm"/>
                                                        </td>
                                                        <td>
                                                            <span class="badge 
                                                                <c:choose>
                                                                    <c:when test="${txn.transactionType == 'DEPOSIT'}">badge-success</c:when>
                                                                    <c:otherwise>badge-danger</c:otherwise>
                                                                </c:choose>">
                                                                ${txn.transactionType}
                                                            </span>
                                                        </td>
                                                        <td style="font-weight: 700; font-size: 0.95rem;
                                                            <c:choose>
                                                                    <c:when test="${txn.transactionType == 'DEPOSIT'}">color: var(--success-color);</c:when>
                                                                    <c:otherwise>color: var(--danger-color);</c:otherwise>
                                                            </c:choose>">
                                                            <c:choose>
                                                                <c:when test="${txn.transactionType == 'DEPOSIT'}">+</c:when>
                                                                <c:otherwise>-</c:otherwise>
                                                            </c:choose>
                                                            $<fmt:formatNumber value="${txn.amount}" pattern="#,##0.00"/>
                                                        </td>
                                                        <td class="table-sub-cell">
                                                            <c:choose>
                                                                <c:when test="${txn.transactionType == 'TRANSFER'}">
                                                                    To/From Acc: ${txn.senderAccount == accounts[0].accountNumber ? txn.receiverAccount : txn.senderAccount}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Self Transaction
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div style="margin-top: 1.5rem; text-align: right;">
                                        <a href="${pageContext.request.contextPath}/transactions" class="btn btn-secondary" style="width: auto; font-size: 0.85rem; padding: 0.5rem 1.25rem;">
                                            <span>View All Transactions</span>
                                            <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width:14px;height:14px;"><path stroke-linecap="round" stroke-linejoin="round" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Sidebar Right Info Panels -->
                    <div class="column-side" style="gap: 2rem; display: flex; flex-direction: column;">
                        <!-- Banking Operations Quick Action Panel -->
                        <div class="card">
                            <h3 class="op-card-title">Banking Operations</h3>
                            <div class="operations-list">
                                <a href="${pageContext.request.contextPath}/deposit" class="quick-action-link">
                                    <div class="quick-action-info">
                                        <span class="quick-action-title">Deposit Funds</span>
                                        <span class="quick-action-desc">Add funds into active accounts</span>
                                    </div>
                                    <svg class="quick-action-arrow" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:18px;height:18px;"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"></path></svg>
                                </a>
                                
                                <a href="${pageContext.request.contextPath}/withdraw" class="quick-action-link">
                                    <div class="quick-action-info">
                                        <span class="quick-action-title">Withdraw Funds</span>
                                        <span class="quick-action-desc">Cash out from your active accounts</span>
                                    </div>
                                    <svg class="quick-action-arrow" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:18px;height:18px;"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"></path></svg>
                                </a>
                                
                                <a href="${pageContext.request.contextPath}/transfer" class="quick-action-link" style="border-color: rgba(16, 185, 129, 0.2); background-color: var(--success-bg)">
                                    <div class="quick-action-info">
                                        <span class="quick-action-title" style="color: var(--success-color);">Fund Transfer</span>
                                        <span class="quick-action-desc">Send money to another bank account</span>
                                    </div>
                                    <svg class="quick-action-arrow" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:18px;height:18px;color: var(--success-color);"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"></path></svg>
                                </a>
                            </div>
                        </div>

                        <!-- Reference limits mockup widget -->
                        <div class="card limit-card">
                            <h3 class="op-card-title">Daily Limits</h3>
                            <div class="limit-info d-flex justify-between align-center mt-2">
                                <span class="text-muted" style="font-size: 0.8rem;">$12,500 / $50,000 Used</span>
                                <span class="font-bold" style="font-size: 0.8rem; font-weight: 700;">25%</span>
                            </div>
                            <div class="limit-progress-bar">
                                <div class="limit-progress-fill" style="width: 25%;"></div>
                            </div>
                            <div class="limits-labels d-flex justify-between mt-2" style="font-size: 0.75rem;">
                                <div>
                                    <div class="text-muted">Single TX Limit</div>
                                    <div style="font-weight: 700; font-size: 0.95rem; margin-top: 0.15rem;">$10,000</div>
                                </div>
                                <div class="text-right">
                                    <div class="text-muted">Remaining Daily</div>
                                    <div style="font-weight: 700; font-size: 0.95rem; margin-top: 0.15rem;">$37,500</div>
                                </div>
                            </div>
                        </div>

                        <!-- Reference recipients mockup list -->
                        <div class="card">
                            <h3 class="op-card-title">Recent Recipients</h3>
                            <div class="recipients-list">
                                <button type="button" class="recipient-avatar-btn new-btn">
                                    <div class="avatar">
                                        <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width:20px;height:20px;"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"></path></svg>
                                    </div>
                                    <span>New</span>
                                </button>
                                <button type="button" class="recipient-avatar-btn">
                                    <div class="avatar avatar-blue">SW</div>
                                    <span>Sarah W.</span>
                                </button>
                                <button type="button" class="recipient-avatar-btn">
                                    <div class="avatar avatar-green">JK</div>
                                    <span>James K.</span>
                                </button>
                                <button type="button" class="recipient-avatar-btn">
                                    <div class="avatar avatar-red">EM</div>
                                    <span>Elon M.</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Layout scripts integration -->
    <script src="${pageContext.request.contextPath}/js/theme.js"></script>
</body>
</html>
