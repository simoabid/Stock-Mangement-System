# UML Diagrams for Pharmacy Stock Management System

## Class Diagram
```mermaid
classDiagram
    direction TB

    class User {
        +int id
        +String username
        +String passwordHash
        +String fullname
        +String email
        +Role role
        +boolean active
    }

    class Product {
        +int id
        +String name
        +String genericName
        +int categoryId
        +String form
        +String dosage
        +String barcode
        +String unit
        +int minStockLevel
        +int currentStock
        +boolean requiresPrescription
        +boolean isLowStock()
    }

    class Category {
        +int id
        +String name
        +String description
    }

    class Supplier {
        +int id
        +String name
        +String contactPerson
        +String phone
        +String email
        +boolean active
    }

    class StockEntry {
        +int id
        +int productId
        +int supplierId
        +int quantity
        +BigDecimal purchasePrice
        +BigDecimal sellingPrice
        +String batchNumber
        +Date expiryDate
        +Date entryDate
        +int userId
    }

    class StockExit {
        +int id
        +int productId
        +int quantity
        +ExitType exitType
        +Date exitDate
        +int userId
    }

    %% DAO Interfaces
    class ProductDAO {
        +findById(id)
        +findAll(page, size)
        +search(query, categoryId)
        +findLowStock()
        +updateStock(id, qty)
    }

    class StockEntryDAO {
        +findAll(page, size)
        +findExpiringSoon(days)
        +findExpired()
        +create(StockEntry)
    }

    class StockExitDAO {
        +findAll(page, size)
        +create(StockExit)
    }

    %% Relationships
    Category "1" -- "*" Product : classifies
    Supplier "1" -- "*" StockEntry : supplies
    Product "1" -- "*" StockEntry : receives
    Product "1" -- "*" StockExit : dispenses
    User "1" -- "*" StockEntry : records
    User "1" -- "*" StockExit : records

    %% DAOs using Models
    ProductDAO ..> Product
    StockEntryDAO ..> StockEntry
    StockExitDAO ..> StockExit

    %% Controllers
    class AuthServlet
    class DashboardServlet
    class ProductServlet
    class AdminProductServlet
    class AdminStockEntryServlet
    class AdminStockExitServlet

    DashboardServlet --> ProductDAO
    DashboardServlet --> StockEntryDAO
    DashboardServlet --> StockExitDAO
    ProductServlet --> ProductDAO
    AdminProductServlet --> ProductDAO
    AdminStockEntryServlet --> StockEntryDAO
    AdminStockEntryServlet --> ProductDAO
    AdminStockExitServlet --> StockExitDAO
    AdminStockExitServlet --> ProductDAO
```

## Sequence Diagram: Recording Stock Entry
```mermaid
sequenceDiagram
    actor Pharmacist
    participant View (JSP)
    participant StockEntryServlet
    participant StockEntryDAO
    participant ProductDAO
    participant Database

    Pharmacist->>View: Fills stock entry form (product, qty, batch, expiry)
    View->>StockEntryServlet: POST /admin/stock-entries/create
    activate StockEntryServlet

    StockEntryServlet->>StockEntryDAO: create(StockEntry)
    activate StockEntryDAO
    StockEntryDAO->>Database: INSERT INTO stock_entries ...
    Database-->>StockEntryDAO: Success (ID: 42)
    StockEntryDAO-->>StockEntryServlet: Entry created
    deactivate StockEntryDAO

    StockEntryServlet->>ProductDAO: updateStock(productId, +quantity)
    activate ProductDAO
    ProductDAO->>Database: UPDATE products SET current_stock = current_stock + ?
    Database-->>ProductDAO: Success
    ProductDAO-->>StockEntryServlet: Stock updated
    deactivate ProductDAO

    StockEntryServlet-->>View: Redirect to /admin/stock-entries?msg=added
    deactivate StockEntryServlet
```

## Sequence Diagram: Recording Stock Exit (Sale)
```mermaid
sequenceDiagram
    actor Pharmacist
    participant View (JSP)
    participant StockExitServlet
    participant ProductDAO
    participant StockExitDAO
    participant Database

    Pharmacist->>View: Fills exit form (product, qty, type=SALE)
    View->>StockExitServlet: POST /admin/stock-exits/create
    activate StockExitServlet

    StockExitServlet->>ProductDAO: findById(productId)
    ProductDAO->>Database: SELECT * FROM products WHERE id = ?
    Database-->>ProductDAO: Product (currentStock: 50)
    ProductDAO-->>StockExitServlet: Product found

    alt Sufficient Stock (50 >= requested qty)
        StockExitServlet->>StockExitDAO: create(StockExit)
        StockExitDAO->>Database: INSERT INTO stock_exits ...
        StockExitDAO-->>StockExitServlet: Exit created

        StockExitServlet->>ProductDAO: updateStock(productId, -quantity)
        ProductDAO->>Database: UPDATE products SET current_stock = current_stock - ?
        ProductDAO-->>StockExitServlet: Stock decreased

        StockExitServlet-->>View: Redirect to /admin/stock-exits?msg=recorded
    else Insufficient Stock
        StockExitServlet-->>View: Forward to form with error "Insufficient stock!"
    end

    deactivate StockExitServlet
```

## Entity Relationship Diagram
```mermaid
erDiagram
    USERS {
        int id PK
        varchar username UK
        varchar password_hash
        varchar fullname
        varchar email UK
        varchar role
        boolean is_active
    }

    CATEGORIES {
        int id PK
        varchar name UK
        varchar description
    }

    SUPPLIERS {
        int id PK
        varchar name
        varchar contact_person
        varchar phone
        varchar email
        boolean is_active
    }

    PRODUCTS {
        int id PK
        varchar name
        varchar generic_name
        int category_id FK
        varchar form
        varchar dosage
        varchar barcode UK
        varchar unit
        int min_stock_level
        int current_stock
        boolean requires_prescription
    }

    STOCK_ENTRIES {
        int id PK
        int product_id FK
        int supplier_id FK
        int quantity
        decimal purchase_price
        decimal selling_price
        varchar batch_number
        date expiry_date
        date entry_date
        int user_id FK
    }

    STOCK_EXITS {
        int id PK
        int product_id FK
        int quantity
        varchar exit_type
        date exit_date
        int user_id FK
    }

    CATEGORIES ||--o{ PRODUCTS : "classifies"
    PRODUCTS ||--o{ STOCK_ENTRIES : "receives"
    PRODUCTS ||--o{ STOCK_EXITS : "dispenses"
    SUPPLIERS ||--o{ STOCK_ENTRIES : "supplies"
    USERS ||--o{ STOCK_ENTRIES : "records"
    USERS ||--o{ STOCK_EXITS : "records"
```
