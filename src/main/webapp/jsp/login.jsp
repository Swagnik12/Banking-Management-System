<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bank Login - Banking Management System</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f3f4f6; margin: 0; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .card { background-color: #ffffff; padding: 2.5rem; border-radius: 12px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08); width: 100%; max-width: 400px; }
        h2 { color: #1f2937; margin-top: 0; font-size: 1.8rem; text-align: center; }
        .form-group { margin-bottom: 1.25rem; }
        label { display: block; color: #4b5563; margin-bottom: 0.5rem; font-size: 0.9rem; font-weight: 500; }
        input[type="email"], input[type="password"] { width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 6px; box-sizing: border-box; font-size: 1rem; }
        input[type="email"]:focus, input[type="password"]:focus { outline: none; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15); }
        .btn { background-color: #2563eb; color: white; padding: 0.75rem; border: none; border-radius: 6px; width: 100%; font-size: 1rem; font-weight: 600; cursor: pointer; transition: background-color 0.2s; }
        .btn:hover { background-color: #1d4ed8; }
        .alert { padding: 0.75rem; border-radius: 6px; margin-bottom: 1.25rem; font-size: 0.9rem; }
        .alert-error { background-color: #fee2e2; color: #991b1b; border: 1px solid #fca5a5; }
        .alert-success { background-color: #dcfce7; color: #166534; border: 1px solid #86efac; }
        .footer-text { text-align: center; margin-top: 1.5rem; font-size: 0.9rem; color: #6b7280; }
        .footer-text a { color: #2563eb; text-decoration: none; font-weight: 500; }
        .footer-text a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="card">
        <h2>Apex Trust Bank</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <!-- Flush session attributes -->
        <% session.removeAttribute("success"); session.removeAttribute("error"); %>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required placeholder="name@example.com">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="••••••••">
            </div>
            <button type="submit" class="btn">Login</button>
        </form>
        
        <div class="footer-text">
            Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
        </div>
    </div>
</body>
</html>
