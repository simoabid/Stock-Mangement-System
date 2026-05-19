# 🤝 Contributing to PharmStock

Thank you for your interest in contributing! This guide will walk you through the full development setup and contribution workflow.

---

## 📋 Table of Contents

- [Prerequisites](#-prerequisites)
- [Development Setup](#-development-setup)
- [Project Architecture](#-project-architecture)
- [Making Changes](#-making-changes)
- [Coding Guidelines](#-coding-guidelines)
- [Submitting a Pull Request](#-submitting-a-pull-request)
- [Common Development Tasks](#-common-development-tasks)
- [Need Help?](#-need-help)

---

## 🧰 Prerequisites

To develop on this project, you need the following installed:

| Tool | Version | What it's for | Download |
|------|---------|---------------|----------|
| **Git** | Any | Version control | [git-scm.com](https://git-scm.com/downloads) |
| **JDK** | 11+ | Compiling Java code | [Adoptium](https://adoptium.net/) |
| **Maven** | 3.6+ | Building the project & managing dependencies | [maven.apache.org](https://maven.apache.org/download.cgi) |
| **Docker** | Any | Running the app + database containers | [docker.com](https://www.docker.com/products/docker-desktop) |
| **IDE** | Any | Code editor | [IntelliJ IDEA](https://www.jetbrains.com/idea/download/) (recommended) or [VS Code](https://code.visualstudio.com/) |

### Verify your setup

Open a terminal and run each of these:

```bash
git --version       # Should print: git version 2.x.x
java -version       # Should print: openjdk version "11.x.x" (or higher)
mvn -version        # Should print: Apache Maven 3.x.x
docker --version    # Should print: Docker version 2x.x.x
```

> ✅ If all four commands print version numbers, you're ready!

---

## 🏗️ Development Setup

### 1. Fork & Clone

```bash
# Fork the repo on GitHub first (click the "Fork" button), then:
git clone https://github.com/<your-username>/Stock-Mangement-System.git
cd Stock-Mangement-System
```

### 2. Set Up Environment Variables

```bash
# Copy the template
cp .env.example .env

# Edit .env and set your MySQL password
# Example:
#   MYSQL_ROOT_PASSWORD=mydevpassword123
```

### 3. Start the Database

You need MySQL running. The easiest way is using Docker for just the database:

```bash
# Start only the MySQL container
docker compose up db -d
```

This starts MySQL on port `3306` with the database and sample data loaded automatically.

### 4. Build the Project

```bash
mvn clean package -DskipTests
```

This compiles the code and creates `target/pharmacy.war`.

### 5. Run with Docker (Full Stack)

The simplest way to see your changes:

```bash
docker compose up --build -d
```

Then open: **http://localhost:8080/pharmacy**

### 6. (Alternative) Run with Local Tomcat

If you prefer running Tomcat locally instead of Docker:

1. Download [Tomcat 10.1](https://tomcat.apache.org/download-10.cgi)
2. Copy `target/pharmacy.war` to Tomcat's `webapps/` folder
3. Set environment variables before starting Tomcat:
   ```bash
   export JDBC_URL="jdbc:mysql://localhost:3306/pharmacy_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true"
   export JDBC_USER="root"
   export JDBC_PASSWORD="your_password"
   export JDBC_DRIVER="com.mysql.cj.jdbc.Driver"
   ```
4. Start Tomcat: `./bin/startup.sh` (Linux/Mac) or `bin\startup.bat` (Windows)

---

## 🏛️ Project Architecture

This project follows the **MVC (Model-View-Controller)** pattern:

```
src/main/java/com/pharmacy/
│
├── model/          ← 📦 Data classes (Product, User, StockEntry, etc.)
│                      Plain Java beans with getters/setters
│
├── dao/            ← 🗄️ Data Access Objects (database queries)
│                      Interface + Implementation pattern
│                      Example: ProductDAO (interface) → ProductDAOImpl (SQL logic)
│
├── controller/     ← 🎮 Servlets (handle HTTP GET/POST requests)
│   └── admin/         Admin-only servlets (products, stock, users)
│
├── filter/         ← 🔒 Security (AuthenticationFilter checks every request)
│
├── listener/       ← 🚀 App lifecycle (database init on startup)
│
└── util/           ← 🔧 Utilities
    ├── DBConnection.java    ← HikariCP connection pool
    ├── PasswordUtil.java    ← BCrypt hashing
    └── FileUploadUtil.java  ← Image upload helper
```

### Request Flow

```
Browser → Servlet (Controller) → DAO → MySQL Database
                ↓
         JSP View (Response)
```

### Key Files to Know

| File | Purpose |
|------|---------|
| `src/main/resources/schema.sql` | Database tables + seed data. **Edit this if you change any model fields.** |
| `src/main/webapp/WEB-INF/web.xml` | Servlet configuration, welcome files |
| `src/main/webapp/assets/css/style.css` | All CSS styles (teal theme, dark mode, layouts) |
| `src/main/resources/messages*.properties` | Translation strings (EN, FR, AR) |
| `pom.xml` | Maven dependencies |

---

## ✏️ Making Changes

### Step 1: Create a Branch

Always work on a new branch, never directly on `main`:

```bash
git checkout -b feature/your-feature-name
# Examples:
#   git checkout -b feature/add-batch-tracking
#   git checkout -b fix/login-redirect-bug
#   git checkout -b docs/update-api-docs
```

### Step 2: Make Your Changes

Edit the code. Here are some common scenarios:

#### Adding a New Page
1. Create the servlet in `src/main/java/com/pharmacy/controller/`
2. Create the JSP view in `src/main/webapp/WEB-INF/views/`
3. Add navigation link in `header.jsp`
4. Add translations in all 3 `messages*.properties` files

#### Adding a New Database Field
1. Update the SQL in `schema.sql` (ALTER TABLE or modify CREATE TABLE)
2. Update the Java model class in `model/`
3. Update the DAO implementation in `dao/`
4. Update the JSP views to display/edit the new field

#### Adding a New DAO Method
1. Add the method signature to the DAO interface (e.g., `ProductDAO.java`)
2. Implement it in the DAO implementation (e.g., `ProductDAOImpl.java`)
3. Always use `PreparedStatement` — never concatenate SQL strings!

### Step 3: Test Your Changes

Rebuild and restart:

```bash
# Rebuild the WAR
mvn clean package -DskipTests

# Restart containers with new code
docker compose up --build -d

# Check logs for errors
docker logs pharmacy-app
```

### Step 4: Commit

```bash
git add -A
git commit -m "feat: description of what you changed"
```

---

## 📐 Coding Guidelines

### Java Code

- **Package**: All code goes under `com.pharmacy.*`
- **Naming**: Use `PascalCase` for classes, `camelCase` for methods/variables
- **DAO Pattern**: Always create an interface + implementation pair
- **SQL Safety**: Always use `PreparedStatement` with `?` placeholders — **never** concatenate user input into SQL
- **Passwords**: Always hash with `PasswordUtil.hashPassword()` — **never** store plain text

```java
// ✅ GOOD — Safe from SQL injection
PreparedStatement stmt = conn.prepareStatement("SELECT * FROM products WHERE id = ?");
stmt.setInt(1, productId);

// ❌ BAD — SQL injection vulnerability!
Statement stmt = conn.createStatement();
stmt.executeQuery("SELECT * FROM products WHERE id = " + productId);
```

### JSP Views

- Use **JSTL tags** (`<c:forEach>`, `<c:if>`) — never use Java scriptlets (`<% %>`)
- Use **i18n** for all user-facing text: `<fmt:message key="label.name"/>`
- Include `header.jsp` and `footer.jsp` in every page
- Add both English and French (and Arabic if possible) translations for any new text

### CSS

- Follow the existing design system in `style.css`
- Use the CSS variables defined at the top (e.g., `var(--primary)`, `var(--bg)`)
- Support dark mode — use the `[data-theme="dark"]` selector
- Keep it responsive — test on mobile widths too

### Commit Messages

Use conventional commit format:

```
feat: add batch number tracking to stock entries
fix: prevent negative stock on concurrent exits
docs: add API endpoint documentation
style: improve dashboard card spacing on mobile
refactor: extract common DAO methods to base class
```

---

## 🚀 Submitting a Pull Request

### 1. Push Your Branch

```bash
git push origin feature/your-feature-name
```

### 2. Open a Pull Request

- Go to [the repository](https://github.com/simoabid/Stock-Mangement-System) on GitHub
- Click **"Compare & pull request"**
- Fill in the template:
  - **Title**: Short description (e.g., "Add batch number tracking")
  - **Description**: Explain what you changed and why
  - **Screenshots**: If you changed the UI, include before/after screenshots

### 3. PR Checklist

Before submitting, make sure:

- [ ] Code compiles: `mvn clean package -DskipTests` succeeds
- [ ] App starts: `docker compose up --build -d` runs without errors
- [ ] No hardcoded credentials in the code
- [ ] New translations added for any new user-facing text
- [ ] Dark mode still works if you changed CSS
- [ ] Commit messages follow the conventional format

---

## 🔨 Common Development Tasks

### Reset the Database

If you messed up the data and want to start fresh:

```bash
docker compose down -v          # Delete containers + database volume
docker compose up --build -d    # Rebuild everything from scratch
```

### View Database Directly

Connect to MySQL inside Docker:

```bash
docker exec -it pharmacy-mysql mysql -u root -p pharmacy_db
# Enter the password from your .env file

# Then run SQL:
mysql> SELECT * FROM products LIMIT 5;
mysql> SHOW TABLES;
```

### Check App Logs

```bash
# Live logs (follow mode — press Ctrl+C to stop)
docker logs -f pharmacy-app

# Last 50 lines only
docker logs --tail 50 pharmacy-app
```

### Quick Rebuild Cycle

After making code changes, the fastest way to see them:

```bash
mvn clean package -DskipTests && docker compose up --build -d
```

---

## 📂 Files You Should NOT Edit

| File/Folder | Why |
|-------------|-----|
| `.env` | Contains your local secrets — gitignored |
| `target/` | Auto-generated build output — gitignored |
| `.idea/` / `.vscode/` | IDE-specific settings — gitignored |

---

## ❓ Need Help?

- **Stuck on setup?** Open a [GitHub Issue](https://github.com/simoabid/Stock-Mangement-System/issues) with the label `help wanted`
- **Found a bug?** Open an issue with the label `bug` and include:
  - Steps to reproduce
  - What you expected to happen
  - What actually happened
  - Screenshots if applicable
- **Have a feature idea?** Open an issue with the label `enhancement`

---

<p align="center">
  <b>Thank you for contributing! Every improvement matters. 🎉</b>
</p>
