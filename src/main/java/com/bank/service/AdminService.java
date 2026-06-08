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
        stats.put("totalUsers", adminDAO.getTotalUsers());
        stats.put("totalAccounts", adminDAO.getTotalAccounts());
        stats.put("activeAccounts", adminDAO.getActiveAccounts());
        stats.put("suspendedAccounts", adminDAO.getSuspendedAccounts());
        stats.put("totalTransactions", adminDAO.getTotalTransactions());
        return stats;
    }

    public boolean approveUser(int userId) {
        return userDAO.updateUserStatus(userId, "ACTIVE");
    }

    public boolean suspendUser(int userId) {
        return userDAO.updateUserStatus(userId, "SUSPENDED");
    }

    public boolean activateUser(int userId) {
        return userDAO.updateUserStatus(userId, "ACTIVE");
    }

    public boolean activateAccount(int accountId) {
        return accountDAO.updateAccountStatus(accountId, "ACTIVE");
    }

    public boolean suspendAccount(int accountId) {
        return accountDAO.updateAccountStatus(accountId, "SUSPENDED");
    }

    public List<User> getPendingUsers() {
        return adminDAO.getPendingUsers();
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public List<Account> getAllAccounts() {
        return accountDAO.getAllAccounts();
    }
}
