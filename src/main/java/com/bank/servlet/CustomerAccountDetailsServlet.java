package com.bank.servlet;

import com.bank.dao.AccountDAO;
import com.bank.dao.TransactionDAO;
import com.bank.model.Account;
import com.bank.model.Transaction;
import com.bank.model.User;
import com.bank.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/account/details")
public class CustomerAccountDetailsServlet extends HttpServlet {
    private final AccountDAO accountDAO = new AccountDAO();
    private final TransactionDAO transactionDAO = new TransactionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
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

            if (account.getUserId() != user.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
                return;
            }

            List<Transaction> transactions = transactionDAO.getTransactionsByAccount(account.getAccountNumber());

            int totalDeposits = 0;
            int totalWithdrawals = 0;
            int totalTransfers = 0;
            double totalDepositAmount = 0;
            double totalWithdrawalAmount = 0;

            for (Transaction t : transactions) {
                switch (t.getTransactionType()) {
                    case "DEPOSIT":
                        totalDeposits++;
                        totalDepositAmount += t.getAmount();
                        break;
                    case "WITHDRAWAL":
                        totalWithdrawals++;
                        totalWithdrawalAmount += t.getAmount();
                        break;
                    case "TRANSFER":
                        totalTransfers++;
                        break;
                }
            }

            request.setAttribute("account", account);
            request.setAttribute("transactions", transactions);
            request.setAttribute("totalTransactions", transactions.size());
            request.setAttribute("totalDeposits", totalDeposits);
            request.setAttribute("totalWithdrawals", totalWithdrawals);
            request.setAttribute("totalTransfers", totalTransfers);
            request.setAttribute("totalDepositAmount", totalDepositAmount);
            request.setAttribute("totalWithdrawalAmount", totalWithdrawalAmount);

            request.getRequestDispatcher("/jsp/account-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading account details: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }
}
