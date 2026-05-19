package com.pharmacy.dao;

import com.pharmacy.model.StockEntry;
import java.util.List;

public interface StockEntryDAO {
    List<StockEntry> findAll(int page, int pageSize);
    List<StockEntry> findByProductId(int productId);
    List<StockEntry> findRecent(int limit);
    List<StockEntry> findExpiringSoon(int withinDays);
    List<StockEntry> findExpired();
    int countAll();
    void create(StockEntry entry);
}
