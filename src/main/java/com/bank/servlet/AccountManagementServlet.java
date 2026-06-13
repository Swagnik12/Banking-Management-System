package com.bank.servlet;

import com.bank.model.Account;
import com.bank.service.AdminService;
import com.bank.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/accounts")
public class AccountManagementServlet extends HttpServlet {
    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String searchQuery = request.getParameter("search");
            List<Account> accounts;
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                accounts = adminService.searchAccounts(searchQuery.trim());
                request.setAttribute("searchQuery", searchQuery.trim());
            } else {
                accounts = adminService.getAllAccounts();
            }
            request.setAttribute("accounts", accounts);
            request.getRequestDispatcher("/jsp/manage-accounts.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading accounts: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountIdStr = request.getParameter("accountId");
        String action = request.getParameter("action");

        if (ValidationUtil.isNullOrEmpty(accountIdStr) || ValidationUtil.isNullOrEmpty(action)) {
            request.setAttribute("error", "Missing required parameters");
            doGet(request, response);
            return;
        }

        try {
            int accountId = Integer.parseInt(accountIdStr);
            boolean success = false;

            if ("approve".equalsIgnoreCase(action)) {
                success = adminService.approveAccount(accountId);
                if (success) request.setAttribute("success", "Account #" + accountId + " has been approved and is now ACTIVE.");
            } else if ("freeze".equalsIgnoreCase(action)) {
                success = adminService.freezeAccount(accountId);
                if (success) request.setAttribute("success", "Account #" + accountId + " has been frozen.");
            } else if ("reactivate".equalsIgnoreCase(action)) {
                success = adminService.reactivateAccount(accountId);
                if (success) request.setAttribute("success", "Account #" + accountId + " has been reactivated.");
            } else {
                request.setAttribute("error", "Invalid account management action requested");
            }

            if (!success && request.getAttribute("error") == null) {
                request.setAttribute("error", "Failed to update account status");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid account ID format");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }

        doGet(request, response);
    }
}
