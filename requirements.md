# System Requirements

To run this Pharmacy Stock Management System, your computer needs the following software installed.

## Option A: Docker (Recommended)
- **Docker Desktop** or **Docker Engine** with Docker Compose
- **Why**: Runs everything (app + database) in containers — no manual setup needed.
- **Download**: [Docker Desktop](https://www.docker.com/products/docker-desktop)
- **Check**: Run `docker --version` and `docker compose version` in your terminal.

That's it! With Docker, just run `docker compose up --build -d` and the system is ready.

---

## Option B: Manual Setup

### 1. Java Development Kit (JDK)
- **Version**: Java 11 or higher.
- **Why**: The code is written in Java.
- **Download**: [Adoptium Temurin](https://adoptium.net/) or Oracle JDK.
- **Check**: Run `java -version` in your terminal.

### 2. Apache Maven
- **Version**: 3.6.0 or higher.
- **Why**: Maven builds the project and downloads libraries automatically.
- **Download**: [Maven Website](https://maven.apache.org/download.cgi)
- **Check**: Run `mvn -version` in your terminal.

### 3. Apache Tomcat Server
- **Version**: 10.1 (Jakarta EE compatible).
- **Why**: This is the web server that runs the application (WAR file).
- **Download**: [Tomcat 10.1 Download](https://tomcat.apache.org/download-10.cgi)
- **Installation**: Unzip the folder somewhere accessible (e.g., `/opt/tomcat` or `C:\Tomcat`).

### 4. MySQL Database (Community Server)
- **Version**: 8.0 or higher.
- **Why**: Stores all the data (users, products, suppliers, stock movements).
- **Download**: [MySQL Installer](https://dev.mysql.com/downloads/installer/)
- **Setup**: During installation, remember the **root password** you set; you will need this for configuration.

### 5. Web Browser
- Google Chrome, Firefox, or Edge to access the application.

---

### Optional (Recommended)
- **Visual Studio Code** or **IntelliJ IDEA**: Code editors to view and modify the files easily.
- **MySQL Workbench**: A visual tool to view your database tables (usually installed with MySQL).

### Next Steps
Once you have these installed, follow the **Setup Instructions** in the `README.md` file to configure the database and run the app.
