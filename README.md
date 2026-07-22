# ShoeShop E-commerce Platform

## Project Overview

ShoeShop E-commerce Platform is a backend API for a modern shoe shopping system. It provides authentication, product catalog management, shopping cart operations, order processing, payment integration, product reviews, and admin dashboards for managing the platform.

**Purpose**

To build a secure, scalable, and maintainable e-commerce backend for shoes and fashion products, with support for user account management, catalog browsing, checkout flows, online payment, and administrative control.

**Main Objectives**

- To help customers discover products, manage their cart, place orders, and pay online.
- To provide secure authentication with JWT and Google login support.
- To support role-based access control for customers and administrators.
- To give administrators tools for managing products, categories, brands, users, and orders.
- To expose clean REST APIs that can be consumed by a separate frontend repository.

**Key Highlights**

- JWT-based authentication and authorization.
- Google login integration.
- Product catalog with categories, brands, variants, and images.
- Shopping cart, checkout, order history, and review workflows.
- VNPay payment integration.
- Email support for password reset and account-related flows.
- AI-powered product recommendation using the FP-Growth association rule mining algorithm based on users' purchase history.
- AI-based sentiment analysis for customer reviews using a trained Machine Learning model, enabling automatic review classification and top-rated product ranking.
- SpringDoc OpenAPI for API documentation.

## Features

### User Features

- Register, log in, and manage account information.
- Log in with Google.
- Recover a forgotten password and reset it securely.
- Browse shoes by product, category, or brand.
- Add products to the cart and update quantities.
- Place orders and pay with supported payment methods, including VNPay.
- View order history and order details.
- Write product reviews and view review history.

### Admin Features

- Manage users and access permissions.
- Manage products, product variants, and product images.
- Manage categories and brands.
- Review and process orders.
- Track payment and order status.
- Monitor platform data through admin endpoints and dashboards.

## Highlight Features

- **Secure Authentication**: Uses Spring Security and JWT for secure authentication and role-based authorization.
- **Google Login**: Supports user authentication through Google OAuth 2.0.
- **Product Management**: Manages products, variants, images, categories, and brands with a flexible data model.
- **Cart & Checkout**: Provides shopping cart management, checkout, order placement, and order history.
- **Online Payment**: Integrates VNPay for secure online payment processing.
- **Email Support**: Sends password reset emails and other account-related notifications.
- **AI Product Recommendation**: Recommends related products using the FP-Growth association rule mining algorithm based on customers' purchase history.
- **AI Sentiment Analysis**: Automatically classifies customer reviews (Positive, Neutral, Negative) using a Machine Learning model, enabling sentiment-aware review management and top-rated product recommendations.
- **API Documentation**: Generates interactive REST API documentation with SpringDoc OpenAPI.

## System Architecture

```mermaid
flowchart TB
    U[Users / Admins]
    FE[React Frontend]
    BE[Spring Boot Backend API]
    AI[FastAPI AI Service]
    DB[(MySQL)]
    PAY[VNPay]
    MAIL[SMTP Mail Service]
    GOOGLE[Google OAuth 2.0]

    REC[FP-Growth<br/>Recommendation Engine]
    SEN[TF-IDF + Linear SVM<br/>Sentiment Analysis]

    U --> FE
    FE -->|REST API| BE

    BE --> DB
    BE --> PAY
    BE --> MAIL
    BE --> GOOGLE

    BE --> AI
    AI --> REC
    AI --> SEN
    AI --> DB
```

## Technology Stack

| Category | Technologies |
|-----------|--------------|
| **Frontend** | React, TypeScript, Vite |
| **Backend** | Java 21, Spring Boot 4.0.5, Spring Web, Spring Security, Spring Data JPA, Spring Validation, Spring Mail |
| **AI Service** | Python, FastAPI |
| **Machine Learning** | Scikit-learn, TF-IDF, Linear SVM, FP-Growth (mlxtend), Pandas |
| **Database** | MySQL |
| **Authentication** | JWT, Google OAuth 2.0 |
| **Payment Gateway** | VNPay |
| **API Documentation** | SpringDoc OpenAPI |
| **Mapping & Utilities** | Lombok, MapStruct |
| **Build Tool** | Maven |
| **Development Tools** | IntelliJ IDEA, Visual Studio Code, Postman, Git |

## Database Design

The application uses MySQL for transactional data.

**Main entities**

- User
- Role
- Address
- Product
- ProductVariant
- ProductImage
- Category
- Brand
- Cart
- CartItem
- Order
- OrderItem
- Payment
- Review
- ShippingMethod
- PasswordResetToken

## REST APIs

| API Group | Purpose |
|---|---|
| `/api/auth` | Authentication, login, registration, password reset, Google login |
| `/api/users` | User profile and account management |
| `/api/products` | Product catalog, product detail, recommendations |
| `/api/categories` | Category listing |
| `/api/brands` | Brand listing |
| `/api/cart` | Cart management |
| `/api/orders` | Order creation, status updates, payment flow |
| `/api/reviews` | Product review operations |
| `/api/addresses` | User address management |
| `/api/admin` | Admin dashboard, users, categories, orders, product insights |
| `/api/admin/products` | Admin product CRUD operations |
| `/api/vnpay` | VNPay return callback handling |

## Security

- Spring Security protects the backend API.
- JWT is used for stateless authentication.
- Role-based authorization separates customer and admin capabilities.
- Sensitive values are externalized in `application-secret.properties` instead of being hard-coded.
- Google, mail, and VNPay integrations are configured through secret properties.

## Installation

### 1. Clone the repositories

Clone both the backend and frontend repositories.

```bash
git clone https://github.com/BinhTranThanhNLU/ShoeShopSpringboot.git
git clone https://github.com/BinhTranThanhNLU/ShoeShopReact.git
```

---

### 2. Backend Setup (IntelliJ IDEA)

1. Open **IntelliJ IDEA**.
2. Select **Open** and choose the backend project folder.
3. Wait for IntelliJ to import the Maven project and download all required Maven dependencies automatically.
4. Copy:

   ```
   src/main/resources/application-secret.properties.example
   ```

   to

   ```
   src/main/resources/application-secret.properties
   ```

5. Fill in the required configuration values.
6. Make sure your MySQL database is running and update the database configuration in:

   ```
   src/main/resources/application.properties
   ```

7. Run the Spring Boot application by starting the main application class (e.g. `ShoeshopApplication`).

The backend will be available at:

```text
http://localhost:8080
```

---

### 3. AI Service Setup (FastAPI)

Open the **ai-service** project in **Visual Studio Code** (or any Python IDE).

Create and activate a virtual environment (optional but recommended):

```bash
python -m venv .venv
```

Start the FastAPI server:

```bash
uvicorn main:app --reload
```

The AI service will be available at:

```text
http://localhost:8000
```

Interactive API documentation:

```text
http://localhost:8000/docs
```

---

### 4. Frontend Setup (VS Code)

Open the frontend project in **Visual Studio Code**.

Install the required packages:

```bash
cd shoe-shop
npm install
```

Start the development server:

```bash
npm run dev
```

The frontend will usually be available at:

```text
http://localhost:5173
```

## Environment Variables

The following configuration values are used by the project. Some are stored in `application.properties`, while secrets should be placed in `application-secret.properties`.

| Scope | Key | Description |
|---|---|---|
| Backend / Database | `spring.datasource.url` | MySQL connection string. |
| Backend / Database | `spring.datasource.username` | MySQL username. |
| Backend / Database | `spring.datasource.password` | MySQL password. |
| Backend / API | `spring.data.rest.base-path` | Base path for REST endpoints. |
| Backend / Security | `spring.security.user.name` | Default Spring Security username. |
| Backend / Security | `spring.security.user.password` | Default Spring Security password. |
| Backend / Profiles | `spring.profiles.include` | Includes the secret profile. |
| Backend / JWT | `app.jwt.secret` | JWT signing secret. |
| Backend / JWT | `app.jwt.expiration-ms` | JWT expiration time in milliseconds. |
| Backend / Google | `google.clientId` | Google client ID used for Google authentication. |
| Backend / Google | `google.clientSecret` | Google client secret. |
| Backend / Google | `google.redirectUri` | Google OAuth callback URL. |
| Backend / Mail | `spring.mail.host` | SMTP host for outgoing email. |
| Backend / Mail | `spring.mail.port` | SMTP port. |
| Backend / Mail | `spring.mail.username` | SMTP username. |
| Backend / Mail | `spring.mail.password` | SMTP password. |
| Backend / Payment | `vnpay.*` | VNPay payment configuration values, if enabled in the service layer. |

## Future Improvements

- Add automated backend test coverage.
- Add a dedicated frontend repository link and deployment guide.
- Add Docker Compose for local development.
- Expand logging, monitoring, and tracing.
- Improve API documentation with more examples and request payloads.
- Add production deployment notes.

## Some Screenshots

### Home Page

![Home Page](docs/images/home.pngs)

---

### Product List Page

![Product List Page](docs/images/product-list.png)

---

### Product Detail

![Product Detail](docs/images/product-detail.jpg)

---

### Cart

![Cart](docs/images/cart.png)

---

### Checkout

![Checkout](docs/images/checkout.png)

---

### Order History

![Order History](docs/images/account-order.png)

---

### Admin Dashboard

![Admin Dashboard](docs/images/admin-dashboard.jpg)

---

### Product Management

![Product Management](docs/images/admin-product.jpg)

### User Management

![User Management](docs/images/admin-user.png)
