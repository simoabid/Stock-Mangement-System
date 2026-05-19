package com.pharmacy.dao;

import com.pharmacy.model.Category;
import java.util.List;
import java.util.Optional;

public interface CategoryDAO {
    Optional<Category> findById(int id);
    List<Category> findAll();
    void create(Category category);
    void update(Category category);
    void delete(int id);
}
