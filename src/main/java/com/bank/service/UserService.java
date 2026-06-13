package com.bank.service;

import com.bank.dao.UserDAO;
import com.bank.model.User;
import com.bank.util.ValidationUtil;
import java.util.List;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public boolean register(User user) {
        if (userDAO.isEmailExists(user.getEmail())) {
            throw new IllegalArgumentException("Email already exists");
        }
        // Hash the password
        String hashedPassword = ValidationUtil.hashPassword(user.getPassword());
        user.setPassword(hashedPassword);
        user.setRole("CUSTOMER");
        user.setStatus("PENDING"); // Administrator approves later
        boolean success = userDAO.createUser(user);
        if (success) {
            new com.bank.dao.NotificationDAO().createNotification("New Customer", "New customer registered: " + user.getEmail(), "SUCCESS");
        }
        return success;
    }

    public User login(String email, String password) {
        User user = userDAO.getUserByEmail(email);
        if (user == null) {
            System.out.println("[UserService] login failed: no user for email=" + email);
            return null;
        }

        String hashedPassword = ValidationUtil.hashPassword(password);
        boolean passwordMatch = user.getPassword().equals(hashedPassword);
        System.out.println("[UserService] login email=" + email
                + " userFound=true role=" + user.getRole()
                + " status=" + user.getStatus()
                + " passwordMatch=" + passwordMatch);

        if (passwordMatch) {
            if ("SUSPENDED".equalsIgnoreCase(user.getStatus())) {
                throw new IllegalStateException("Your account has been suspended. Please contact admin.");
            }
            return user;
        }
        return null;
    }

    public boolean updateProfile(User user) {
        return userDAO.updateUser(user);
    }

    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        User user = userDAO.getUserById(userId);
        if (user != null) {
            String hashedOld = ValidationUtil.hashPassword(oldPassword);
            if (user.getPassword().equals(hashedOld)) {
                String hashedNew = ValidationUtil.hashPassword(newPassword);
                return userDAO.updatePassword(userId, hashedNew);
            }
        }
        return false;
    }

    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
}
