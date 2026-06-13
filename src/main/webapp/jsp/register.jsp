<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - FinTrust Global</title>
    
    <!-- Design System Resource Imports -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">
    
    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--bg-main);
            padding: 2rem 1rem;
            position: relative;
        }

        .split-container {
            display: grid;
            grid-template-columns: 1fr 1.1fr;
            max-width: 1050px;
            width: 100%;
            background-color: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            transition: background-color var(--transition-normal), border-color var(--transition-normal);
        }

        /* Branding/Marketing Left Column */
        .promo-column {
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            padding: 3.5rem;
            color: #ffffff;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }

        .promo-column::before {
            content: '';
            position: absolute;
            top: -20%;
            left: -20%;
            width: 80%;
            height: 80%;
            background: radial-gradient(circle, rgba(37, 99, 235, 0.15) 0%, transparent 70%);
            pointer-events: none;
        }

        .brand-header {
            font-size: 1.35rem;
            font-weight: 700;
            letter-spacing: -0.02em;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .brand-header svg {
            width: 28px;
            height: 28px;
            stroke: var(--primary-color);
        }

        .promo-content {
            margin: 3rem 0;
        }

        .promo-title {
            font-size: 2.2rem;
            font-weight: 700;
            line-height: 1.25;
            letter-spacing: -0.03em;
            margin-bottom: 1.5rem;
        }

        .promo-desc {
            font-size: 0.95rem;
            color: var(--sidebar-text);
            line-height: 1.6;
            margin-bottom: 2.5rem;
        }

        .feature-cards {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.25rem;
        }

        .feature-card {
            background-color: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.06);
            padding: 1.25rem;
            border-radius: var(--radius-md);
            display: flex;
            gap: 1rem;
        }

        .feature-icon-wrapper {
            background-color: rgba(37, 99, 235, 0.1);
            color: var(--primary-color);
            width: 40px;
            height: 40px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .feature-icon-wrapper svg {
            width: 20px;
            height: 20px;
            fill: none;
            stroke: currentColor;
            stroke-width: 2;
        }

        .feature-title {
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }

        .feature-desc {
            font-size: 0.8rem;
            color: var(--sidebar-text);
            line-height: 1.4;
        }

        .promo-footer {
            font-size: 0.8rem;
            color: var(--sidebar-text);
        }

        /* Form Registration Right Column */
        .form-column {
            padding: 3.5rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header {
            margin-bottom: 2rem;
        }

        .form-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-primary);
            letter-spacing: -0.02em;
        }

        .form-subtitle {
            font-size: 0.9rem;
            color: var(--text-secondary);
            margin-top: 0.25rem;
        }

        .theme-toggle-container {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
        }

        @media (max-width: 900px) {
            .split-container {
                grid-template-columns: 1fr;
            }
            .promo-column {
                display: none; /* Hide marketing panel on tablet/mobile screens */
            }
            .form-column {
                padding: 2.5rem 1.5rem;
            }
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

    <div class="split-container">
        <!-- Promo left banner -->
        <div class="promo-column">
            <div class="brand-header">
                <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path></svg>
                FinTrust Global
            </div>
            
            <div class="promo-content">
                <h1 class="promo-title">Secure your financial future with absolute precision.</h1>
                <p class="promo-desc">Join thousands of premium clients who trust our mathematical approach to global asset management and high-frequency banking.</p>
                
                <div class="feature-cards">
                    <div class="feature-card">
                        <div class="feature-icon-wrapper">
                            <svg viewBox="0 0 24 24"><path d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/></svg>
                        </div>
                        <div>
                            <div class="feature-title">Bank-Grade Security</div>
                            <div class="feature-desc">AES-256 encryption for all transaction data and session packets.</div>
                        </div>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon-wrapper">
                            <svg viewBox="0 0 24 24"><path d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 002 2h2a2.5 2.5 0 002.5-2.5V9a2 2 0 00-2-2h-1.07a2 2 0 01-1.414-.586l-1.07-1.07A2 2 0 009.686 5H8.5a2 2 0 01-2-2v-.065"/></svg>
                        </div>
                        <div>
                            <div class="feature-title">Global Reach</div>
                            <div class="feature-desc">Access your accounts securely across 120+ countries worldwide.</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="promo-footer">
                &copy; 2026 FinTrust Global Banking Group. SEC Regulated.
            </div>
        </div>

        <!-- Registration Right Column -->
        <div class="form-column">
            <div class="form-header">
                <h2 class="form-title">Create your account</h2>
                <p class="form-subtitle">Fill in your details to start your banking journey.</p>
            </div>

            <!-- Error Alerts (Fully preserved JSTL bindings) -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:20px;height:20px;flex-shrink:0;"><path stroke-linecap="round" stroke-linejoin="round" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Registration Form (Fully preserved input names and actions) -->
            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <div class="input-wrapper">
                        <span class="input-icon">
                            <svg viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2M12 11a4 4 0 100-8 4 4 0 000 8z"/></svg>
                        </span>
                        <input type="text" id="fullName" name="fullName" required value="${fullName}" placeholder="Alex Thompson" class="input-field">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <div class="input-wrapper">
                            <span class="input-icon">
                                <svg viewBox="0 0 24 24"><path d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/></svg>
                            </span>
                            <input type="email" id="email" name="email" required value="${email}" placeholder="alex@fintrust.com" class="input-field">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <div class="input-wrapper">
                            <span class="input-icon">
                                <svg viewBox="0 0 24 24"><path d="M3 5a2 2 0 012-2h3.28a1 1 0 01.94.725l.548 2.2a1 1 0 01-.321.988l-1.305.98a10.582 10.582 0 004.872 4.872l.98-1.305a1 1 0 01.988-.321l2.2.548a1 1 0 01.725.94V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/></svg>
                            </span>
                            <input type="text" id="phone" name="phone" required value="${phone}" placeholder="+1 (555) 000-0000" class="input-field">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="address">Residential Address</label>
                    <div class="input-wrapper">
                        <span class="input-icon">
                            <svg viewBox="0 0 24 24"><path d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/><path d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                        </span>
                        <input type="text" id="address" name="address" required value="${address}" placeholder="123 Financial District, NY" class="input-field">
                    </div>
                </div>

                <div class="form-row">
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
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <div class="input-wrapper">
                            <span class="input-icon">
                                <svg viewBox="0 0 24 24"><path d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/></svg>
                            </span>
                            <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="••••••••" class="input-field">
                        </div>
                    </div>
                </div>

                <div class="form-options">
                    <label class="checkbox-group">
                        <input type="checkbox" name="terms" id="terms" required>
                        <span>I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>.</span>
                    </label>
                </div>

                <button type="submit" class="btn btn-primary">Create Account</button>
            </form>

            <div class="footer-text mt-4">
                Already have an account? <a href="${pageContext.request.contextPath}/login">Log in here</a>
            </div>
        </div>
    </div>

    <!-- Layout scripts integration -->
    <script src="${pageContext.request.contextPath}/js/theme.js"></script>
</body>
</html>
