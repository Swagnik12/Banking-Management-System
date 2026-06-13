# 🏦 Banking Management System

A full-stack Banking Management System developed using Java Servlets, JSP, JDBC, MySQL, Maven, and Apache Tomcat.

## 📌 Features

### Customer Features
- User Registration
- Secure Login & Logout
- Profile Management
- Deposit Money
- Withdraw Money
- Transfer Funds
- Transaction History

### Admin Features
- Admin Dashboard
- User Approval & Management
- Account Approval & Management
- Transaction Monitoring

## 🛠️ Tech Stack

### Backend
- Java 21
- Servlets
- JSP
- JDBC

### Database
- MySQL

### Build Tool
- Maven

### Server
- Apache Tomcat 11

## 📂 Project Structure

```
src/main/java
├── com.bank.dao
├── com.bank.model
├── com.bank.service
├── com.bank.servlet
├── com.bank.filter
└── com.bank.util

src/main/resources
└── db.properties

src/main/webapp
├── jsp
└── WEB-INF
```

## 🗄️ Database Setup

1. Open MySQL Workbench
2. Execute `database.sql`
3. Database `banking_db` will be created automatically

Default Admin Credentials:

```
Email: admin@bank.com
Password: admin123
```

## 🚀 Running the Project

### Clone Repository

```bash
git clone https://github.com/Swagnik12/Banking-Management-System.git
```

### Configure Database

Update:

```properties
src/main/resources/db.properties
```

```properties
db.url=jdbc:mysql://localhost:3306/banking_db
db.username=root
db.password=your_password
```

### Build

```bash
mvn clean package
```

### Deploy

Deploy the generated WAR file to Apache Tomcat.

### Access

```
http://localhost:8082/banking-management-system/
```

## 📸 Screenshots

- Login Page
- Admin Dashboard
- Customer Dashboard
- Transaction History

(Add screenshots later)

## 🔒 Security

- Session-Based Authentication
- Password Hashing (SHA-256)
- Role-Based Access Control
- JDBC Prepared Statements

## 👨‍💻 Author

Swagnik Shit

B.Tech Data Science

---

⭐ If you find this project useful, consider giving it a star.
