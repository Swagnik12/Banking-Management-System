package com.bank.service;

import com.bank.dao.AccountDAO;
import com.bank.dao.TransactionDAO;
import com.bank.model.Account;
import com.bank.model.Transaction;
import com.bank.util.DBConnection;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Random;

public class AccountService {
    private final AccountDAO accountDAO = new AccountDAO();
    private final TransactionDAO transactionDAO = new TransactionDAO();

    public boolean createAccount(int userId, String accountType) {
        String accountNumber = generateUniqueAccountNumber();
        Account account = new Account();
        account.setAccountNumber(accountNumber);
        account.setUserId(userId);
        account.setAccountType(accountType.toUpperCase());
        account.setBalance(0.00);
        account.setStatus("PENDING"); // Pending admin approval
        boolean success = accountDAO.createAccount(account);
        if (success) {
            new com.bank.dao.NotificationDAO().createNotification("New Account", "New " + accountType + " account created for User ID: " + userId, "INFO");
        }
        return success;
    }

    public List<Account> getAccounts(int userId) {
        return accountDAO.getAccountsByUserId(userId);
    }

    public Account getAccountByNumber(String accountNumber) {
        return accountDAO.getAccountByNumber(accountNumber);
    }

    public boolean deposit(String accountNumber, double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be greater than zero");
        }
        Account account = accountDAO.getAccountByNumber(accountNumber);
        if (account == null) {
            throw new IllegalArgumentException("Account not found");
        }
        if (!"ACTIVE".equalsIgnoreCase(account.getStatus())) {
            throw new IllegalStateException("Account is not active (" + account.getStatus() + ")");
        }

        double newBalance = account.getBalance() + amount;
        boolean updated = accountDAO.updateBalance(accountNumber, newBalance);
        if (updated) {
            Transaction txn = new Transaction();
            txn.setSenderAccount(null);
            txn.setReceiverAccount(accountNumber);
            txn.setTransactionType("DEPOSIT");
            txn.setAmount(amount);
            txn.setStatus("SUCCESS");
            transactionDAO.createTransaction(txn);
            return true;
        }
        return false;
    }

    public boolean withdraw(String accountNumber, double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be greater than zero");
        }
        Account account = accountDAO.getAccountByNumber(accountNumber);
        if (account == null) {
            throw new IllegalArgumentException("Account not found");
        }
        if (!"ACTIVE".equalsIgnoreCase(account.getStatus())) {
            throw new IllegalStateException("Account is not active (" + account.getStatus() + ")");
        }
        if (account.getBalance() < amount) {
            throw new IllegalArgumentException("Insufficient funds");
        }

        double newBalance = account.getBalance() - amount;
        boolean updated = accountDAO.updateBalance(accountNumber, newBalance);
        if (updated) {
            Transaction txn = new Transaction();
            txn.setSenderAccount(accountNumber);
            txn.setReceiverAccount(null);
            txn.setTransactionType("WITHDRAWAL");
            txn.setAmount(amount);
            txn.setStatus("SUCCESS");
            transactionDAO.createTransaction(txn);
            return true;
        }
        return false;
    }

    public boolean transfer(String fromAccountNum, String toAccountNum, double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Transfer amount must be greater than zero");
        }
        if (fromAccountNum.equals(toAccountNum)) {
            throw new IllegalArgumentException("Cannot transfer to the same account");
        }

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Begin transaction

            Account fromAccount = accountDAO.getAccountByNumber(fromAccountNum);
            Account toAccount = accountDAO.getAccountByNumber(toAccountNum);

            if (fromAccount == null || toAccount == null) {
                throw new IllegalArgumentException("Sender or Receiver account not found");
            }
            if (!"ACTIVE".equalsIgnoreCase(fromAccount.getStatus())) {
                throw new IllegalStateException("Sender account is not ACTIVE");
            }
            if (!"ACTIVE".equalsIgnoreCase(toAccount.getStatus())) {
                throw new IllegalStateException("Receiver account is not ACTIVE");
            }
            if (fromAccount.getBalance() < amount) {
                throw new IllegalArgumentException("Insufficient balance");
            }

            // Deduct sender
            double newSenderBalance = fromAccount.getBalance() - amount;
            accountDAO.updateBalance(conn, fromAccountNum, newSenderBalance);

            // Add receiver
            double newReceiverBalance = toAccount.getBalance() + amount;
            accountDAO.updateBalance(conn, toAccountNum, newReceiverBalance);

            // Log Transaction
            Transaction txn = new Transaction();
            txn.setSenderAccount(fromAccountNum);
            txn.setReceiverAccount(toAccountNum);
            txn.setTransactionType("TRANSFER");
            txn.setAmount(amount);
            txn.setStatus("SUCCESS");
            transactionDAO.createTransaction(conn, txn);

            conn.commit(); // Commit transaction
            return true;
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback on error
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw new RuntimeException("Transfer failed: " + e.getMessage(), e);
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private String generateUniqueAccountNumber() {
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
