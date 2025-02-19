# 💸 ExChangePay: Money Transfer Application

## 📌 Overview
The **ExChangePay** is a secure, fast, and user-friendly platform for sending and receiving money. It supports **wallet transactions, bank transfers, QR payments, and international transfers** with robust security measures.

## 🚀 Features
- **User Authentication**: Secure login, multi-factor authentication (MFA), and profile management.
- **Money Transfers**: Instant transfers, scheduled payments, and cross-border transactions.
- **Bank Integration**: Link bank accounts, check balances, and transfer funds.
- **Wallet System**: Add, withdraw, and transfer money within the app ecosystem.
- **Transaction History**: View detailed transaction logs and request refunds.
- **Security & Privacy**: Transaction limits.
- **Cashback & Offers**: Exclusive rewards for users.

## 🏗️ Tech Stack
- **Backend**: Java (Spring Boot), MySQL
- **Frontend**: React Native (for mobile), React.js (for web)
- **Database**: MySQL (Relational Database Management System)
- **Authentication**: Keycloak
- **API Documentation**: Swagger / Postman Collection

## 🔧 Installation
```sh
# Clone the repository
git clone https://github.com/yourusername/ExChangePay.git
cd ExChangePay

# Backend setup (Spring Boot)
cd backend
mvn clean install
mvn spring-boot:run

# Frontend setup (React.js)
cd frontend
npm install
npm start
```

## 🛠️ Environment Variables
Create a `.env` file in the backend root directory and configure the following:
```env
DB_URL=jdbc:mysql://localhost:3306/money_transfer
DB_USER=root
DB_PASSWORD=yourpassword
JWT_SECRET=your_secret_key
```