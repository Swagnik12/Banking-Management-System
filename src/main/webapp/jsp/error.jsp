<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Banking Management System</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f3f4f6; margin: 0; display: flex; align-items: center; justify-content: center; height: 100vh; color: #1f2937; }
        .card { background-color: #ffffff; padding: 2.5rem; border-radius: 12px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08); width: 100%; max-width: 500px; text-align: center; }
        .error-icon { font-size: 4rem; color: #ef4444; margin-bottom: 1rem; }
        h2 { color: #1f2937; margin-top: 0; font-size: 1.8rem; }
        p { color: #4b5563; font-size: 1.05rem; line-height: 1.5; margin-bottom: 1.5rem; }
        .details { background-color: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 1rem; font-family: monospace; font-size: 0.9rem; text-align: left; overflow-x: auto; color: #ef4444; max-height: 150px; margin-bottom: 1.5rem; }
        .btn { background-color: #14B8A6; color: white; padding: 0.75rem 1.5rem; border: none; border-radius: 6px; font-size: 1rem; font-weight: 600; cursor: pointer; text-decoration: none; display: inline-block; transition: background-color 0.2s; }
        .btn:hover { background-color: #0EA5A0; }
    </style>
</head>
<body>
    <div class="card">
        <div class="error-icon">&#9888;</div>
        <h2>An Error Occurred</h2>
        
        <p>We ran into a problem processing your request. Please check the details below or head back to the dashboard.</p>
        
        <div class="details">
            Status Code: ${pageContext.errorData.statusCode}<br>
            Request URI: ${pageContext.errorData.requestURI}<br>
            <c:if test="${not empty error}">
                Message: ${error}<br>
            </c:if>
            <c:if test="${not empty pageContext.exception}">
                Exception: ${pageContext.exception.message}
            </c:if>
        </div>
        
        <c:choose>
            <c:when test="${sessionScope.user.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn">Return to Dashboard</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn">Return to Dashboard</a>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
