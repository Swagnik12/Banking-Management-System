package com.bank.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Fires once when the application deploys.
 * Runs all database migrations before any servlet handles a request.
 */
@WebListener
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("[Startup] Running database migrations...");
        DatabaseMigrationUtil.migrateAccountStatuses();
        System.out.println("[Startup] Database migrations complete.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // nothing to clean up
    }
}
