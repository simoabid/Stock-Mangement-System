package com.pharmacy.dao;

import com.pharmacy.model.StockExit;
import com.pharmacy.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StockExitDAOImpl implements StockExitDAO {

    @Override
    public List<StockExit> findAll(int page, int pageSize) {
        List<StockExit> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT sx.*, p.name AS product_name, u.fullname AS user_name " +
                     "FROM stock_exits sx " +
                     "JOIN products p ON sx.product_id = p.id " +
                     "JOIN users u ON sx.user_id = u.id " +
                     "ORDER BY sx.created_at DESC LIMIT ? OFFSET ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, pageSize);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<StockExit> findByProductId(int productId) {
        List<StockExit> list = new ArrayList<>();
        String sql = "SELECT sx.*, p.name AS product_name, u.fullname AS user_name " +
                     "FROM stock_exits sx " +
                     "JOIN products p ON sx.product_id = p.id " +
                     "JOIN users u ON sx.user_id = u.id " +
                     "WHERE sx.product_id = ? ORDER BY sx.exit_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<StockExit> findRecent(int limit) {
        List<StockExit> list = new ArrayList<>();
        String sql = "SELECT sx.*, p.name AS product_name, u.fullname AS user_name " +
                     "FROM stock_exits sx " +
                     "JOIN products p ON sx.product_id = p.id " +
                     "JOIN users u ON sx.user_id = u.id " +
                     "ORDER BY sx.created_at DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM stock_exits";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public void create(StockExit exit) {
        String sql = "INSERT INTO stock_exits (product_id, quantity, exit_type, exit_date, user_id, notes) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, exit.getProductId());
            stmt.setInt(2, exit.getQuantity());
            stmt.setString(3, exit.getExitType().name());
            stmt.setDate(4, exit.getExitDate());
            stmt.setInt(5, exit.getUserId());
            stmt.setString(6, exit.getNotes());
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) exit.setId(keys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private StockExit mapRow(ResultSet rs) throws SQLException {
        StockExit sx = new StockExit();
        sx.setId(rs.getInt("id"));
        sx.setProductId(rs.getInt("product_id"));
        sx.setQuantity(rs.getInt("quantity"));
        sx.setExitType(rs.getString("exit_type"));
        sx.setExitDate(rs.getDate("exit_date"));
        sx.setUserId(rs.getInt("user_id"));
        sx.setNotes(rs.getString("notes"));
        sx.setCreatedAt(rs.getTimestamp("created_at"));
        try {
            sx.setProductName(rs.getString("product_name"));
            sx.setUserName(rs.getString("user_name"));
        } catch (SQLException ignored) {}
        return sx;
    }
}
