package com.bank.servlet;

import com.bank.model.Account;
import com.bank.model.User;
import com.bank.service.AccountService;
import com.bank.util.SessionUtil;
import com.bank.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/transfer")
public class TransferServlet extends HttpServlet {
    private final AccountService accountService = new AccountService();

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
            request.getRequestDispatcher("/jsp/transfer.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading accounts: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fromAccount = request.getParameter("fromAccountNumber");
        String toAccount = request.getParameter("toAccountNumber");
        String amountStr = request.getParameter("amount");

        if (ValidationUtil.isNullOrEmpty(fromAccount) || ValidationUtil.isNullOrEmpty(toAccount) || ValidationUtil.isNullOrEmpty(amountStr)) {
            request.setAttribute("error", "All fields are required");
            doGet(request, response);
            return;
        }

        if (fromAccount.equals(toAccount)) {
            request.setAttribute("error", "Source and recipient account numbers must be different");
            doGet(request, response);
            return;
        }

        try {
            double amount = Double.parseDouble(amountStr);
            if (amount <= 0) {
                request.setAttribute("error", "Transfer amount must be greater than zero");
                doGet(request, response);
                return;
            }

            boolean success = accountService.transfer(fromAccount, toAccount, amount);
            if (success) {
                request.setAttribute("success", "Transfer of $" + amount + " to account " + toAccount + " successful!");
            } else {
                request.setAttribute("error", "Transfer failed. Check connection.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid amount format");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }

        doGet(request, response);
    }
}
