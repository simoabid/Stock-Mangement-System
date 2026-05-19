package com.pharmacy.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {
    private static HikariDataSource dataSource;

    static {
        try {
            HikariConfig config = new HikariConfig();
            // Allow overriding via System Properties (e.g., for Docker or Tests)
            String url = System.getProperty("jdbc.url");
            String user = System.getProperty("jdbc.user");
            String pass = System.getProperty("jdbc.password");
            String driver = System.getProperty("jdbc.driver");

            // Fallbacks for local dev — password MUST be provided via -Djdbc.password or env var
            if (url == null) url = System.getenv().getOrDefault("JDBC_URL", "jdbc:mysql://localhost:3306/pharmacy_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true");
            if (user == null) user = System.getenv().getOrDefault("JDBC_USER", "root");
            if (pass == null) pass = System.getenv().getOrDefault("JDBC_PASSWORD", "");
            if (driver == null) driver = System.getenv().getOrDefault("JDBC_DRIVER", "com.mysql.cj.jdbc.Driver");

            config.setJdbcUrl(url);
            config.setUsername(user);
            config.setPassword(pass);
            config.setDriverClassName(driver);

            // Optimization
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

            dataSource = new HikariDataSource(config);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize database connection pool", e);
        }
    }

    private DBConnection() {}

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    // For manual shutdown
    public static void close() {
        if (dataSource != null) {
            dataSource.close();
        }
    }
}
