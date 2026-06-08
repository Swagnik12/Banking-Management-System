<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Deposit Funds - Banking Management System</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f3f4f6; margin: 0; color: #1f2937; }
        .navbar { background-color: #1e3a8a; color: white; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { margin: 0; font-size: 1.5rem; }
        .nav-links a { color: white; text-decoration: none; margin-left: 1.5rem; font-weight: 500; }
        .nav-links a:hover { text-decoration: underline; }
        .container { max-width: 600px; margin: 3rem auto; padding: 0 1rem; }
        .card { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); }
        .card h3 { margin-top: 0; border-bottom: 2px solid #f3f4f6; padding-bottom: 0.5rem; color: #1e3a8a; }
        .form-group { margin-bottom: 1.25rem; }
        label { display: block; color: #4b5563; margin-bottom: 0.5rem; font-size: 0.9rem; font-weight: 500; }
        select, input[type="number"] { width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 6px; box-sizing: border-box; font-size: 1rem; }
        select:focus, input[type="number"]:focus { outline: none; border-color: #3b82f6; }
        .btn { background-color: #2563eb; color: white; padding: 0.75rem 1.5rem; border: none; border-radius: 6px; font-size: 1rem; font-weight: 600; cursor: pointer; transition: background-color 0.2s; width: 100%; }
        .btn:hover { background-color: #1d4ed8; }
        .alert { padding: 0.75rem; border-radius: 6px; margin-bottom: 1.25rem; font-size: 0.9rem; }
        .alert-error { background-color: #fee2e2; color: #991b1b; border: 1px solid #fca5a5; }
        .alert-success { background-color: #dcfce7; color: #166534; border: 1px solid #86efac; }
        .back-link { display: block; text-align: center; margin-top: 1.5rem; color: #4b5563; text-decoration: none; font-size: 0.9rem; }
        .back-link:hover { text-decoration: underline; }
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
            <h3>Deposit Funds</h3>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/deposit" method="post">
                <div class="form-group">
                    <label for="accountNumber">Select Target Account</label>
                    <select id="accountNumber" name="accountNumber" required>
                        <option value="">-- Choose Account --</option>
                        <c:forEach var="acc" items="${accounts}">
                            <c:if test="${acc.status == 'ACTIVE'}">
                                <option value="${acc.accountNumber}">
                                    ${acc.accountType} (${acc.accountNumber}) - Bal: $<fmt:formatNumber value="${acc.balance}" pattern="#,##0.00"/>
                                </option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="amount">Deposit Amount ($)</label>
                    <input type="number" id="amount" name="amount" step="0.01" min="0.01" required placeholder="0.00">
                </div>
                
                <button type="submit" class="btn">Process Deposit</button>
            </form>
            
            <a href="${pageContext.request.contextPath}/dashboard" class="back-link">&larr; Back to Dashboard</a>
        </div>
    </div>

</body>
</html>
