<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fund Transfer - FinTrust Global</title>
    
    <!-- Design System Resource Imports -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">
    
    <style>
        .main-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 2rem;
            align-items: start;
        }

        .op-card-title {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1rem;
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
                    <li class="sidebar-item">
                        <a href="${pageContext.request.contextPath}/dashboard">
                            <svg viewBox="0 0 24 24"><path d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/></svg>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="sidebar-item active">
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

        <!-- Main Workspace -->
        <main class="dashboard-main">
            <!-- Top Utility Navbar -->
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
                    <button class="nav-icon-btn" aria-label="Notifications">
                        <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path></svg>
                    </button>
                </div>
            </header>

            <div class="dashboard-content">
                <div class="content-header">
                    <div>
                        <h1 class="page-title">Transfer Funds</h1>
                        <p class="page-subtitle">Send money safely to other bank accounts instantly</p>
                    </div>
                </div>

                <div class="main-grid">
                    <!-- Central Transfer Form Panel -->
                    <div class="card">
                        <h3 class="mb-4">Secure Transfer</h3>
                        
                        <!-- Success/Error Feedback notifications -->
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

                        <form action="${pageContext.request.contextPath}/transfer" method="post">
                            <div class="form-group">
                                <label for="fromAccountNumber">Sender Account</label>
                                <div class="input-wrapper">
                                    <select id="fromAccountNumber" name="fromAccountNumber" required class="input-field">
                                        <option value="">-- Select Source Account --</option>
                                        <c:forEach var="acc" items="${accounts}">
                                            <c:if test="${acc.status == 'ACTIVE'}">
                                                <option value="${acc.accountNumber}">
                                                    ${acc.accountType} (*${fn:substring(acc.accountNumber, fn:length(acc.accountNumber) - 4, fn:length(acc.accountNumber))}) &mdash; Bal: $<fmt:formatNumber value="${acc.balance}" pattern="#,##0.00"/>
                                                </option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="toAccountNumber">Receiver Account / IBAN</label>
                                <div class="input-wrapper">
                                    <input type="text" id="toAccountNumber" name="toAccountNumber" required placeholder="Enter recipient's name or account number" class="input-field">
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="amount">Amount (USD)</label>
                                    <div class="input-wrapper">
                                        <input type="number" id="amount" name="amount" step="0.01" min="0.01" required placeholder="0.00" class="input-field">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="frequency">Frequency</label>
                                    <div class="input-wrapper">
                                        <select id="frequency" class="input-field">
                                            <option>One-time transfer</option>
                                            <option>Weekly recurring</option>
                                            <option>Monthly recurring</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="remark">Remark (Optional)</label>
                                <div class="input-wrapper">
                                    <textarea id="remark" placeholder="e.g. Rent Payment, Dinner split..." class="input-field" style="min-height: 80px;"></textarea>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn btn-primary mt-2">
                                <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width: 18px; height: 18px;"><path stroke-linecap="round" stroke-linejoin="round" d="M6 12L3.269 3.126A59.768 59.768 0 0121.485 12 59.77 59.77 0 013.27 20.876L5.999 12zm0 0h7.5"></path></svg>
                                <span>Complete Transfer</span>
                            </button>
                        </form>
                    </div>

                    <!-- Right limits and quick widgets sidebar panel -->
                    <div class="column-side">
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

                        <!-- Security trust indicator badge -->
                        <div class="card d-flex align-center" style="gap: 1rem; flex-direction: row; padding: 1.25rem;">
                            <div class="avatar avatar-green" style="width: 42px; height: 42px; background-color: rgba(16, 185, 129, 0.08); flex-shrink: 0;">
                                <svg viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" fill="none" style="width: 22px; height: 22px;"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path></svg>
                            </div>
                            <div>
                                <div style="font-weight: 700; font-size: 0.85rem; color: var(--text-primary);">Secure Transaction</div>
                                <div style="font-size: 0.72rem; color: var(--text-secondary); line-height: 1.35; margin-top: 0.15rem;">Protected by 256-bit encryption. No transaction fees apply.</div>
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
