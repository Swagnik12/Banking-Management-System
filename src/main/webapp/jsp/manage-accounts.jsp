<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Accounts - Admin Panel</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f3f4f6; margin: 0; color: #1f2937; }
        .navbar { background-color: #1e293b; color: white; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { margin: 0; font-size: 1.5rem; }
        .nav-links a { color: white; text-decoration: none; margin-left: 1.5rem; font-weight: 500; }
        .nav-links a:hover { text-decoration: underline; }
        .container { max-width: 1000px; margin: 2rem auto; padding: 0 1rem; }
        .card { background: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); }
        .card h3 { margin-top: 0; border-bottom: 2px solid #f3f4f6; padding-bottom: 0.5rem; color: #1e293b; }
        table { width: 100%; border-collapse: collapse; margin-top: 1rem; text-align: left; }
        th, td { padding: 0.75rem; border-bottom: 1px solid #e5e7eb; }
        th { background-color: #f9fafb; color: #4b5563; font-weight: 600; }
        .status-badge { padding: 0.25rem 0.5rem; border-radius: 9999px; font-size: 0.75rem; font-weight: 600; text-transform: uppercase; }
        .status-active { background-color: #dcfce7; color: #166534; }
        .status-pending { background-color: #fef9c3; color: #854d0e; }
        .status-suspended { background-color: #fee2e2; color: #991b1b; }
        .btn { padding: 0.4rem 0.8rem; border: none; border-radius: 4px; cursor: pointer; font-size: 0.85rem; font-weight: 600; }
        .btn-activate { background-color: #10b981; color: white; }
        .btn-activate:hover { background-color: #059669; }
        .btn-suspend { background-color: #ef4444; color: white; }
        .btn-suspend:hover { background-color: #dc2626; }
        .alert { padding: 0.75rem; border-radius: 6px; margin-bottom: 1.25rem; font-size: 0.9rem; }
        .alert-error { background-color: #fee2e2; color: #991b1b; border: 1px solid #fca5a5; }
        .alert-success { background-color: #dcfce7; color: #166534; border: 1px solid #86efac; }
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
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <div class="card">
            <h3>Customer Bank Accounts</h3>
            
            <table>
                <thead>
                    <tr>
                        <th>Account ID</th>
                        <th>Account Number</th>
                        <th>User ID</th>
                        <th>Account Type</th>
                        <th>Balance</th>
                        <th>Status</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="acc" items="${accounts}">
                        <tr>
                            <td>#${acc.accountId}</td>
                            <td style="font-family: monospace; font-size: 1.05rem; font-weight: 600;">${acc.accountNumber}</td>
                            <td>User #${acc.userId}</td>
                            <td><span style="font-weight: 500;">${acc.accountType}</span></td>
                            <td style="font-weight: 600; color: #166534;">
                                $<fmt:formatNumber value="${acc.balance}" pattern="#,##0.00"/>
                            </td>
                            <td>
                                <span class="status-badge 
                                    <c:choose>
                                        <c:when test="${acc.status == 'ACTIVE'}">status-active</c:when>
                                        <c:when test="${acc.status == 'PENDING'}">status-pending</c:when>
                                        <c:otherwise>status-suspended</c:otherwise>
                                    </c:choose>">
                                    ${acc.status}
                                </span>
                            </td>
                            <td>
                                <fmt:formatDate value="${acc.createdAt}" pattern="yyyy-MM-dd"/>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/accounts" method="post" style="display:inline;">
                                    <input type="hidden" name="accountId" value="${acc.accountId}">
                                    
                                    <c:choose>
                                        <c:when test="${acc.status == 'PENDING' || acc.status == 'SUSPENDED'}">
                                            <input type="hidden" name="action" value="activate">
                                            <button type="submit" class="btn btn-activate">Activate Account</button>
                                        </c:when>
                                        <c:when test="${acc.status == 'ACTIVE'}">
                                            <input type="hidden" name="action" value="suspend">
                                            <button type="submit" class="btn btn-suspend">Freeze / Suspend</button>
                                        </c:when>
                                    </c:choose>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
