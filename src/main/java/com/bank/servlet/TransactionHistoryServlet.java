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

@WebServlet("/transactions")
public class TransactionHistoryServlet extends HttpServlet {
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
            List<Account> accounts = accountService.getAccounts(user.getUserId());
            request.setAttribute("accounts", accounts);

            String accountNumber = request.getParameter("accountNumber");
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            String transactionType = request.getParameter("transactionType");

            // Default to the first account if none selected
            if ((accountNumber == null || accountNumber.trim().isEmpty()) && accounts != null && !accounts.isEmpty()) {
                accountNumber = accounts.get(0).getAccountNumber();
            }

            List<Transaction> transactions = new ArrayList<>();
            if (accountNumber != null && !accountNumber.trim().isEmpty()) {
                transactions = transactionService.getFilteredTransactions(accountNumber, fromDate, toDate, transactionType);
            }

            request.setAttribute("transactions", transactions);
            request.setAttribute("selectedAccount", accountNumber);
            request.setAttribute("fromDate", fromDate);
            request.setAttribute("toDate", toDate);
            request.setAttribute("selectedType", transactionType);

            request.getRequestDispatcher("/jsp/transactions.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading transactions: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
