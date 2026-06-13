package com.bank.service;

import com.bank.dao.AdminDAO;
import com.bank.dao.UserDAO;
import com.bank.dao.AccountDAO;
import com.bank.model.User;
import com.bank.model.Account;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminService {
    private final AdminDAO adminDAO = new AdminDAO();
    private final UserDAO userDAO = new UserDAO();
    private final AccountDAO accountDAO = new AccountDAO();

    public Map<String, Integer> getDashboardStats() {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("totalUsers",       adminDAO.getTotalUsers());
        stats.put("totalAccounts",    adminDAO.getTotalAccounts());
        stats.put("activeAccounts",   adminDAO.getActiveAccounts());
        stats.put("frozenAccounts",   adminDAO.getSuspendedAccounts());
        stats.put("pendingUsers",     adminDAO.getPendingUsersCount());
        stats.put("totalTransactions", adminDAO.getTotalTransactions());
        return stats;
    }

    public boolean approveUser(int userId) {
        boolean success = userDAO.updateUserStatus(userId, "ACTIVE");
        if (success) {
            new com.bank.dao.NotificationDAO().createNotification("User Approved", "User ID " + userId + " has been approved.", "SUCCESS");
        }
        return success;
    }

    public boolean suspendUser(int userId) {
        boolean success = userDAO.updateUserStatus(userId, "SUSPENDED");
        if (success) {
            com.bank.dao.NotificationDAO notifDAO = new com.bank.dao.NotificationDAO();
            notifDAO.createNotification(
                "User Suspended",
                "User ID " + userId + " has been suspended.",
                "DANGER"
            );
            int frozenCount = accountDAO.freezeAccountsByUserId(userId);
            if (frozenCount > 0) {
                notifDAO.createNotification(
                    "Accounts Frozen",
                    frozenCount + " account(s) for User ID " + userId +
                        " have been automatically frozen.",
                    "DANGER"
                );
            }
        }
        return success;
    }

    public boolean activateUser(int userId) {
        boolean success = userDAO.updateUserStatus(userId, "ACTIVE");
        if (success) {
            com.bank.dao.NotificationDAO notifDAO = new com.bank.dao.NotificationDAO();
            notifDAO.createNotification(
                "User Reactivated",
                "User ID " + userId + " has been reactivated.",
                "INFO"
            );
            int reactivatedCount = accountDAO.reactivateAccountsByUserId(userId);
            if (reactivatedCount > 0) {
                notifDAO.createNotification(
                    "Accounts Reactivated",
                    reactivatedCount + " account(s) for User ID " + userId +
                        " have been automatically reactivated.",
                    "INFO"
                );
            }
        }
        return success;
    }

    public boolean activateAccount(int accountId) {
        return accountDAO.updateAccountStatus(accountId, "ACTIVE");
    }

    public boolean approveAccount(int accountId) {
        boolean success = accountDAO.updateAccountStatus(accountId, "ACTIVE");
        if (success) {
            new com.bank.dao.NotificationDAO().createNotification(
                "Account Approved", "Account ID " + accountId + " has been approved and activated.", "SUCCESS");
        }
        return success;
    }

    public boolean freezeAccount(int accountId) {
        boolean success = accountDAO.updateAccountStatus(accountId, "FROZEN");
        if (success) {
            new com.bank.dao.NotificationDAO().createNotification(
                "Account Frozen", "Account ID " + accountId + " has been frozen by admin.", "DANGER");
        }
        return success;
    }

    public boolean reactivateAccount(int accountId) {
        boolean success = accountDAO.updateAccountStatus(accountId, "ACTIVE");
        if (success) {
            new com.bank.dao.NotificationDAO().createNotification(
                "Account Reactivated", "Account ID " + accountId + " has been reactivated.", "INFO");
        }
        return success;
    }

    public List<Account> searchAccounts(String query) {
        return accountDAO.searchAccounts(query);
    }

    public List<User> getPendingUsers() {
        return adminDAO.getPendingUsers();
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public List<Account> getAllAccounts() {
        return accountDAO.getAllAccountsWithCustomerName();
    }

    public List<User> searchUsers(String query) {
        return userDAO.searchUsers(query);
    }
}
