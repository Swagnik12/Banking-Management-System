package com.bank.servlet;

import com.bank.model.Account;
import com.bank.model.Transaction;
import com.bank.model.User;
import com.bank.service.AccountService;
import com.bank.service.TransactionService;
import com.bank.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private final AccountService accountService = new AccountService();
    private final TransactionService transactionService = new TransactionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Read success/error flash messages from session if they exist
            Object successMsg = request.getSession().getAttribute("success");
            if (successMsg != null) {
                request.setAttribute("success", successMsg);
                request.getSession().removeAttribute("success");
            }
            Object errorMsg = request.getSession().getAttribute("error");
            if (errorMsg != null) {
                request.setAttribute("error", errorMsg);
                request.getSession().removeAttribute("error");
            }

            List<Account> accounts = accountService.getAccounts(user.getUserId());
            request.setAttribute("accounts", accounts);

            List<Transaction> recentTransactions = new ArrayList<>();
            String contextAccountNumber = null;
            int totalTransactionCount = 0;
            Account primaryAccount = null;
            // Load transactions for the first active account found, if any
            if (accounts != null && !accounts.isEmpty()) {
                for (Account acc : accounts) {
                    if ("ACTIVE".equalsIgnoreCase(acc.getStatus())) {
                        primaryAccount = acc;
                        contextAccountNumber = acc.getAccountNumber();
                        List<Transaction> txns = transactionService.getTransactionHistory(contextAccountNumber);
                        if (txns != null) {
                            totalTransactionCount = txns.size();
                            // Cap at top 5 recent transactions
                            recentTransactions.addAll(txns.subList(0, Math.min(txns.size(), 5)));
                        }
                        break;
                    }
                }
            }
            request.setAttribute("recentTransactions", recentTransactions);
            request.setAttribute("contextAccountNumber", contextAccountNumber);
            request.setAttribute("totalTransactionCount", totalTransactionCount);
            request.setAttribute("primaryAccount", primaryAccount);

            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load dashboard data: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle account creation requests from dashboard
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String accountType = request.getParameter("accountType");
        if (accountType == null || (!accountType.equalsIgnoreCase("SAVINGS") && !accountType.equalsIgnoreCase("CURRENT"))) {
            request.getSession().setAttribute("error", "Invalid account type selected");
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        try {
            boolean created = accountService.createAccount(user.getUserId(), accountType);
            if (created) {
                request.getSession().setAttribute("success", "Account application submitted successfully and is pending admin approval.");
            } else {
                request.getSession().setAttribute("error", "Failed to apply for new account.");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error creating account: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}
