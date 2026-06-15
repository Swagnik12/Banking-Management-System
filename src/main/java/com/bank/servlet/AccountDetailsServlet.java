package com.bank.servlet;

import com.bank.dao.AccountDAO;
import com.bank.dao.TransactionDAO;
import com.bank.dao.UserDAO;
import com.bank.model.Account;
import com.bank.model.Transaction;
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

@WebServlet("/admin/accounts/details")
public class AccountDetailsServlet extends HttpServlet {
    private final AccountDAO     accountDAO     = new AccountDAO();
    private final UserDAO        userDAO        = new UserDAO();
    private final TransactionDAO transactionDAO = new TransactionDAO();
    private final AdminService   adminService   = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (ValidationUtil.isNullOrEmpty(idStr)) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }
        try {
            int accountId = Integer.parseInt(idStr.trim());

            Account account = accountDAO.getAccountById(accountId);
            if (account == null) {
                request.setAttribute("error", "Account not found.");
                request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
                return;
            }

            User customer = userDAO.getUserById(account.getUserId());
            List<Transaction> transactions = transactionDAO.getTransactionsByAccount(account.getAccountNumber());

            // Total deposits and withdrawals for summary
            double totalIn  = 0;
            double totalOut = 0;
            for (Transaction t : transactions) {
                if ("DEPOSIT".equals(t.getTransactionType())) {
                    totalIn += t.getAmount();
                } else if ("WITHDRAWAL".equals(t.getTransactionType()) || "TRANSFER".equals(t.getTransactionType())) {
                    totalOut += t.getAmount();
                }
            }

            request.setAttribute("account",      account);
            request.setAttribute("customer",     customer);
            request.setAttribute("transactions", transactions);
            request.setAttribute("totalIn",      totalIn);
            request.setAttribute("totalOut",     totalOut);

            // Pass any flash messages from POST
            if (request.getSession(false) != null) {
                String flashSuccess = (String) request.getSession(false).getAttribute("flash_success");
                String flashError   = (String) request.getSession(false).getAttribute("flash_error");
                if (flashSuccess != null) {
                    request.setAttribute("success", flashSuccess);
                    request.getSession(false).removeAttribute("flash_success");
                }
                if (flashError != null) {
                    request.setAttribute("error", flashError);
                    request.getSession(false).removeAttribute("flash_error");
                }
            }

            request.getRequestDispatcher("/jsp/account-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading account details: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr  = request.getParameter("accountId");
        String action = request.getParameter("action");

        if (ValidationUtil.isNullOrEmpty(idStr) || ValidationUtil.isNullOrEmpty(action)) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }

        try {
            int accountId = Integer.parseInt(idStr.trim());
            boolean success = false;

            if ("freeze".equalsIgnoreCase(action)) {
                success = adminService.freezeAccount(accountId);
                if (success) request.getSession(true).setAttribute("flash_success", "Account #" + accountId + " has been frozen.");
                else         request.getSession(true).setAttribute("flash_error",   "Failed to freeze account.");

            } else if ("reactivate".equalsIgnoreCase(action)) {
                success = adminService.reactivateAccount(accountId);
                if (success) request.getSession(true).setAttribute("flash_success", "Account #" + accountId + " has been reactivated.");
                else         request.getSession(true).setAttribute("flash_error",   "Failed to reactivate account.");

            } else if ("approve".equalsIgnoreCase(action)) {
                success = adminService.approveAccount(accountId);
                if (success) request.getSession(true).setAttribute("flash_success", "Account #" + accountId + " has been approved.");
                else         request.getSession(true).setAttribute("flash_error",   "Failed to approve account.");
            }

            // PRG — always redirect back to the detail page
            response.sendRedirect(request.getContextPath() + "/admin/accounts/details?id=" + accountId);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
        }
    }
}
