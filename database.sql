CREATE DATABASE IF NOT EXISTS banking_db;
USE banking_db;

-- Drop tables if they exist to start fresh (in dependency order)
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS users;

-- users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    password VARCHAR(255) NOT NULL, -- Will store SHA-256 hash
    role ENUM('CUSTOMER', 'ADMIN') DEFAULT 'CUSTOMER',
    status ENUM('PENDING', 'ACTIVE', 'SUSPENDED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- accounts table
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    user_id INT NOT NULL,
    account_type ENUM('SAVINGS', 'CURRENT') NOT NULL,
    balance DECIMAL(15, 2) DEFAULT 0.00,
    status ENUM('PENDING', 'ACTIVE', 'FROZEN', 'CLOSED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- transactions table
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_account VARCHAR(20),
    receiver_account VARCHAR(20),
    transaction_type ENUM('DEPOSIT', 'WITHDRAWAL', 'TRANSFER') NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('SUCCESS', 'FAILED', 'PENDING') DEFAULT 'SUCCESS'
);

-- Seed an Administrator account
-- Password: admin123
-- SHA-256 of admin123: 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
INSERT INTO users (full_name, email, phone, address, password, role, status)
VALUES ('Administrator', 'admin@bank.com', '0000000000', 'System Head Office', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN', 'ACTIVE');

-- notifications table
CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    message VARCHAR(255) NOT NULL,
    type VARCHAR(20) NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- MIGRATION: Standardize account status SUSPENDED → FROZEN
-- Run this against existing databases that have SUSPENDED rows
-- ============================================================

-- Step 1: Temporarily widen the column to allow both values during migration
ALTER TABLE accounts MODIFY COLUMN status ENUM('PENDING', 'ACTIVE', 'SUSPENDED', 'FROZEN', 'CLOSED') DEFAULT 'PENDING';

-- Step 2: Migrate all existing SUSPENDED rows to FROZEN
UPDATE accounts SET status = 'FROZEN' WHERE status = 'SUSPENDED';

-- Step 3: Lock the column to the final allowed set (drop SUSPENDED)
ALTER TABLE accounts MODIFY COLUMN status ENUM('PENDING', 'ACTIVE', 'FROZEN', 'CLOSED') DEFAULT 'PENDING';
