package com.pharmacy.model;

import java.sql.Date;
import java.sql.Timestamp;

public class StockExit {
    private int id;
    private int productId;
    private int quantity;
    private ExitType exitType;
    private Date exitDate;
    private int userId;
    private String notes;
    private Timestamp createdAt;

    // Derived / joined fields
    private String productName;
    private String userName;

    public enum ExitType {
        SALE, RETURN_TO_SUPPLIER, EXPIRED_DISPOSAL, DAMAGED, INTERNAL_USE
    }

    public StockExit() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public ExitType getExitType() { return exitType; }
    public void setExitType(ExitType exitType) { this.exitType = exitType; }
    public void setExitType(String typeStr) {
        try {
            this.exitType = ExitType.valueOf(typeStr.toUpperCase());
        } catch (Exception e) {
            this.exitType = ExitType.SALE;
        }
    }

    public Date getExitDate() { return exitDate; }
    public void setExitDate(Date exitDate) { this.exitDate = exitDate; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
}
