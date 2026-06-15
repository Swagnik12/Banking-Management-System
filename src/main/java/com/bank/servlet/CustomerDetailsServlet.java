package com.bank.servlet;

import com.bank.dao.AccountDAO;
import com.bank.dao.TransactionDAO;
import com.bank.dao.UserDAO;
import com.bank.model.Account;
import com.bank.model.Transaction;
import com.bank.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users/details")
public class CustomerDetailsServlet extends HttpServlet {
    private final UserDAO        userDAO        = new UserDAO();
    private final AccountDAO     accountDAO     = new AccountDAO();
    private final TransactionDAO transactionDAO = new TransactionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        try {
            int userId = Integer.parseInt(idStr.trim());

            User user = userDAO.getUserById(userId);
            if (user == null || !"CUSTOMER".equalsIgnoreCase(user.getRole())) {
                request.setAttribute("error", "Customer not found.");
                request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
                return;
            }

            List<Account>     accounts     = accountDAO.getAccountsByUserId(userId);
            List<Transaction> transactions = transactionDAO.getTransactionsByUserId(userId);

            // Compute total balance across all accounts
            double totalBalance = 0;
            for (Account a : accounts) {
                totalBalance += a.getBalance();
            }

            request.setAttribute("customer",     user);
            request.setAttribute("accounts",     accounts);
            request.setAttribute("transactions", transactions);
            request.setAttribute("totalBalance", totalBalance);

            request.getRequestDispatcher("/jsp/customer-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading customer details: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }
}
