package com.bank.dao;

import com.bank.model.Transaction;
import com.bank.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {

    public boolean createTransaction(Transaction txn) {
        String sql = "INSERT INTO transactions (sender_account, receiver_account, transaction_type, amount, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, txn.getSenderAccount());
            ps.setString(2, txn.getReceiverAccount());
            ps.setString(3, txn.getTransactionType());
            ps.setDouble(4, txn.getAmount());
            ps.setString(5, txn.getStatus() != null ? txn.getStatus() : "SUCCESS");

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        txn.setTransactionId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Support transaction-based transaction creation
    public boolean createTransaction(Connection conn, Transaction txn) throws SQLException {
        String sql = "INSERT INTO transactions (sender_account, receiver_account, transaction_type, amount, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, txn.getSenderAccount());
            ps.setString(2, txn.getReceiverAccount());
            ps.setString(3, txn.getTransactionType());
            ps.setDouble(4, txn.getAmount());
            ps.setString(5, txn.getStatus() != null ? txn.getStatus() : "SUCCESS");

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        txn.setTransactionId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    public List<Transaction> getTransactionsByAccount(String accountNumber) {
        List<Transaction> list = new ArrayList<>();
        String sql = "SELECT * FROM transactions WHERE sender_account = ? OR receiver_account = ? ORDER BY transaction_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, accountNumber);
            ps.setString(2, accountNumber);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToTransaction(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Transaction> getTransactionsByDateRange(String accountNumber, Date fromDate, Date toDate) {
        List<Transaction> list = new ArrayList<>();
        String sql = "SELECT * FROM transactions WHERE (sender_account = ? OR receiver_account = ?) " +
                     "AND DATE(transaction_date) BETWEEN ? AND ? ORDER BY transaction_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, accountNumber);
            ps.setString(2, accountNumber);
            ps.setDate(3, fromDate);
            ps.setDate(4, toDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToTransaction(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Transaction> getTransactionsByType(String accountNumber, String type) {
        List<Transaction> list = new ArrayList<>();
        String sql = "SELECT * FROM transactions WHERE (sender_account = ? OR receiver_account = ?) " +
                     "AND transaction_type = ? ORDER BY transaction_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, accountNumber);
            ps.setString(2, accountNumber);
            ps.setString(3, type);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToTransaction(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Transaction> getAllTransactions() {
        List<Transaction> list = new ArrayList<>();
        String sql = "SELECT * FROM transactions ORDER BY transaction_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToTransaction(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countTransactions() {
        String sql = "SELECT COUNT(*) FROM transactions";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Transaction mapResultSetToTransaction(ResultSet rs) throws SQLException {
        return new Transaction(
                rs.getInt("transaction_id"),
                rs.getString("sender_account"),
                rs.getString("receiver_account"),
                rs.getString("transaction_type"),
                rs.getDouble("amount"),
                rs.getTimestamp("transaction_date"),
                rs.getString("status")
        );
    }
}
