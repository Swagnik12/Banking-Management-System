package com.bank.servlet;

import com.bank.model.User;
import com.bank.service.UserService;
import com.bank.util.SessionUtil;
import com.bank.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        // Always refresh user details from database
        User dbUser = userService.getUserById(user.getUserId());
        request.setAttribute("profileUser", dbUser);
        request.getRequestDispatcher("/jsp/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("updateProfile".equalsIgnoreCase(action)) {
                String fullName = request.getParameter("fullName");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");

                if (ValidationUtil.isNullOrEmpty(fullName) || ValidationUtil.isNullOrEmpty(phone) || ValidationUtil.isNullOrEmpty(address)) {
                    request.setAttribute("error", "All fields are required for profile update");
                } else if (!ValidationUtil.isValidPhone(phone)) {
                    request.setAttribute("error", "Phone number must be digits between 10 and 15 characters");
                } else {
                    User updatedUser = userService.getUserById(user.getUserId());
                    updatedUser.setFullName(fullName);
                    updatedUser.setPhone(phone);
                    updatedUser.setAddress(address);

                    boolean success = userService.updateProfile(updatedUser);
                    if (success) {
                        request.setAttribute("success", "Profile updated successfully!");
                        request.getSession().setAttribute("user", updatedUser);
                    } else {
                        request.setAttribute("error", "Failed to update profile details");
                    }
                }
            } else if ("changePassword".equalsIgnoreCase(action)) {
                String oldPassword = request.getParameter("oldPassword");
                String newPassword = request.getParameter("newPassword");
                String confirmNewPassword = request.getParameter("confirmNewPassword");

                if (ValidationUtil.isNullOrEmpty(oldPassword) || ValidationUtil.isNullOrEmpty(newPassword) || ValidationUtil.isNullOrEmpty(confirmNewPassword)) {
                    request.setAttribute("error", "All fields are required for password change");
                } else if (!newPassword.equals(confirmNewPassword)) {
                    request.setAttribute("error", "New passwords do not match");
                } else if (!ValidationUtil.isValidPassword(newPassword)) {
                    request.setAttribute("error", "New password must be at least 6 characters long");
                } else {
                    boolean success = userService.changePassword(user.getUserId(), oldPassword, newPassword);
                    if (success) {
                        request.setAttribute("success", "Password changed successfully!");
                    } else {
                        request.setAttribute("error", "Invalid old password provided");
                    }
                }
            } else {
                request.setAttribute("error", "Unknown profile action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
        }

        // Re-render profile page
        User dbUser = userService.getUserById(user.getUserId());
        request.setAttribute("profileUser", dbUser);
        request.getRequestDispatcher("/jsp/profile.jsp").forward(request, response);
    }
}
