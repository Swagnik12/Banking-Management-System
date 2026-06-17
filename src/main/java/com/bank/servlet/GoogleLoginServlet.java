package com.bank.servlet;

import com.bank.dao.AccountDAO;
import com.bank.dao.NotificationDAO;
import com.bank.dao.UserDAO;
import com.bank.model.Account;
import com.bank.model.User;
import com.bank.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Random;

@WebServlet("/google-login")
public class GoogleLoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private final AccountDAO accountDAO = new AccountDAO();
    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");

        if (email == null || email.trim().isEmpty() || fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Invalid Google authentication response.");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            return;
        }

        email = email.trim();

        User user = userDAO.getUserByEmail(email);

        if (user != null) {
            if ("SUSPENDED".equalsIgnoreCase(user.getStatus())) {
                request.setAttribute("error", "Your account has been suspended. Please contact admin.");
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
                return;
            }
        } else {
            String randomPassword = generateRandomPassword();
            String hashedPassword = ValidationUtil.hashPassword(randomPassword);

            user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone("");
            user.setAddress("");
            user.setPassword(hashedPassword);
            user.setRole("CUSTOMER");
            user.setStatus("ACTIVE");

            boolean userCreated = userDAO.createUser(user);
            if (!userCreated) {
                request.setAttribute("error", "Failed to create account. Please try again.");
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
                return;
            }

            Account account = new Account();
            account.setUserId(user.getUserId());
            account.setAccountType("SAVINGS");
            account.setBalance(0.00);
            account.setStatus("ACTIVE");
            account.setAccountNumber(generateAccountNumber());
            accountDAO.createAccount(account);

            notificationDAO.createNotification(
                "Welcome to FinTrust",
                "Your account has been created successfully via Google login. Welcome, " + fullName + "!",
                "SUCCESS"
            );
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("user", user);
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

    private String generateRandomPassword() {
        return java.util.UUID.randomUUID().toString();
    }

    private String generateAccountNumber() {
        Random random = new Random();
        String accountNo;
        do {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < 10; i++) {
                sb.append(random.nextInt(10));
            }
            accountNo = sb.toString();
        } while (accountDAO.getAccountByNumber(accountNo) != null);
        return accountNo;
    }
}
