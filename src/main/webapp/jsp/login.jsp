<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Back - FinTrust Global</title>
    
    <!-- Design System Resource Imports -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">
    
    <style>
        body {
            display: flex;
            min-height: 100vh;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            background: radial-gradient(circle at 10% 20%, rgba(37, 99, 235, 0.05) 0%, transparent 90%),
                        radial-gradient(circle at 90% 80%, rgba(79, 70, 229, 0.05) 0%, transparent 90%),
                        var(--bg-main);
            position: relative;
            overflow-x: hidden;
        }

        .auth-container {
            width: 100%;
            max-width: 440px;
            z-index: 10;
        }

        .auth-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            letter-spacing: -0.03em;
            margin-bottom: 2.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .auth-brand svg {
            width: 32px;
            height: 32px;
            stroke: var(--primary-color);
        }

        .auth-card {
            border: 1px solid var(--border-color);
            background-color: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            padding: 2.5rem;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
        }

        [data-theme="dark"] .auth-card {
            background-color: rgba(21, 27, 44, 0.8);
        }

        .lock-badge {
            width: 56px;
            height: 56px;
            background-color: rgba(37, 99, 235, 0.08);
            color: var(--primary-color);
            border-radius: var(--radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem auto;
        }

        .lock-badge svg {
            width: 24px;
            height: 24px;
            fill: none;
            stroke: currentColor;
            stroke-width: 2;
        }

        .auth-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .auth-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--text-primary);
            letter-spacing: -0.02em;
        }

        .auth-subtitle {
            font-size: 0.9rem;
            color: var(--text-secondary);
            margin-top: 0.5rem;
        }

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            font-size: 0.85rem;
        }

        .forgot-link {
            color: var(--primary-color);
            font-weight: 600;
        }

        .forgot-link:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }

        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            color: var(--text-muted);
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin: 1.5rem 0;
        }

        .divider::before, .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid var(--border-color);
        }

        .divider:not(:empty)::before {
            margin-right: .75em;
        }

        .divider:not(:empty)::after {
            margin-left: .75em;
        }

        .social-buttons {
            display: flex;
            gap: 1rem;
        }

        .theme-toggle-container {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
        }
    </style>
</head>
<body class="page-transition">

    <!-- Theme Control -->
    <div class="theme-toggle-container">
        <button class="nav-icon-btn theme-toggle-btn" aria-label="Toggle Theme">
            <svg class="moon-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path></svg>
            <svg class="sun-icon" style="display:none;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707m2.828 0l-.707-.707m12.728-12.728l-.707-.707M12 8a4 4 0 100 8 4 4 0 000-8z"></path></svg>
        </button>
    </div>

    <div class="auth-container">
        <div class="auth-brand">
            <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path></svg>
            FinTrust Global
        </div>

        <div class="auth-card">
            <div class="lock-badge">
                <svg viewBox="0 0 24 24">
                    <path d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                </svg>
            </div>

            <div class="auth-header">
                <h2 class="auth-title">Welcome Back</h2>
                <p class="auth-subtitle">Secure access to your premier banking portal</p>
            </div>

            <!-- Error and Success Notifications (Fully preserved) -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:20px;height:20px;flex-shrink:0;"><path stroke-linecap="round" stroke-linejoin="round" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <span>${error}</span>
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:20px;height:20px;flex-shrink:0;"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <span>${success}</span>
                </div>
            </c:if>

            <!-- Login Form (Fully preserved servlet interaction endpoints) -->
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrapper">
                        <span class="input-icon">
                            <svg viewBox="0 0 24 24"><path d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/></svg>
                        </span>
                        <input type="email" id="email" name="email" required placeholder="name@company.com" class="input-field">
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <span class="input-icon">
                            <svg viewBox="0 0 24 24"><path d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/></svg>
                        </span>
                        <input type="password" id="password" name="password" required placeholder="••••••••" class="input-field">
                        <button type="button" class="password-toggle" aria-label="Toggle Password Visibility">
                            <svg class="eye-icon" viewBox="0 0 24 24"><path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>
                            <svg class="eye-off-icon" style="display:none;" viewBox="0 0 24 24"><path d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l18 18"/></svg>
                        </button>
                    </div>
                </div>

                <div class="form-options">
                    <label class="checkbox-group">
                        <input type="checkbox" name="rememberMe" id="rememberMe">
                        <span>Remember Me</span>
                    </label>
                    <a href="#" class="forgot-link">Forgot Password?</a>
                </div>

                <button type="submit" class="btn btn-primary">
                    <span>Sign In</span>
                    <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="width:18px;height:18px;"><path stroke-linecap="round" stroke-linejoin="round" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                </button>
            </form>

            <div class="divider">Or Continue With</div>

            <div class="social-buttons">
                <button type="button" class="btn btn-social">
                    <img src="https://www.gstatic.com/images/branding/product/1x/gsa_512dp.png" alt="Google">
                    <span>Google</span>
                </button>
                <button type="button" class="btn btn-social">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:18px;height:18px;color:var(--text-secondary);"><path stroke-linecap="round" stroke-linejoin="round" d="M12 11c0 3.517-1.009 6.799-2.753 9.571m-3.44-2.04l.054-.09A13.916 13.916 0 009 11a13.916 13.916 0 00-1.5-3.63L6.5 6.5m1.5-1.5L7.5 4m-4 10a11.975 11.975 0 001.077 4.908M15 15c0 1.63-.339 3.18-.95 4.591M15 15a12.022 12.022 0 001.025-4.591M15 15h.008M15 11a12.022 12.022 0 01-1.025-4.59M15 11h.008M15 11v3.007m0-3.007a12.06 12.06 0 00.95-4.593M15 14v.008M15 14a12.06 12.06 0 00.95 4.591M15 14h.008M19 11a11.975 11.975 0 00-1.077-4.908M19 11v3m0-3h.008m0 3h-.008m0 0a11.975 11.975 0 01-1.077 4.908M19 14h.008m0 0v1a11.975 11.975 0 01-1.077 4.908M19 14a11.975 11.975 0 001.077-4.908M19 14h.008M10 18.007h.008M8 14h.008M8 11h.008M6 14h.008M6 11h.008M6 8h.008M11.5 5.5h.008M11.5 8.5h.008M11.5 11.5h.008"></path></svg>
                    <span>Biometrics</span>
                </button>
            </div>

            <div class="footer-text mt-4">
                Don't have an account? <a href="${pageContext.request.contextPath}/register">Register account</a>
            </div>
        </div>
    </div>

    <!-- Layout scripts integration -->
    <script src="${pageContext.request.contextPath}/js/theme.js"></script>

    <!-- Session flash cleanup handled in LoginServlet doGet -->
</body>
</html>
