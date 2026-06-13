package com.bank.servlet;

import com.bank.model.User;
import com.bank.service.AdminService;
import com.bank.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class UserManagementServlet extends HttpServlet {
    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String searchQuery = request.getParameter("search");
            List<User> users;
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                users = adminService.searchUsers(searchQuery.trim());
                request.setAttribute("searchQuery", searchQuery.trim());
            } else {
                users = adminService.getAllUsers();
            }
            request.setAttribute("users", users);
            request.getRequestDispatcher("/jsp/manage-users.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading users: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        String action = request.getParameter("action");

        if (ValidationUtil.isNullOrEmpty(userIdStr) || ValidationUtil.isNullOrEmpty(action)) {
            request.setAttribute("error", "Missing required parameters");
            doGet(request, response);
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            boolean success = false;

            if ("approve".equalsIgnoreCase(action) || "activate".equalsIgnoreCase(action)) {
                success = adminService.approveUser(userId);
                if (success) request.setAttribute("success", "User status updated to ACTIVE!");
            } else if ("suspend".equalsIgnoreCase(action)) {
                success = adminService.suspendUser(userId);
                if (success) request.setAttribute("success", "User status updated to SUSPENDED!");
            } else {
                request.setAttribute("error", "Invalid user management action requested");
            }

            if (!success && request.getAttribute("error") == null) {
                request.setAttribute("error", "Failed to update user status");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid user ID format");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }

        doGet(request, response);
    }
}
