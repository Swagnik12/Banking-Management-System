<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Profile - Banking Management System</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f3f4f6; margin: 0; color: #1f2937; }
        .navbar { background-color: #1e3a8a; color: white; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { margin: 0; font-size: 1.5rem; }
        .nav-links a { color: white; text-decoration: none; margin-left: 1.5rem; font-weight: 500; }
        .nav-links a:hover { text-decoration: underline; }
        .container { max-width: 800px; margin: 2rem auto; padding: 0 1rem; }
        .card { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); margin-bottom: 2rem; }
        .card h3 { margin-top: 0; border-bottom: 2px solid #f3f4f6; padding-bottom: 0.5rem; color: #1e3a8a; }
        .form-group { margin-bottom: 1.25rem; }
        label { display: block; color: #4b5563; margin-bottom: 0.5rem; font-size: 0.9rem; font-weight: 500; }
        input[type="text"], input[type="email"], input[type="password"] { width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 6px; box-sizing: border-box; font-size: 1rem; }
        input[type="text"]:focus, input[type="password"]:focus { outline: none; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15); }
        .btn { background-color: #2563eb; color: white; padding: 0.75rem 1.5rem; border: none; border-radius: 6px; font-size: 1rem; font-weight: 600; cursor: pointer; transition: background-color 0.2s; }
        .btn:hover { background-color: #1d4ed8; }
        .alert { padding: 0.75rem; border-radius: 6px; margin-bottom: 1.25rem; font-size: 0.9rem; }
        .alert-error { background-color: #fee2e2; color: #991b1b; border: 1px solid #fca5a5; }
        .alert-success { background-color: #dcfce7; color: #166534; border: 1px solid #86efac; }
        .disabled-input { background-color: #f3f4f6; cursor: not-allowed; }
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

        <!-- Profile Update Card -->
        <div class="card">
            <h3>Update Profile Details</h3>
            <form action="${pageContext.request.contextPath}/profile" method="post">
                <input type="hidden" name="action" value="updateProfile">
                
                <div class="form-group">
                    <label for="email">Email Address (Cannot be changed)</label>
                    <input type="email" id="email" class="disabled-input" value="${profileUser.email}" disabled>
                </div>
                
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" required value="${profileUser.fullName}">
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" name="phone" required value="${profileUser.phone}">
                </div>
                
                <div class="form-group">
                    <label for="address">Residential Address</label>
                    <input type="text" id="address" name="address" required value="${profileUser.address}">
                </div>
                
                <button type="submit" class="btn">Save Changes</button>
            </form>
        </div>

        <!-- Password Change Card -->
        <div class="card">
            <h3>Change Password</h3>
            <form action="${pageContext.request.contextPath}/profile" method="post">
                <input type="hidden" name="action" value="changePassword">
                
                <div class="form-group">
                    <label for="oldPassword">Current Password</label>
                    <input type="password" id="oldPassword" name="oldPassword" required placeholder="Enter current password">
                </div>
                
                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required placeholder="Min 6 characters">
                </div>
                
                <div class="form-group">
                    <label for="confirmNewPassword">Confirm New Password</label>
                    <input type="password" id="confirmNewPassword" name="confirmNewPassword" required placeholder="Re-enter new password">
                </div>
                
                <button type="submit" class="btn">Update Password</button>
            </form>
        </div>
    </div>

</body>
</html>
