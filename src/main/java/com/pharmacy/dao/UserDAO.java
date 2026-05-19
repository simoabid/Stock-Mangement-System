package com.pharmacy.dao;

import com.pharmacy.model.User;
import java.util.List;
import java.util.Optional;

public interface UserDAO {
    Optional<User> findById(int id);
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    List<User> findAll(int page, int pageSize);
    int countAll();
    void create(User user);
    void update(User user);
    void delete(int id);
}
