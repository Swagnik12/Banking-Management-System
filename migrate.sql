-- ============================================================
-- migrate.sql
-- Run this against an EXISTING banking_db to standardise
-- account statuses from SUSPENDED → FROZEN.
--
-- Safe to run multiple times (idempotent).
-- DO NOT run this as part of database.sql (which drops all tables).
-- ============================================================

USE banking_db;

-- Step 1: Widen the ENUM to accept both old and new value during migration
ALTER TABLE accounts
    MODIFY COLUMN status ENUM('PENDING','ACTIVE','SUSPENDED','FROZEN','CLOSED') DEFAULT 'PENDING';

-- Step 2: Migrate existing SUSPENDED rows to FROZEN
UPDATE accounts SET status = 'FROZEN' WHERE status = 'SUSPENDED';

-- Step 3: Remove SUSPENDED from the allowed set
ALTER TABLE accounts
    MODIFY COLUMN status ENUM('PENDING','ACTIVE','FROZEN','CLOSED') DEFAULT 'PENDING';

-- Verify: should return 0
SELECT COUNT(*) AS remaining_suspended FROM accounts WHERE status = 'SUSPENDED';

-- Verify: current distribution
SELECT status, COUNT(*) AS total FROM accounts GROUP BY status;
