package com.pharmacy.dao;

import com.pharmacy.model.StockExit;
import java.util.List;

public interface StockExitDAO {
    List<StockExit> findAll(int page, int pageSize);
    List<StockExit> findByProductId(int productId);
    List<StockExit> findRecent(int limit);
    int countAll();
    void create(StockExit exit);
    void create(StockExit exit, java.sql.Connection conn) throws java.sql.SQLException;
}
