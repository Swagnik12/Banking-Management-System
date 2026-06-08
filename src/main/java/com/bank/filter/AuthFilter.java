package com.bank.filter;

import com.bank.model.User;
import com.bank.util.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String relativeUri = uri.substring(contextPath.length());

        // Allow access to login, register, resources, and root path without authentication
        boolean isLoginRequest = relativeUri.equals("/login") || relativeUri.equals("/");
        boolean isRegisterRequest = relativeUri.equals("/register");
        boolean isStaticResource = relativeUri.startsWith("/css/") || 
                                   relativeUri.startsWith("/js/") || 
                                   relativeUri.startsWith("/images/");

        if (isLoginRequest || isRegisterRequest || isStaticResource) {
            chain.doFilter(request, response);
            return;
        }

        // If not logged in, redirect to login page
        if (!SessionUtil.isLoggedIn(httpRequest)) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        // Access control for administrators
        if (relativeUri.startsWith("/admin")) {
            if (!SessionUtil.isAdmin(httpRequest)) {
                httpRequest.setAttribute("error", "Unauthorized access. Admin role required.");
                httpRequest.getRequestDispatcher("/dashboard").forward(httpRequest, httpResponse);
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
