# API Documentation

## Overview
This document provides an overview of the RESTful API for the e-commerce application. It includes details about the available endpoints, request parameters, and response formats.

## Base URL
The base URL for the API is:
```
http://localhost:3000/api
```

## Authentication
The API uses JWT (JSON Web Tokens) for authentication. Users must authenticate to access certain endpoints. A token must be included in the `Authorization` header as follows:
```
Authorization: Bearer <token>
```

## Endpoints

### Users

#### Create User
- **POST** `/users`
- **Request Body**: 
  ```json
  {
    "user": {
      "username": "string",
      "email": "string",
      "password": "string"
    }
  }
  ```
- **Response**:
  - **201 Created**: User created successfully.
  - **422 Unprocessable Entity**: Validation errors.

#### Get Users
- **GET** `/users`
- **Response**:
  - **200 OK**: Returns a list of users.

#### Update User
- **PUT** `/users/:id`
- **Request Body**: 
  ```json
  {
    "user": {
      "username": "string",
      "email": "string"
    }
  }
  ```
- **Response**:
  - **200 OK**: User updated successfully.
  - **404 Not Found**: User not found.

#### Delete User
- **DELETE** `/users/:id`
- **Response**:
  - **204 No Content**: User deleted successfully.
  - **404 Not Found**: User not found.

### Products

#### Create Product
- **POST** `/products`
- **Request Body**: 
  ```json
  {
    "product": {
      "name": "string",
      "price": "number",
      "description": "string"
    }
  }
  ```
- **Response**:
  - **201 Created**: Product created successfully.
  - **422 Unprocessable Entity**: Validation errors.

#### Get Products
- **GET** `/products`
- **Response**:
  - **200 OK**: Returns a list of products.

#### Update Product
- **PUT** `/products/:id`
- **Request Body**: 
  ```json
  {
    "product": {
      "name": "string",
      "price": "number",
      "description": "string"
    }
  }
  ```
- **Response**:
  - **200 OK**: Product updated successfully.
  - **404 Not Found**: Product not found.

#### Delete Product
- **DELETE** `/products/:id`
- **Response**:
  - **204 No Content**: Product deleted successfully.
  - **404 Not Found**: Product not found.

### Orders

#### Create Order
- **POST** `/orders`
- **Request Body**: 
  ```json
  {
    "order": {
      "user_id": "integer",
      "product_ids": ["integer"]
    }
  }
  ```
- **Response**:
  - **201 Created**: Order created successfully.
  - **422 Unprocessable Entity**: Validation errors.

#### Get Orders
- **GET** `/orders`
- **Response**:
  - **200 OK**: Returns a list of orders.

#### Update Order
- **PUT** `/orders/:id`
- **Request Body**: 
  ```json
  {
    "order": {
      "status": "string"
    }
  }
  ```
- **Response**:
  - **200 OK**: Order updated successfully.
  - **404 Not Found**: Order not found.

#### Delete Order
- **DELETE** `/orders/:id`
- **Response**:
  - **204 No Content**: Order deleted successfully.
  - **404 Not Found**: Order not found.

### Recommendations

#### Get Recommendations
- **GET** `/recommendations`
- **Response**:
  - **200 OK**: Returns a list of recommended products based on user purchase history.

## Error Handling
All error responses will include a JSON object with an `error` key:
```json
{
  "error": "Error message"
}
```

## Conclusion
This API provides a robust interface for managing users, products, and orders in an e-commerce application. Ensure to handle authentication properly and validate all inputs to maintain data integrity.