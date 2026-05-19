package com.pharmacy.dao;

import com.pharmacy.model.Supplier;
import java.util.List;
import java.util.Optional;

public interface SupplierDAO {
    Optional<Supplier> findById(int id);
    List<Supplier> findAll();
    List<Supplier> findAllActive();
    void create(Supplier supplier);
    void update(Supplier supplier);
    void delete(int id);
}
