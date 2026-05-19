# PharmStock — Pharmacy Stock Management System

A Jakarta EE (Servlet/JSP) based Pharmacy Stock Management System following MVC architecture.

## Features

- **MVC Architecture**: Clear separation of `Controller` (Servlets), `Model` (JavaBeans), and `View` (JSP).
- **Authentication**: Role-based access (Admin / Pharmacist / Technician) with strict filters.
- **Dashboard**: Real-time overview with low-stock alerts, expiry alerts, and recent activity.
- **Product Management**: Full CRUD with search by name, generic name, or barcode, category filtering, and pagination.
- **Stock Entries**: Record incoming shipments with supplier, batch number, pricing, and expiry date.
- **Stock Exits**: Record sales, returns, disposals, and internal use with stock validation.
- **Supplier Management**: Manage suppliers with contact details and active/inactive status.
- **Category Management**: Organize products into categories (Medicine, Medical Device, etc.).
- **User Management**: Admin can enable/disable user accounts.
- **Multi-language**: Supports English, French, and Arabic.
- **Dark Mode**: Theme toggle with localStorage persistence.

## Quick Start (Docker)

The fastest way to run the application:

```sh
docker compose up --build -d
```

This starts MySQL 8.0 and Tomcat 10.1 containers. Access the app at:
**http://localhost:8080/pharmacy/login**

## Manual Setup

### 1. Database
1. Ensure MySQL 8.0+ is installed and running.
2. Create the database:
   ```sql
   CREATE DATABASE pharmacy_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```
3. Run the schema script:
   ```sh
   mysql -u root -p pharmacy_db < src/main/resources/schema.sql
   ```

### 2. Build via Maven
```sh
mvn clean package -DskipTests
```
This generates `pharmacy.war` in the `target/` directory.

### 3. Deploy
1. Copy `target/pharmacy.war` to your Tomcat `webapps/` folder.
2. Start Tomcat.
3. Access at `http://localhost:8080/pharmacy`.

### 4. Default Credentials
| Role | Username | Password |
| :--- | :--- | :--- |
| **Admin** | `admin` | `password` |
| **Pharmacist** | `pharmacist` | `password` |
| **Technician** | `technician` | `password` |

Self-registered accounts default to the **Technician** role.

## Architecture

```
src/main/java/com/pharmacy/
├── controller/         # Servlets (AuthServlet, DashboardServlet, ProductServlet)
│   └── admin/          # Admin servlets (Products, Suppliers, Categories, Stock, Users)
├── dao/                # Data Access Objects (interfaces + implementations)
├── filter/             # AuthenticationFilter (role-based access control)
├── listener/           # AppContextListener (DB lifecycle)
├── model/              # Domain models (User, Product, Category, Supplier, StockEntry, StockExit)
└── util/               # Utilities (DBConnection, PasswordUtil, FileUploadUtil)

src/main/webapp/
├── assets/css/         # PharmStock design system (teal theme, dark mode)
├── assets/js/          # Theme toggle
└── WEB-INF/views/      # JSP views (dashboard, products, admin CRUD forms)
```

## Tech Stack
- **Backend**: Java 11, Jakarta EE (Servlet 6.0), JSP, JSTL
- **Database**: MySQL 8.0, HikariCP connection pool
- **Security**: BCrypt password hashing
- **Build**: Maven 3.9+
- **Runtime**: Apache Tomcat 10.1
- **Deployment**: Docker & Docker Compose
