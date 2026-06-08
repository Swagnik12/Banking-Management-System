package com.bank.servlet;

import com.bank.model.User;
import com.bank.service.UserService;
import com.bank.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Input checks
        if (ValidationUtil.isNullOrEmpty(fullName) || ValidationUtil.isNullOrEmpty(email) ||
            ValidationUtil.isNullOrEmpty(phone) || ValidationUtil.isNullOrEmpty(address) ||
            ValidationUtil.isNullOrEmpty(password) || ValidationUtil.isNullOrEmpty(confirmPassword)) {
            
            request.setAttribute("error", "All fields are required");
            preserveFormValues(request);
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Invalid email format");
            preserveFormValues(request);
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidPhone(phone)) {
            request.setAttribute("error", "Phone number must be digits between 10 and 15 characters");
            preserveFormValues(request);
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            preserveFormValues(request);
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("error", "Password must be at least 6 characters long");
            preserveFormValues(request);
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        try {
            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setPassword(password);

            boolean success = userService.register(user);
            if (success) {
                HttpSessionSessionSet(request, "Registration successful! Account is pending administrator approval.");
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                request.setAttribute("error", "Failed to register user. Try again.");
                preserveFormValues(request);
                request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            preserveFormValues(request);
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An internal error occurred: " + e.getMessage());
            preserveFormValues(request);
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        }
    }

    private void preserveFormValues(HttpServletRequest request) {
        request.setAttribute("fullName", request.getParameter("fullName"));
        request.setAttribute("email", request.getParameter("email"));
        request.setAttribute("phone", request.getParameter("phone"));
        request.setAttribute("address", request.getParameter("address"));
    }

    private void HttpSessionSessionSet(HttpServletRequest request, String msg) {
        jakarta.servlet.http.HttpSession session = request.getSession(true);
        session.setAttribute("success", msg);
    }
}
