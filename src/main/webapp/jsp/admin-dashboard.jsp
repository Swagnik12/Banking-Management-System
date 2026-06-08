<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Banking Management System</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f3f4f6; margin: 0; color: #1f2937; }
        .navbar { background-color: #1e293b; color: white; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { margin: 0; font-size: 1.5rem; }
        .nav-links a { color: white; text-decoration: none; margin-left: 1.5rem; font-weight: 500; }
        .nav-links a:hover { text-decoration: underline; }
        .container { max-width: 1000px; margin: 2rem auto; padding: 0 1rem; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 1.5rem; margin-bottom: 2rem; }
        .stat-card { background: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); text-align: center; border-top: 4px solid #3b82f6; }
        .stat-card.active-accounts { border-top-color: #10b981; }
        .stat-card.suspended-accounts { border-top-color: #ef4444; }
        .stat-card.transactions { border-top-color: #f59e0b; }
        .stat-num { font-size: 2.25rem; font-weight: 700; color: #1e293b; margin: 0.5rem 0; }
        .stat-label { font-size: 0.85rem; color: #6b7280; text-transform: uppercase; font-weight: 600; letter-spacing: 0.05em; }
        .card { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); margin-bottom: 2rem; }
        .card h3 { margin-top: 0; border-bottom: 2px solid #f3f4f6; padding-bottom: 0.5rem; color: #1e293b; }
        .admin-actions { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; }
        .action-card { background-color: #f8fafc; border: 1px solid #e2e8f0; padding: 1.5rem; border-radius: 8px; text-align: center; }
        .action-card h4 { margin: 0 0 0.5rem 0; font-size: 1.1rem; color: #1e293b; }
        .action-card p { color: #6b7280; font-size: 0.9rem; margin-bottom: 1.25rem; }
        .btn { background-color: #3b82f6; color: white; padding: 0.6rem 1.2rem; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; font-weight: 500; display: inline-block; }
        .btn:hover { background-color: #2563eb; }
    </style>
</head>
<body>

    <div class="navbar">
        <h1>Apex Trust - Admin Panel</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/accounts">Manage Accounts</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>

    <div class="container">
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-num">${stats.totalUsers}</div>
                <div class="stat-label">Total Users</div>
            </div>
            <div class="stat-card">
                <div class="stat-num">${stats.totalAccounts}</div>
                <div class="stat-label">Total Accounts</div>
            </div>
            <div class="stat-card active-accounts">
                <div class="stat-num">${stats.activeAccounts}</div>
                <div class="stat-label">Active Accounts</div>
            </div>
            <div class="stat-card suspended-accounts">
                <div class="stat-num">${stats.suspendedAccounts}</div>
                <div class="stat-label">Suspended Accounts</div>
            </div>
            <div class="stat-card transactions">
                <div class="stat-num">${stats.totalTransactions}</div>
                <div class="stat-label">Transactions Logged</div>
            </div>
        </div>

        <div class="card">
            <h3>Administrative Control Center</h3>
            <p style="color: #4b5563; margin-bottom: 2rem;">Manage registrations, toggle account permissions, or inspect client assets.</p>
            
            <div class="admin-actions">
                <div class="action-card">
                    <h4>User Account Approvals</h4>
                    <p>Approve pending registrations, reactivate or suspend customer profiles.</p>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn">Manage Users &rarr;</a>
                </div>
                
                <div class="action-card">
                    <h4>Bank Asset Management</h4>
                    <p>Approve pending bank accounts, activate, freeze or suspend client checking/savings.</p>
                    <a href="${pageContext.request.contextPath}/admin/accounts" class="btn">Manage Accounts &rarr;</a>
                </div>
            </div>
        </div>

    </div>

</body>
</html>
