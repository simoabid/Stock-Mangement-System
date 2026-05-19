package com.pharmacy.dao;

import com.pharmacy.model.Product;
import java.util.List;
import java.util.Optional;

public interface ProductDAO {
    Optional<Product> findById(int id);
    List<Product> findAll(int page, int pageSize);
    List<Product> search(String query, int categoryId, int page, int pageSize);
    int countAll();
    int countSearch(String query, int categoryId);
    List<Product> findLowStock();
    List<Product> findAll();
    void create(Product product);
    void update(Product product);
    void updateStock(int productId, int quantityChange);
    void delete(int id);
}
