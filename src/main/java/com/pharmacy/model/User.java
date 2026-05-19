package com.pharmacy.model;

import java.sql.Timestamp;

public class User {
    private int id;
    private String username;
    private String passwordHash;
    private String fullname;
    private String email;
    private Role role;
    private boolean active;
    private Timestamp createdAt;

    public enum Role {
        TECHNICIAN, PHARMACIST, ADMIN
    }

    public User() {}

    public User(String username, String passwordHash, String fullname, String email, Role role) {
        this.username = username;
        this.passwordHash = passwordHash;
        this.fullname = fullname;
        this.email = email;
        this.role = role;
        this.active = true;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
    public void setRole(String roleStr) {
        try {
            this.role = Role.valueOf(roleStr.toUpperCase());
        } catch (Exception e) {
            this.role = Role.TECHNICIAN;
        }
    }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
