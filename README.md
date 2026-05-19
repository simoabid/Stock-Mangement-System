<p align="center">
  <img src="https://img.shields.io/badge/Java-11-orange?logo=openjdk" alt="Java 11">
  <img src="https://img.shields.io/badge/Jakarta_EE-10-blue?logo=eclipse" alt="Jakarta EE">
  <img src="https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql&logoColor=white" alt="MySQL">
  <img src="https://img.shields.io/badge/Tomcat-10.1-yellow?logo=apache-tomcat" alt="Tomcat">
  <img src="https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white" alt="Docker">
</p>

# 💊 PharmStock — Pharmacy Stock Management System

A complete web application for managing pharmaceutical inventory — track medicines, medical devices, suppliers, stock movements, and expiry dates.

Built with **Java (Jakarta EE)**, **JSP/JSTL**, **MySQL**, and deployed via **Docker**.

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 📊 **Dashboard** | Real-time stats: total products, low-stock alerts, expiry warnings, recent activity |
| 💊 **Product Catalog** | Browse, search, and filter products by name, category, or barcode |
| 📦 **Stock Entries** | Record incoming shipments with supplier, batch number, expiry date, and pricing |
| 📤 **Stock Exits** | Record sales, returns, disposals — with automatic stock validation |
| 🏢 **Suppliers** | Manage supplier contacts and status |
| 🏷️ **Categories** | Organize products (Medicine, Medical Device, Supplement, etc.) |
| 👥 **User Management** | Admin can activate/deactivate user accounts |
| 🔒 **Role-Based Access** | 3 roles: Admin, Pharmacist, Technician — each with different permissions |
| 🌙 **Dark Mode** | Toggle between light and dark themes (saved in browser) |
| 🌍 **Multi-Language** | English, French, and Arabic (with RTL layout support) |

---

## 🚀 How to Run This Project

### What You Need

Just **two things** installed on your computer:

1. **Git** — to download the code ([Download Git](https://git-scm.com/downloads))
2. **Docker Desktop** — to run the app ([Download Docker](https://www.docker.com/products/docker-desktop))

> **That's it!** You do NOT need to install Java, Maven, MySQL, or Tomcat. Docker handles all of that automatically.

---

### Step 1: Download the Project

Open a terminal (Command Prompt on Windows, Terminal on Mac/Linux) and run:

```bash
git clone https://github.com/simoabid/Stock-Mangement-System.git
```

Then go inside the project folder:

```bash
cd Stock-Mangement-System
```

---

### Step 2: Set Up Your Password

The project needs a database password. We use a `.env` file to keep it secret.

**Copy the example file:**

```bash
# On Linux / Mac:
cp .env.example .env

# On Windows (Command Prompt):
copy .env.example .env
```

**Now open `.env` in any text editor** and change the password:

```env
MYSQL_ROOT_PASSWORD=your_secure_password_here
MYSQL_DATABASE=pharmacy_db
JDBC_USER=root
JDBC_DRIVER=com.mysql.cj.jdbc.Driver
```

> ⚠️ Replace `changeme` with any password you want. This password is only used locally inside Docker — it's never exposed online.

---

### Step 3: Start the Application

Run this single command:

```bash
docker compose up --build -d
```

**What this does:**
- Downloads Java 11, Maven, Tomcat 10.1, and MySQL 8.0 automatically
- Compiles the entire project
- Creates the database and loads sample data
- Starts the web server

**First time will take 2-5 minutes** (downloading images). After that, starts in seconds.

---

### Step 4: Open the App

Wait about 30 seconds after Step 3, then open your browser and go to:

### 👉 [http://localhost:8080/pharmacy](http://localhost:8080/pharmacy)

You'll see the login page. Use one of these accounts:

| Role | Username | Password | What they can do |
|------|----------|----------|-----------------|
| 🔴 **Admin** | `admin` | `password` | Everything — full access |
| 🟡 **Pharmacist** | `pharmacist` | `password` | Manage stock entries/exits, view products |
| 🟢 **Technician** | `technician` | `password` | View dashboard and products (read-only) |

---

### Step 5: Stop the Application

When you're done, stop everything with:

```bash
docker compose down
```

To start it again later (without rebuilding):

```bash
docker compose up -d
```

---

## 🔧 Common Commands

| What you want to do | Command |
|---------------------|---------|
| Start the app | `docker compose up -d` |
| Start + rebuild after code changes | `docker compose up --build -d` |
| Stop the app | `docker compose down` |
| Stop + delete all data | `docker compose down -v` |
| See app logs (if something is wrong) | `docker logs pharmacy-app` |
| See database logs | `docker logs pharmacy-mysql` |
| Check if containers are running | `docker ps` |

---

## 🛠️ Troubleshooting

### "Page not loading" or "Connection refused"
- Wait 30-60 seconds after `docker compose up`. The database needs time to initialize.
- Check if containers are running: `docker ps` — you should see both `pharmacy-app` and `pharmacy-mysql`.
- Check logs: `docker logs pharmacy-app`

### "Port 8080 already in use"
Another app is using port 8080. Either:
- Stop that app, OR
- Change the port in `docker-compose.yml`: change `"8080:8080"` to `"9090:8080"`, then access at `http://localhost:9090/pharmacy`

### "Port 3306 already in use"
You have a local MySQL running. Either:
- Stop your local MySQL, OR
- Change the port in `docker-compose.yml`: change `"3306:3306"` to `"3307:3306"`

### "I want to start fresh"
Reset everything (database + data):
```bash
docker compose down -v
docker compose up --build -d
```

---

## 📁 Project Structure

```
Stock-Mangement-System/
│
├── 📄 docker-compose.yml      ← Orchestrates the app + database containers
├── 📄 Dockerfile               ← Builds the Java app image
├── 📄 pom.xml                  ← Maven config (Java dependencies)
├── 📄 .env.example             ← Template for your database password
│
├── 📂 src/main/java/com/pharmacy/
│   ├── 📂 controller/          ← Servlets (handle HTTP requests)
│   │   └── 📂 admin/           ← Admin-only endpoints
│   ├── 📂 dao/                 ← Database access (SQL queries)
│   ├── 📂 model/               ← Data models (Product, User, etc.)
│   ├── 📂 filter/              ← Security filter (blocks unauthorized access)
│   ├── 📂 listener/            ← App startup/shutdown hooks
│   └── 📂 util/                ← Helpers (DB connection, password hashing)
│
├── 📂 src/main/resources/
│   ├── 📄 schema.sql           ← Database tables + sample data
│   ├── 📄 messages.properties  ← French translations
│   ├── 📄 messages_en.properties ← English translations
│   └── 📄 messages_ar.properties ← Arabic translations
│
├── 📂 src/main/webapp/
│   ├── 📂 assets/css/          ← Stylesheets (teal theme + dark mode)
│   ├── 📂 assets/js/           ← Theme toggle script
│   └── 📂 WEB-INF/views/       ← JSP pages (what users see)
│       ├── 📄 dashboard.jsp
│       ├── 📄 products.jsp
│       ├── 📄 login.jsp
│       └── 📂 admin/           ← Admin management pages
│
└── 📂 docs/
    └── 📄 report.tex           ← Academic report (LaTeX)
```

---

## 🔐 Security Notes

- **Passwords** are hashed using BCrypt — never stored in plain text
- **SQL Injection** is prevented using PreparedStatements everywhere
- **Access Control** is enforced via a servlet filter — no URL bypassing
- **Database credentials** are stored in `.env` (gitignored — never pushed to GitHub)

---

## 🏗️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Language** | Java 11 |
| **Web Framework** | Jakarta EE (Servlet 6.0 + JSP) |
| **Template Engine** | JSP + JSTL |
| **Database** | MySQL 8.0 |
| **Connection Pool** | HikariCP |
| **Password Hashing** | BCrypt (jBCrypt) |
| **Build Tool** | Apache Maven |
| **Web Server** | Apache Tomcat 10.1 |
| **Containerization** | Docker + Docker Compose |

---

## 📝 License

This project was built as an academic project for the **Software Engineering & Networks (ILR)** program.

---

<p align="center">
  <b>Made with ❤️ by the PharmStock Team</b>
</p>
