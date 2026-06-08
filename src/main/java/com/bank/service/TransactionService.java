package com.bank.service;

import com.bank.dao.TransactionDAO;
import com.bank.model.Transaction;
import java.sql.Date;
import java.util.List;

public class TransactionService {
    private final TransactionDAO transactionDAO = new TransactionDAO();

    public List<Transaction> getTransactionHistory(String accountNumber) {
        return transactionDAO.getTransactionsByAccount(accountNumber);
    }

    public List<Transaction> getFilteredTransactions(String accountNumber, String fromDateStr, String toDateStr, String type) {
        // If type is specified and not ALL, and no dates
        boolean hasType = type != null && !type.trim().isEmpty() && !"ALL".equalsIgnoreCase(type);
        boolean hasDates = fromDateStr != null && !fromDateStr.trim().isEmpty() &&
                           toDateStr != null && !toDateStr.trim().isEmpty();

        if (hasDates) {
            Date from = Date.valueOf(fromDateStr);
            Date to = Date.valueOf(toDateStr);
            // First get date filtered
            List<Transaction> txns = transactionDAO.getTransactionsByDateRange(accountNumber, from, to);
            // Apply in-memory type filter if also specified to avoid database method bloat
            if (hasType) {
                txns.removeIf(t -> !t.getTransactionType().equalsIgnoreCase(type));
            }
            return txns;
        } else if (hasType) {
            return transactionDAO.getTransactionsByType(accountNumber, type.toUpperCase());
        }

        return getTransactionHistory(accountNumber);
    }

    public List<Transaction> getAllTransactions() {
        return transactionDAO.getAllTransactions();
    }
}
