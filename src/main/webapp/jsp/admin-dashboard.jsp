<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${pageContext.request.contextPath}">
    <title>Admin Dashboard - FinTrust Global</title>
    
    <!-- Design System Resource Imports -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">
    
    <style>
        .admin-metrics-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.25rem;
            margin-bottom: 2.5rem;
        }

        .admin-card-icon {
            width: 38px;
            height: 38px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--bg-main);
            color: var(--text-secondary);
        }

        .metric-card-admin {
            border-top: 4px solid var(--primary-color);
        }

        .metric-card-admin.users { border-top-color: var(--primary-color); }
        .metric-card-admin.accounts { border-top-color: var(--info-color); }
        .metric-card-admin.active { border-top-color: var(--success-color); }
        .metric-card-admin.suspended { border-top-color: var(--danger-color); }
        .metric-card-admin.transactions { border-top-color: var(--warning-color); }

        .control-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        .control-card {
            background-color: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 2.25rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all var(--transition-normal);
        }

        .control-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
            border-color: var(--primary-color);
        }

        .control-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .control-icon {
            width: 48px;
            height: 48px;
            border-radius: var(--radius-md);
            background-color: rgba(20, 184, 166, 0.08);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .control-icon svg {
            width: 24px;
            height: 24px;
            fill: none;
            stroke: currentColor;
            stroke-width: 2;
        }

        .control-title {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--text-primary);
        }

        .control-desc {
            font-size: 0.88rem;
            color: var(--text-secondary);
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        @media (max-width: 1200px) {
            .admin-metrics-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .admin-metrics-grid {
                grid-template-columns: 1fr;
            }
            .control-grid {
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
                    <a href="${pageContext.request.contextPath}/admin/dashboard" style="display:flex; align-items:center; gap:0.5rem; color:inherit; text-decoration:none;">
                        <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path></svg>
                        <span>Admin Portal</span>
                    </a>
                </div>
                
                <ul class="sidebar-menu">
                    <li class="sidebar-item active">
                        <a href="${pageContext.request.contextPath}/admin/dashboard">
                            <svg viewBox="0 0 24 24"><path d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/></svg>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="sidebar-item">
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
                <div class="search-bar">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                    <input type="text" placeholder="Search system database records...">
                </div>

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
                        <h1 class="page-title">System Overview</h1>
                        <p class="page-subtitle">Real-time performance metrics and admin management console</p>
                    </div>
                    <span class="badge badge-success" style="font-size: 0.75rem; padding: 0.4rem 0.8rem;">Live Network Status: Optimal</span>
                </div>

                <!-- Admin Metrics Panel Grid -->
                <div class="admin-metrics-grid">
                    <div class="card metric-card metric-card-admin users">
                        <div class="metric-header">
                            <span class="metric-title">Total Customers</span>
                            <div class="admin-card-icon">
                                <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width:18px;height:18px;"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2M9 11a4 4 0 100-8 4 4 0 000 8z"/></svg>
                            </div>
                        </div>
                        <div class="metric-value">${stats.totalUsers}</div>
                        <span class="metric-trend up">Registered customers</span>
                    </div>

                    <div class="card metric-card metric-card-admin" style="border-top-color: var(--warning-color);">
                        <div class="metric-header">
                            <span class="metric-title">Pending Approvals</span>
                            <div class="admin-card-icon" style="color:var(--warning-color); background-color:var(--warning-bg);">
                                <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width:18px;height:18px;"><path d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                            </div>
                        </div>
                        <div class="metric-value">${stats.pendingUsers}</div>
                        <span class="metric-trend" style="color: var(--warning-color);">Awaiting activation</span>
                    </div>

                    <div class="card metric-card metric-card-admin accounts">
                        <div class="metric-header">
                            <span class="metric-title">Total Accounts</span>
                            <div class="admin-card-icon">
                                <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width:18px;height:18px;"><path d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/></svg>
                            </div>
                        </div>
                        <div class="metric-value">${stats.totalAccounts}</div>
                        <span class="metric-trend up">All bank accounts</span>
                    </div>

                    <div class="card metric-card metric-card-admin active">
                        <div class="metric-header">
                            <span class="metric-title">Active Accounts</span>
                            <div class="admin-card-icon" style="color:var(--success-color); background-color:var(--success-bg);">
                                <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width:18px;height:18px;"><path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                            </div>
                        </div>
                        <div class="metric-value">${stats.activeAccounts}</div>
                        <span class="metric-trend up">Fully operational</span>
                    </div>

                    <div class="card metric-card metric-card-admin suspended">
                        <div class="metric-header">
                            <span class="metric-title">Frozen Accounts</span>
                            <div class="admin-card-icon" style="color:var(--danger-color); background-color:var(--danger-bg);">
                                <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width:18px;height:18px;"><path d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/></svg>
                            </div>
                        </div>
                        <div class="metric-value">${stats.frozenAccounts}</div>
                        <span class="metric-trend down">Admin restricted</span>
                    </div>

                    <div class="card metric-card metric-card-admin transactions">
                        <div class="metric-header">
                            <span class="metric-title">Transactions</span>
                            <div class="admin-card-icon" style="color:var(--warning-color); background-color:var(--warning-bg);">
                                <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width:18px;height:18px;"><path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2"/></svg>
                            </div>
                        </div>
                        <div class="metric-value">${stats.totalTransactions}</div>
                        <span class="metric-trend up">All time total</span>
                    </div>
                </div>

                <!-- Admin Action Control Center -->
                <div class="card">
                    <h3 class="mb-2">Administrative Control Center</h3>
                    <p style="color: var(--text-secondary); margin-bottom: 2.5rem; font-size: 0.95rem;">Audit registrations, toggle user profile settings, adjust account limits, and inspect institutional transactional flows.</p>
                    
                    <div class="control-grid">
                        <div class="control-card">
                            <div class="control-header">
                                <div class="control-icon">
                                    <svg viewBox="0 0 24 24"><path d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/></svg>
                                </div>
                                <h4 class="control-title">Customer Approvals & Access</h4>
                            </div>
                            <p class="control-desc">Approve pending registrations, reactivate user logins, or inspect customer audit trails.</p>
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary" style="width: auto; align-self: flex-start; padding: 0.75rem 1.5rem;">
                                <span>Manage Users</span>
                                <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width:16px;height:16px;"><path stroke-linecap="round" stroke-linejoin="round" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                            </a>
                        </div>
                        
                        <div class="control-card">
                            <div class="control-header">
                                <div class="control-icon" style="color: var(--info-color); background-color: var(--info-bg);">
                                    <svg viewBox="0 0 24 24"><path d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/></svg>
                                </div>
                                <h4 class="control-title">Bank Asset Management</h4>
                            </div>
                            <p class="control-desc">Activate newly opened accounts, freeze flagged assets, or configure overdraft configurations.</p>
                            <a href="${pageContext.request.contextPath}/admin/accounts" class="btn btn-primary" style="background-color: var(--info-color); width: auto; align-self: flex-start; padding: 0.75rem 1.5rem;">
                                <span>Manage Accounts</span>
                                <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width:16px;height:16px;"><path stroke-linecap="round" stroke-linejoin="round" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                            </a>
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
