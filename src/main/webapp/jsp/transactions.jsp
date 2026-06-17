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
    <title>Transaction History - FinTrust Global</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">

    <style>
        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 1rem;
            align-items: end;
        }
        .filter-grid .form-group {
            margin-bottom: 0;
        }
        .filter-actions {
            display: flex;
            gap: 0.75rem;
            align-items: end;
        }
        @media (max-width: 640px) {
            .filter-grid {
                grid-template-columns: 1fr;
            }
            .filter-actions {
                flex-direction: column;
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
                <li class="sidebar-item active">
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
                <input type="text" placeholder="Search transactions...">
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
                    <h1 class="page-title">Transaction History</h1>
                    <p class="page-subtitle">View and filter all your banking transactions</p>
                </div>
            </div>

            <div class="card">
                <h3 class="mb-4">Filters</h3>
                <form action="${pageContext.request.contextPath}/transactions" method="get" class="filter-grid">
                    <div class="form-group">
                        <label for="accountNumber">Account</label>
                        <div class="input-wrapper">
                            <select id="accountNumber" name="accountNumber" class="input-field">
                                <option value="">All Accounts</option>
                                <c:forEach var="acc" items="${accounts}">
                                    <option value="${acc.accountNumber}" <c:if test="${acc.accountNumber == selectedAccount}">selected</c:if>>
                                        ${acc.accountType} (${acc.accountNumber})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="transactionType">Transaction Type</label>
                        <div class="input-wrapper">
                            <select id="transactionType" name="transactionType" class="input-field">
                                <option value="ALL" <c:if test="${selectedType == 'ALL'}">selected</c:if>>All Types</option>
                                <option value="DEPOSIT" <c:if test="${selectedType == 'DEPOSIT'}">selected</c:if>>Deposits</option>
                                <option value="WITHDRAWAL" <c:if test="${selectedType == 'WITHDRAWAL'}">selected</c:if>>Withdrawals</option>
                                <option value="TRANSFER" <c:if test="${selectedType == 'TRANSFER'}">selected</c:if>>Transfers</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="fromDate">From Date</label>
                        <div class="input-wrapper">
                            <input type="date" id="fromDate" name="fromDate" value="${fromDate}" class="input-field">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="toDate">To Date</label>
                        <div class="input-wrapper">
                            <input type="date" id="toDate" name="toDate" value="${toDate}" class="input-field">
                        </div>
                    </div>

                    <div class="filter-actions">
                        <button type="submit" class="btn btn-primary">Apply Filters</button>
                        <a href="${pageContext.request.contextPath}/transactions" class="btn btn-secondary">Clear</a>
                    </div>
                </form>
            </div>

            <div class="card">
                <h3 class="mb-4">Transaction Records</h3>

                <c:choose>
                    <c:when test="${empty transactions}">
                        <p style="color: var(--text-secondary); margin: 2rem 0; text-align: center;">No transactions found matching the filter criteria.</p>
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
                                                    <c:when test="${txn.transactionType == 'TRANSFER' && txn.receiverAccount == selectedAccount}">color: var(--success-color);</c:when>
                                                    <c:otherwise>color: var(--danger-color);</c:otherwise>
                                                </c:choose>">
                                                <c:choose>
                                                    <c:when test="${txn.transactionType == 'DEPOSIT'}">+</c:when>
                                                    <c:when test="${txn.transactionType == 'TRANSFER' && txn.receiverAccount == selectedAccount}">+</c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                                ₹<fmt:formatNumber value="${txn.amount}" pattern="#,##0.00"/>
                                            </td>
                                            <td style="font-family: monospace; font-size: 0.85rem;">
                                                <c:choose>
                                                    <c:when test="${txn.transactionType == 'TRANSFER' && txn.senderAccount == selectedAccount}">You (Sender)</c:when>
                                                    <c:when test="${txn.transactionType == 'TRANSFER'}">${txn.senderAccount}</c:when>
                                                    <c:otherwise>${not empty txn.senderAccount ? txn.senderAccount : '-'}</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="font-family: monospace; font-size: 0.85rem;">
                                                <c:choose>
                                                    <c:when test="${txn.transactionType == 'TRANSFER' && txn.receiverAccount == selectedAccount}">You (Receiver)</c:when>
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
    </main>
</div>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
</body>
</html>