<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTrust Global — Banking Made Simple, Secure & Smart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">
    <style>
        .btn-primary,
        .btn-primary:hover,
        .btn-primary:focus,
        .btn-primary:active {
            color: #ffffff !important;
        }
        .btn-primary:hover {
            background: #0ea5a0;
            box-shadow: 0 4px 12px rgba(20, 184, 166, 0.4);
        }
        /* ── Navbar ── */
        .navbar {
            position: fixed;
            top: 0; left: 0; right: 0;
            z-index: 100;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem 4rem;
            background: rgba(255,255,255,0.75);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            border-bottom: 1px solid var(--border-color);
            transition: background var(--transition-normal);
        }
        [data-theme="dark"] .navbar {
            background: rgba(11,15,25,0.85);
        }
        .nav-logo {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--text-primary);
        }
        .nav-logo svg {
            width: 28px;
            height: 28px;
            stroke: var(--primary-color);
        }
        .nav-links {
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }
        .nav-links a {
            padding: 0.5rem 1.2rem;
            border-radius: var(--radius-md);
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-secondary);
            transition: all var(--transition-fast);
        }
        .nav-links a:hover {
            color: var(--primary-color);
        }
        .nav-links .btn-primary {
            padding: 0.5rem 1.5rem;
            width: auto;
        }

        /* ── Hero ── */
        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 6rem 2rem 4rem;
            position: relative;
            overflow: hidden;
            background:
                radial-gradient(ellipse 60% 50% at 20% 30%, rgba(20,184,166,0.08) 0%, transparent 70%),
                radial-gradient(ellipse 50% 40% at 80% 70%, rgba(20,184,166,0.06) 0%, transparent 70%),
                var(--bg-main);
        }
        .hero-content {
            max-width: 800px;
            z-index: 2;
        }
        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            background: rgba(20,184,166,0.1);
            color: var(--primary-color);
            padding: 0.4rem 1rem;
            border-radius: var(--radius-full);
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }
        .hero h1 {
            font-size: 3.8rem;
            font-weight: 800;
            letter-spacing: -0.04em;
            line-height: 1.1;
            color: var(--text-primary);
            margin-bottom: 1.2rem;
        }
        .hero h1 span {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .hero p {
            font-size: 1.15rem;
            color: var(--text-secondary);
            line-height: 1.7;
            max-width: 600px;
            margin: 0 auto 2.5rem;
        }
        .hero-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        .hero-buttons .btn {
            width: auto;
            min-width: 180px;
            padding: 0.9rem 2rem;
            font-size: 1rem;
        }
        .hero-buttons .btn-secondary {
            border-color: var(--border-color);
        }

        /* ── Section shared ── */
        section {
            padding: 5rem 2rem;
        }
        .section-title {
            text-align: center;
            font-size: 2.2rem;
            font-weight: 700;
            letter-spacing: -0.03em;
            color: var(--text-primary);
            margin-bottom: 0.75rem;
        }
        .section-subtitle {
            text-align: center;
            font-size: 1rem;
            color: var(--text-secondary);
            max-width: 560px;
            margin: 0 auto 3.5rem;
            line-height: 1.6;
        }
        .container {
            max-width: 1100px;
            margin: 0 auto;
        }

        /* ── Stats ── */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
        }
        .stat-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 2rem 1.5rem;
            text-align: center;
            transition: transform var(--transition-normal), box-shadow var(--transition-normal);
        }
        .stat-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-lg);
        }
        .stat-icon {
            width: 48px;
            height: 48px;
            margin: 0 auto 1rem;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            background: rgba(20,184,166,0.1);
        }
        .stat-icon svg {
            width: 22px;
            height: 22px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }
        .stat-number {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-primary);
            letter-spacing: -0.03em;
        }
        .stat-label {
            font-size: 0.85rem;
            color: var(--text-muted);
            font-weight: 500;
            margin-top: 0.3rem;
        }

        /* ── Features ── */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
        }
        .feature-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 2rem 1.5rem;
            text-align: center;
            transition: transform var(--transition-normal), box-shadow var(--transition-normal);
        }
        .feature-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-lg);
        }
        .feature-card h3 {
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--text-primary);
            margin: 1rem 0 0.5rem;
        }
        .feature-card p {
            font-size: 0.85rem;
            color: var(--text-secondary);
            line-height: 1.5;
        }

        /* ── Why Choose ── */
        .why-section {
            background:
                radial-gradient(ellipse 50% 60% at 50% 40%, rgba(20,184,166,0.06) 0%, transparent 70%),
                var(--bg-main);
        }
        .why-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
        }
        .why-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 2.5rem 2rem;
            transition: transform var(--transition-normal), box-shadow var(--transition-normal);
        }
        .why-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
        }
        .why-card .icon-circle {
            width: 52px;
            height: 52px;
            border-radius: var(--radius-full);
            background: linear-gradient(135deg, rgba(20,184,166,0.12), rgba(20,184,166,0.06));
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.25rem;
        }
        .why-card .icon-circle svg {
            width: 24px;
            height: 24px;
            stroke: var(--primary-color);
            fill: none;
            stroke-width: 2;
        }
        .why-card h3 {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }
        .why-card p {
            font-size: 0.9rem;
            color: var(--text-secondary);
            line-height: 1.6;
        }

        /* ── CTA ── */
        .cta-section {
            text-align: center;
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            color: #fff;
            padding: 5rem 2rem;
        }
        .cta-section h2 {
            font-size: 2.4rem;
            font-weight: 700;
            letter-spacing: -0.03em;
            margin-bottom: 1rem;
        }
        .cta-section p {
            font-size: 1.05rem;
            color: #94a3b8;
            margin-bottom: 2rem;
        }
        .cta-section .btn {
            width: auto;
            min-width: 200px;
            padding: 0.9rem 2rem;
            font-size: 1rem;
        }
        .cta-section .btn-primary {
            background: var(--primary-color);
        }
        .cta-section .btn-primary:hover {
            background: #0ea5a0;
        }

        /* ── Footer ── */
        footer {
            background: var(--bg-sidebar);
            color: var(--sidebar-text);
            padding: 3rem 2rem 1.5rem;
        }
        footer .container {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 2.5rem;
        }
        footer h4 {
            font-size: 0.9rem;
            font-weight: 700;
            color: var(--sidebar-text-active);
            margin-bottom: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        footer p, footer a {
            font-size: 0.85rem;
            line-height: 1.6;
            color: var(--sidebar-text);
        }
        footer a:hover {
            color: var(--sidebar-text-active);
        }
        footer .brand-footer {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--sidebar-text-active);
            margin-bottom: 1rem;
        }
        footer .brand-footer svg {
            width: 24px;
            height: 24px;
            stroke: var(--primary-color);
        }
        .footer-bottom {
            grid-column: 1 / -1;
            border-top: 1px solid rgba(255,255,255,0.06);
            padding-top: 1.5rem;
            margin-top: 1rem;
            text-align: center;
            font-size: 0.8rem;
            color: var(--text-muted);
        }
        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        /* ── Scroll Animation ── */
        .reveal {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.6s cubic-bezier(0.16,1,0.3,1), transform 0.6s cubic-bezier(0.16,1,0.3,1);
        }
        .reveal.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* ── Responsive ── */
        @media (max-width: 900px) {
            .navbar { padding: 1rem 1.5rem; }
            .nav-links a { padding: 0.5rem 0.8rem; font-size: 0.85rem; }
            .hero h1 { font-size: 2.4rem; }
            .stats-grid,
            .features-grid { grid-template-columns: repeat(2, 1fr); }
            .why-grid { grid-template-columns: 1fr; }
            footer .container { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 540px) {
            .nav-links .btn-primary { display: none; }
            .stats-grid,
            .features-grid { grid-template-columns: 1fr; }
            footer .container { grid-template-columns: 1fr; }
            .hero h1 { font-size: 1.9rem; }
        }
    </style>
</head>
<body class="page-transition">

    <!-- ═══ Navbar ═══ -->
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/" class="nav-logo">
            <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path></svg>
            FinTrust
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">Sign In</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <!-- ═══ Hero ═══ -->
    <section class="hero">
        <div class="hero-content">
            <div class="hero-badge">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="width:14px;height:14px;"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                SEC-Regulated Digital Banking
            </div>
            <h1>Banking Made<br><span>Simple, Secure &amp; Smart</span></h1>
            <p>Experience next-generation banking with AI-driven insights, real-time transactions, and military-grade security — all at your fingertips.</p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Open Account</a>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">Sign In</a>
            </div>
        </div>
    </section>

    <!-- ═══ Stats ═══ -->
    <section class="container">
        <div class="stats-grid reveal">
            <div class="stat-card">
                <div class="stat-icon">
                    <svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87m-4-12a4 4 0 010 7.75"/></svg>
                </div>
                <div class="stat-number" data-target="50000">0</div>
                <div class="stat-label">Customers Served</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <svg viewBox="0 0 24 24"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/></svg>
                </div>
                <div class="stat-number" data-target="1200000">0</div>
                <div class="stat-label">Transactions Secured</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <svg viewBox="0 0 24 24"><path d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/></svg>
                </div>
                <div class="stat-number" data-target="100">0</div>
                <div class="stat-label">% Uptime &amp; Security</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <svg viewBox="0 0 24 24"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>
                </div>
                <div class="stat-number" data-target="24">0</div>
                <div class="stat-label">/7 Premium Support</div>
            </div>
        </div>
    </section>

    <!-- ═══ Features ═══ -->
    <section class="container">
        <h2 class="section-title reveal">Everything You Need</h2>
        <p class="section-subtitle reveal">From secure storage to instant transfers, our platform is built for the modern banking experience.</p>
        <div class="features-grid reveal">
            <div class="feature-card card-lift" style="padding:2rem 1.5rem;">
                <div class="stat-icon" style="margin:0 auto;">
                    <svg viewBox="0 0 24 24"><path d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/></svg>
                </div>
                <h3>Secure Banking</h3>
                <p>Bank-grade AES-256 encryption protects every transaction and account detail.</p>
            </div>
            <div class="feature-card card-lift" style="padding:2rem 1.5rem;">
                <div class="stat-icon" style="margin:0 auto;">
                    <svg viewBox="0 0 24 24"><path d="M13 10V3L4 14h7v7l9-11h-7z"/></svg>
                </div>
                <h3>Instant Transfers</h3>
                <p>Real-time fund transfers between accounts with immediate settlement.</p>
            </div>
            <div class="feature-card card-lift" style="padding:2rem 1.5rem;">
                <div class="stat-icon" style="margin:0 auto;">
                    <svg viewBox="0 0 24 24"><path d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/></svg>
                </div>
                <h3>Smart Dashboard</h3>
                <p>Real-time analytics and spending insights powered by intelligent dashboards.</p>
            </div>
            <div class="feature-card card-lift" style="padding:2rem 1.5rem;">
                <div class="stat-icon" style="margin:0 auto;">
                    <svg viewBox="0 0 24 24"><path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
                </div>
                <h3>Account Management</h3>
                <p>Full control over accounts, beneficiaries, and transaction history in one place.</p>
            </div>
        </div>
    </section>

    <!-- ═══ Why Choose FinTrust ═══ -->
    <section class="why-section">
        <div class="container">
            <h2 class="section-title reveal">Why Choose FinTrust</h2>
            <p class="section-subtitle reveal">We combine cutting-edge technology with decades of financial expertise to deliver a banking experience you can trust.</p>
            <div class="why-grid">
                <div class="why-card reveal">
                    <div class="icon-circle">
                        <svg viewBox="0 0 24 24"><path d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/></svg>
                    </div>
                    <h3>Military-Grade Security</h3>
                    <p>Your data is protected with AES-256 encryption, multi-factor authentication, and continuous threat monitoring across all platforms.</p>
                </div>
                <div class="why-card reveal">
                    <div class="icon-circle">
                        <svg viewBox="0 0 24 24"><path d="M13 10V3L4 14h7v7l9-11h-7z"/></svg>
                    </div>
                    <h3>Lightning-Fast Transfers</h3>
                    <p>Transfer funds between accounts instantly with zero downtime. Our infrastructure processes millions of transactions daily.</p>
                </div>
                <div class="why-card reveal">
                    <div class="icon-circle">
                        <svg viewBox="0 0 24 24"><path d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z"/></svg>
                    </div>
                    <h3>24/7 Dedicated Support</h3>
                    <p>Our expert support team is available around the clock to assist with any banking needs, technical issues, or account inquiries.</p>
                </div>
                <div class="why-card reveal">
                    <div class="icon-circle">
                        <svg viewBox="0 0 24 24"><path d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                    </div>
                    <h3>Zero Hidden Fees</h3>
                    <p>Transparent pricing with no hidden charges. What you see is what you get — straightforward banking without surprises.</p>
                </div>
                <div class="why-card reveal">
                    <div class="icon-circle">
                        <svg viewBox="0 0 24 24"><path d="M9 17V7m0 10a2 2 0 01-2 2H5a2 2 0 01-2-2V7a2 2 0 012-2h2a2 2 0 012 2m0 10a2 2 0 002 2h2a2 2 0 002-2M9 7a2 2 0 012-2h2a2 2 0 012 2m0 10V7m0 10a2 2 0 002 2h2a2 2 0 002-2V7a2 2 0 00-2-2h-2a2 2 0 00-2 2"/></svg>
                    </div>
                    <h3>Regulatory Compliance</h3>
                    <p>Fully compliant with SEC regulations and international banking standards. Your accounts are protected by industry-leading protocols.</p>
                </div>
                <div class="why-card reveal">
                    <div class="icon-circle">
                        <svg viewBox="0 0 24 24"><path d="M3 15a4 4 0 004 4h9a5 5 0 10-.1-9.999 5.002 5.002 0 10-9.78 2.096A4.001 4.001 0 003 15z"/></svg>
                    </div>
                    <h3>Smart Analytics</h3>
                    <p>AI-powered insights help you track spending, set savings goals, and make informed financial decisions with ease.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ═══ CTA ═══ -->
    <section class="cta-section">
        <h2 class="reveal">Ready to Take Control of Your Finances?</h2>
        <p class="reveal">Join thousands of satisfied customers who trust FinTrust for their banking needs.</p>
        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary reveal">Open Your Account Today</a>
    </section>

    <!-- ═══ Footer ═══ -->
    <footer>
        <div class="container">
            <div>
                <div class="brand-footer">
                    <svg fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path></svg>
                    FinTrust Global
                </div>
                <p style="margin-bottom:1rem;">Next-generation banking platform combining advanced technology with personalized financial services. Trusted by customers worldwide.</p>
                <p>&copy; 2026 FinTrust Global Banking Group. All rights reserved.</p>
            </div>
            <div>
                <h4>Quick Links</h4>
                <div class="footer-links">
                    <a href="${pageContext.request.contextPath}/">Home</a>
                    <a href="${pageContext.request.contextPath}/login">Sign In</a>
                    <a href="${pageContext.request.contextPath}/register">Register</a>
                </div>
            </div>
            <div>
                <h4>Banking</h4>
                <div class="footer-links">
                    <a href="${pageContext.request.contextPath}/login">Online Banking</a>
                    <a href="${pageContext.request.contextPath}/register">Open Account</a>
                    <a href="#">Support Center</a>
                </div>
            </div>
            <div>
                <h4>Legal</h4>
                <div class="footer-links">
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Service</a>
                    <a href="#">Customer Agreement</a>
                </div>
            </div>
            <div class="footer-bottom">
                FinTrust Global Banking Group &mdash; SEC Regulated &bull; FDIC Insured
            </div>
        </div>
    </footer>

    <!-- ═══ Scripts ═══ -->
    <script src="${pageContext.request.contextPath}/js/theme.js"></script>
    <script>
        // ── Scroll reveal ──
        (function() {
            var els = document.querySelectorAll('.reveal');
            var observer = new IntersectionObserver(function(entries) {
                entries.forEach(function(e) {
                    if (e.isIntersecting) { e.target.classList.add('visible'); }
                });
            }, { threshold: 0.15 });
            els.forEach(function(el) { observer.observe(el); });
        })();

        // ── Stat counter ──
        (function() {
            var counters = document.querySelectorAll('.stat-number[data-target]');
            var observer = new IntersectionObserver(function(entries) {
                entries.forEach(function(e) {
                    if (e.isIntersecting) {
                        var el = e.target;
                        var target = parseInt(el.getAttribute('data-target'), 10);
                        var dur = 2000;
                        var start = performance.now();
                        function step(now) {
                            var pct = Math.min((now - start) / dur, 1);
                            var cur = Math.round(pct * target);
                            el.textContent = target >= 1000 ? cur.toLocaleString() : cur + (target === 100 ? '%' : '/7');
                            if (pct < 1) { requestAnimationFrame(step); }
                        }
                        requestAnimationFrame(step);
                        observer.unobserve(el);
                    }
                });
            }, { threshold: 0.5 });
            counters.forEach(function(el) { observer.observe(el); });
        })();
    </script>
</body>
</html>