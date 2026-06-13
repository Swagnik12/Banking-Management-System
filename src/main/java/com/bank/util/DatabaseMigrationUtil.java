package com.bank.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Runs on every application startup via AppStartupListener.
 *
 * Guarantees the accounts.status ENUM is:
 *   ENUM('PENDING','ACTIVE','FROZEN','CLOSED')
 *
 * Also migrates any legacy SUSPENDED rows to FROZEN.
 *
 * Safe to run multiple times — checks current ENUM definition first.
 */
public class DatabaseMigrationUtil {

    public static void migrateAccountStatuses() {
        try (Connection conn = DBConnection.getConnection()) {

            // ----------------------------------------------------------------
            // Step 1: Check whether FROZEN is already in the ENUM.
            // Query information_schema — no ALTER needed if already correct.
            // ----------------------------------------------------------------
            boolean frozenPresent  = false;
            boolean suspendedPresent = false;

            String checkEnum =
                "SELECT COLUMN_TYPE FROM information_schema.COLUMNS " +
                "WHERE TABLE_SCHEMA = DATABASE() " +
                "AND TABLE_NAME = 'accounts' " +
                "AND COLUMN_NAME = 'status'";

            try (PreparedStatement ps = conn.prepareStatement(checkEnum);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String colType = rs.getString("COLUMN_TYPE"); // e.g. enum('PENDING','ACTIVE','SUSPENDED','CLOSED')
                    frozenPresent   = colType.contains("'FROZEN'");
                    suspendedPresent = colType.contains("'SUSPENDED'");
                    System.out.println("[Migration] accounts.status current definition: " + colType);
                }
            }

            // ----------------------------------------------------------------
            // Step 2: If FROZEN is missing or SUSPENDED is still present,
            // run the three-step ENUM migration.
            // ----------------------------------------------------------------
            if (!frozenPresent || suspendedPresent) {
                System.out.println("[Migration] ENUM needs updating. Applying schema fix...");

                // Widen to accept all values during transition
                try (PreparedStatement ps = conn.prepareStatement(
                        "ALTER TABLE accounts MODIFY COLUMN status " +
                        "ENUM('PENDING','ACTIVE','SUSPENDED','FROZEN','CLOSED') DEFAULT 'PENDING'")) {
                    ps.executeUpdate();
                }

                // Migrate any SUSPENDED rows to FROZEN
                try (PreparedStatement ps = conn.prepareStatement(
                        "UPDATE accounts SET status = 'FROZEN' WHERE status = 'SUSPENDED'")) {
                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        System.out.println("[Migration] Migrated " + rows + " account row(s): SUSPENDED -> FROZEN.");
                    }
                }

                // Lock to the final clean ENUM (removes SUSPENDED)
                try (PreparedStatement ps = conn.prepareStatement(
                        "ALTER TABLE accounts MODIFY COLUMN status " +
                        "ENUM('PENDING','ACTIVE','FROZEN','CLOSED') DEFAULT 'PENDING'")) {
                    ps.executeUpdate();
                }

                System.out.println("[Migration] accounts.status ENUM updated to: PENDING, ACTIVE, FROZEN, CLOSED.");
            } else {
                System.out.println("[Migration] accounts.status ENUM is already correct. No changes needed.");
            }

        } catch (SQLException e) {
            System.err.println("[Migration] ERROR during account status migration: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
