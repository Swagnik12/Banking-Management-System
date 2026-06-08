<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Transaction History - Banking Management System</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f3f4f6; margin: 0; color: #1f2937; }
        .navbar { background-color: #1e3a8a; color: white; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { margin: 0; font-size: 1.5rem; }
        .nav-links a { color: white; text-decoration: none; margin-left: 1.5rem; font-weight: 500; }
        .nav-links a:hover { text-decoration: underline; }
        .container { max-width: 950px; margin: 2rem auto; padding: 0 1rem; }
        .card { background: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); margin-bottom: 1.5rem; }
        .card h3 { margin-top: 0; border-bottom: 2px solid #f3f4f6; padding-bottom: 0.5rem; color: #1e3a8a; }
        .filter-form { display: flex; flex-wrap: wrap; gap: 1rem; align-items: flex-end; margin-bottom: 1.5rem; }
        .filter-group { display: flex; flex-direction: column; flex: 1; min-width: 150px; }
        .filter-group label { font-size: 0.85rem; color: #4b5563; margin-bottom: 0.25rem; font-weight: 500; }
        select, input[type="date"] { padding: 0.5rem; border: 1px solid #d1d5db; border-radius: 6px; font-size: 0.9rem; }
        .btn { background-color: #2563eb; color: white; padding: 0.5rem 1rem; border: none; border-radius: 6px; cursor: pointer; font-weight: 500; font-size: 0.9rem; }
        .btn:hover { background-color: #1d4ed8; }
        table { width: 100%; border-collapse: collapse; margin-top: 1rem; text-align: left; }
        th, td { padding: 0.75rem; border-bottom: 1px solid #e5e7eb; }
        th { background-color: #f9fafb; color: #4b5563; font-weight: 600; }
        .status-badge { padding: 0.25rem 0.5rem; border-radius: 9999px; font-size: 0.7rem; font-weight: 600; text-transform: uppercase; }
        .status-success { background-color: #dcfce7; color: #166534; }
        .status-failed { background-color: #fee2e2; color: #991b1b; }
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
        
        <div class="card">
            <h3>Transaction History</h3>
            
            <form action="${pageContext.request.contextPath}/transactions" method="get" class="filter-form">
                <div class="filter-group">
                    <label for="accountNumber">Account</label>
                    <select id="accountNumber" name="accountNumber">
                        <c:forEach var="acc" items="${accounts}">
                            <option value="${acc.accountNumber}" <c:if test="${acc.accountNumber == selectedAccount}">selected</c:if>>
                                ${acc.accountType} (${acc.accountNumber})
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="transactionType">Transaction Type</label>
                    <select id="transactionType" name="transactionType">
                        <option value="ALL" <c:if test="${selectedType == 'ALL'}">selected</c:if>>All Types</option>
                        <option value="DEPOSIT" <c:if test="${selectedType == 'DEPOSIT'}">selected</c:if>>Deposits</option>
                        <option value="WITHDRAWAL" <c:if test="${selectedType == 'WITHDRAWAL'}">selected</c:if>>Withdrawals</option>
                        <option value="TRANSFER" <c:if test="${selectedType == 'TRANSFER'}">selected</c:if>>Transfers</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="fromDate">From Date</label>
                    <input type="date" id="fromDate" name="fromDate" value="${fromDate}">
                </div>
                
                <div class="filter-group">
                    <label for="toDate">To Date</label>
                    <input type="date" id="toDate" name="toDate" value="${toDate}">
                </div>
                
                <button type="submit" class="btn">Filter</button>
            </form>

            <c:choose>
                <c:when test="${empty transactions}">
                    <p style="color: #6b7280; text-align: center; margin: 2rem 0;">No transactions found matching the filter criteria.</p>
                </c:when>
                <c:otherwise>
                    <table>
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
                                    <td>#${txn.transactionId}</td>
                                    <td>
                                        <fmt:formatDate value="${txn.transactionDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td><span style="font-weight: 600;">${txn.transactionType}</span></td>
                                    <td style="font-weight: 600; 
                                        <c:choose>
                                            <c:when test="${txn.transactionType == 'DEPOSIT'}">color: #166534;</c:when>
                                            <c:otherwise>color: #991b1b;</c:otherwise>
                                        </c:choose>">
                                        $<fmt:formatNumber value="${txn.amount}" pattern="#,##0.00"/>
                                    </td>
                                    <td style="font-family: monospace;">${not empty txn.senderAccount ? txn.senderAccount : '-'}</td>
                                    <td style="font-family: monospace;">${not empty txn.receiverAccount ? txn.receiverAccount : '-'}</td>
                                    <td>
                                        <span class="status-badge 
                                            <c:choose>
                                                <c:when test="${txn.status == 'SUCCESS'}">status-success</c:when>
                                                <c:otherwise>status-failed</c:otherwise>
                                            </c:choose>">
                                            ${txn.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

</body>
</html>
