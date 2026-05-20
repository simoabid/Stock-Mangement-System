package com.pharmacy.dao;

import com.pharmacy.model.StockEntry;
import com.pharmacy.util.DBConnection;
import com.pharmacy.exception.DatabaseException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StockEntryDAOImpl implements StockEntryDAO {

    @Override
    public List<StockEntry> findAll(int page, int pageSize) {
        List<StockEntry> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT se.*, p.name AS product_name, s.name AS supplier_name, u.fullname AS user_name " +
                     "FROM stock_entries se " +
                     "JOIN products p ON se.product_id = p.id " +
                     "LEFT JOIN suppliers s ON se.supplier_id = s.id " +
                     "JOIN users u ON se.user_id = u.id " +
                     "ORDER BY se.created_at DESC LIMIT ? OFFSET ?";
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
            throw new DatabaseException("Failed to find all stock entries", e);
        }
        return list;
    }

    @Override
    public List<StockEntry> findByProductId(int productId) {
        List<StockEntry> list = new ArrayList<>();
        String sql = "SELECT se.*, p.name AS product_name, s.name AS supplier_name, u.fullname AS user_name " +
                     "FROM stock_entries se " +
                     "JOIN products p ON se.product_id = p.id " +
                     "LEFT JOIN suppliers s ON se.supplier_id = s.id " +
                     "JOIN users u ON se.user_id = u.id " +
                     "WHERE se.product_id = ? ORDER BY se.entry_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            throw new DatabaseException("Failed to find stock entries by product id: " + productId, e);
        }
        return list;
    }

    @Override
    public List<StockEntry> findRecent(int limit) {
        List<StockEntry> list = new ArrayList<>();
        String sql = "SELECT se.*, p.name AS product_name, s.name AS supplier_name, u.fullname AS user_name " +
                     "FROM stock_entries se " +
                     "JOIN products p ON se.product_id = p.id " +
                     "LEFT JOIN suppliers s ON se.supplier_id = s.id " +
                     "JOIN users u ON se.user_id = u.id " +
                     "ORDER BY se.created_at DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            throw new DatabaseException("Failed to find recent stock entries", e);
        }
        return list;
    }

    @Override
    public List<StockEntry> findExpiringSoon(int withinDays) {
        List<StockEntry> list = new ArrayList<>();
        String sql = "SELECT se.*, p.name AS product_name, s.name AS supplier_name, u.fullname AS user_name " +
                     "FROM stock_entries se " +
                     "JOIN products p ON se.product_id = p.id " +
                     "LEFT JOIN suppliers s ON se.supplier_id = s.id " +
                     "JOIN users u ON se.user_id = u.id " +
                     "WHERE se.expiry_date IS NOT NULL AND se.expiry_date > CURDATE() AND se.expiry_date <= DATE_ADD(CURDATE(), INTERVAL ? DAY) " +
                     "ORDER BY se.expiry_date ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, withinDays);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            throw new DatabaseException("Failed to find expiring stock entries", e);
        }
        return list;
    }

    @Override
    public List<StockEntry> findExpired() {
        List<StockEntry> list = new ArrayList<>();
        String sql = "SELECT se.*, p.name AS product_name, s.name AS supplier_name, u.fullname AS user_name " +
                     "FROM stock_entries se " +
                     "JOIN products p ON se.product_id = p.id " +
                     "LEFT JOIN suppliers s ON se.supplier_id = s.id " +
                     "JOIN users u ON se.user_id = u.id " +
                     "WHERE se.expiry_date IS NOT NULL AND se.expiry_date <= CURDATE() " +
                     "ORDER BY se.expiry_date ASC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            throw new DatabaseException("Failed to find expired stock entries", e);
        }
        return list;
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM stock_entries";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw new DatabaseException("Failed to count all stock entries", e);
        }
        return 0;
    }

    @Override
    public void create(StockEntry entry) {
        try (Connection conn = DBConnection.getConnection()) {
            create(entry, conn);
        } catch (SQLException e) {
            throw new DatabaseException("Failed to create stock entry for product: " + entry.getProductId(), e);
        }
    }

    @Override
    public void create(StockEntry entry, Connection conn) throws SQLException {
        String sql = "INSERT INTO stock_entries (product_id, supplier_id, quantity, purchase_price, selling_price, batch_number, expiry_date, entry_date, user_id, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, entry.getProductId());
            if (entry.getSupplierId() > 0) {
                stmt.setInt(2, entry.getSupplierId());
            } else {
                stmt.setNull(2, Types.INTEGER);
            }
            stmt.setInt(3, entry.getQuantity());
            stmt.setBigDecimal(4, entry.getPurchasePrice());
            stmt.setBigDecimal(5, entry.getSellingPrice());
            stmt.setString(6, entry.getBatchNumber());
            stmt.setDate(7, entry.getExpiryDate());
            stmt.setDate(8, entry.getEntryDate());
            stmt.setInt(9, entry.getUserId());
            stmt.setString(10, entry.getNotes());
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) entry.setId(keys.getInt(1));
                }
            }
        }
    }

    private StockEntry mapRow(ResultSet rs) throws SQLException {
        StockEntry e = new StockEntry();
        e.setId(rs.getInt("id"));
        e.setProductId(rs.getInt("product_id"));
        e.setSupplierId(rs.getInt("supplier_id"));
        e.setQuantity(rs.getInt("quantity"));
        e.setPurchasePrice(rs.getBigDecimal("purchase_price"));
        e.setSellingPrice(rs.getBigDecimal("selling_price"));
        e.setBatchNumber(rs.getString("batch_number"));
        e.setExpiryDate(rs.getDate("expiry_date"));
        e.setEntryDate(rs.getDate("entry_date"));
        e.setUserId(rs.getInt("user_id"));
        e.setNotes(rs.getString("notes"));
        e.setCreatedAt(rs.getTimestamp("created_at"));
        try {
            e.setProductName(rs.getString("product_name"));
            e.setSupplierName(rs.getString("supplier_name"));
            e.setUserName(rs.getString("user_name"));
        } catch (SQLException ignored) {}
        return e;
    }
}
