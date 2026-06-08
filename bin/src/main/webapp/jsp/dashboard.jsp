<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard - Banking Management System</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f3f4f6; margin: 0; color: #1f2937; }
        .navbar { background-color: #1e3a8a; color: white; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { margin: 0; font-size: 1.5rem; }
        .nav-links a { color: white; text-decoration: none; margin-left: 1.5rem; font-weight: 500; }
        .nav-links a:hover { text-decoration: underline; }
        .container { max-width: 1000px; margin: 2rem auto; padding: 0 1rem; }
        .welcome-card { background-color: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); margin-bottom: 2rem; }
        .welcome-card h2 { margin: 0 0 0.5rem 0; color: #1e3a8a; }
        .grid { display: grid; grid-template-columns: 2fr 1fr; gap: 2rem; }
        .card { background: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); margin-bottom: 1.5rem; }
        .card h3 { margin-top: 0; border-bottom: 2px solid #f3f4f6; padding-bottom: 0.5rem; color: #1f2937; }
        table { width: 100%; border-collapse: collapse; margin-top: 1rem; text-align: left; }
        th, td { padding: 0.75rem; border-bottom: 1px solid #e5e7eb; }
        th { background-color: #f9fafb; color: #4b5563; font-weight: 600; }
        .status-badge { padding: 0.25rem 0.5rem; border-radius: 9999px; font-size: 0.75rem; font-weight: 600; text-transform: uppercase; }
        .status-active { background-color: #dcfce7; color: #166534; }
        .status-pending { background-color: #fef9c3; color: #854d0e; }
        .status-suspended { background-color: #fee2e2; color: #991b1b; }
        .alert { padding: 0.75rem; border-radius: 6px; margin-bottom: 1.25rem; font-size: 0.9rem; }
        .alert-error { background-color: #fee2e2; color: #991b1b; border: 1px solid #fca5a5; }
        .alert-success { background-color: #dcfce7; color: #166534; border: 1px solid #86efac; }
        .btn { background-color: #2563eb; color: white; padding: 0.5rem 1rem; border: none; border-radius: 6px; cursor: pointer; font-weight: 500; }
        .btn:hover { background-color: #1d4ed8; }
        .btn-link { text-decoration: none; display: inline-block; }
        select { padding: 0.5rem; border-radius: 6px; border: 1px solid #d1d5db; margin-right: 0.5rem; font-size: 0.9rem; }
        .actions-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1rem; margin-top: 1rem; }
        .action-box { background-color: #eff6ff; border: 1px solid #bfdbfe; border-radius: 8px; padding: 1rem; text-align: center; }
        .action-box a { color: #1e3a8a; text-decoration: none; font-weight: 600; display: block; margin-bottom: 0.5rem; }
        .action-box a:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <div class="navbar">
        <h1>Apex Trust Bank</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/profile">My Profile</a>
            <a href="${pageContext.request.contextPath}/transactions">Transactions</a>
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

        <div class="welcome-card">
            <h2>Welcome back, ${sessionScope.user.fullName}!</h2>
            <p style="margin: 0; color: #6b7280;">Email: ${sessionScope.user.email} | Role: ${sessionScope.user.role}</p>
        </div>

        <div class="grid">
            <div>
                <!-- Accounts Section -->
                <div class="card">
                    <h3>My Bank Accounts</h3>
                    
                    <c:choose>
                        <c:when test="${empty accounts}">
                            <p style="color: #6b7280; margin: 1rem 0;">You have no active accounts yet. Open one below.</p>
                        </c:when>
                        <c:otherwise>
                            <table>
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
                                            <td style="font-family: monospace; font-size: 1.05rem; font-weight: 600;">${acc.accountNumber}</td>
                                            <td>${acc.accountType}</td>
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
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>

                    <!-- Application Form -->
                    <form action="${pageContext.request.contextPath}/dashboard" method="post" style="margin-top: 1.5rem; display: flex; align-items: center; gap: 0.5rem; border-top: 1px solid #f3f4f6; padding-top: 1.25rem;">
                        <span style="font-weight: 500;">Open a New Account:</span>
                        <select name="accountType" required>
                            <option value="SAVINGS">Savings Account</option>
                            <option value="CURRENT">Current Account</option>
                        </select>
                        <button type="submit" class="btn">Apply Now</button>
                    </form>
                </div>

                <!-- Recent Transactions -->
                <div class="card">
                    <h3>Recent Transactions</h3>
                    <c:choose>
                        <c:when test="${empty recentTransactions}">
                            <p style="color: #6b7280; margin: 1rem 0;">No transactions found for your active accounts.</p>
                        </c:when>
                        <c:otherwise>
                            <table>
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
                                            <td>
                                                <fmt:formatDate value="${txn.transactionDate}" pattern="yyyy-MM-dd HH:mm"/>
                                            </td>
                                            <td><span style="font-weight: 600; font-size: 0.85rem;">${txn.transactionType}</span></td>
                                            <td style="font-weight: 600; 
                                                <c:choose>
                                                    <c:when test="${txn.transactionType == 'DEPOSIT'}">color: #166534;</c:when>
                                                    <c:otherwise>color: #991b1b;</c:otherwise>
                                                </c:choose>">
                                                <c:choose>
                                                    <c:when test="${txn.transactionType == 'DEPOSIT'}">+</c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                                $<fmt:formatNumber value="${txn.amount}" pattern="#,##0.00"/>
                                            </td>
                                            <td style="font-size: 0.9rem; color: #4b5563;">
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
                            <div style="margin-top: 1rem; text-align: right;">
                                <a href="${pageContext.request.contextPath}/transactions" style="color: #2563eb; text-decoration: none; font-weight: 500; font-size: 0.9rem;">View All Transactions &rarr;</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Quick Banking Operations -->
            <div>
                <div class="card">
                    <h3>Banking Operations</h3>
                    <div class="actions-grid" style="display: flex; flex-direction: column; gap: 1rem;">
                        <div class="action-box">
                            <a href="${pageContext.request.contextPath}/deposit">Deposit Funds</a>
                            <span style="font-size: 0.8rem; color: #6b7280;">Add funds into your active accounts</span>
                        </div>
                        <div class="action-box">
                            <a href="${pageContext.request.contextPath}/withdraw">Withdraw Funds</a>
                            <span style="font-size: 0.8rem; color: #6b7280;">Cash out from your active accounts</span>
                        </div>
                        <div class="action-box" style="background-color: #f0fdf4; border-color: #bbf7d0;">
                            <a href="${pageContext.request.contextPath}/transfer" style="color: #166534;">Fund Transfer</a>
                            <span style="font-size: 0.8rem; color: #6b7280;">Send money to another bank account</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</body>
</html>
