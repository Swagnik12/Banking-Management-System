package com.bank.util;

import com.bank.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {
    public static User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (User) session.getAttribute("user");
        }
        return null;
    }

    public static boolean isLoggedIn(HttpServletRequest request) {
        return getLoggedInUser(request) != null;
    }

    public static boolean isAdmin(HttpServletRequest request) {
        User user = getLoggedInUser(request);
        return user != null && "ADMIN".equalsIgnoreCase(user.getRole());
    }
}
