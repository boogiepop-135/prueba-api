# Documentación de la API REST - Comercio Electrónico

## Autenticación

### POST /login
Autentica un usuario y devuelve un token JWT.

**Parámetros:**
- `email` (string, requerido)
- `password` (string, requerido)

**Ejemplo de request:**
```json
{
  "email": "usuario@mail.com",
  "password": "123456"
}
```

**Respuesta exitosa:**
```json
{
  "token": "jwt_token_aqui"
}
```

---

## Usuarios

### POST /users
Registra un nuevo usuario.

**Parámetros:**
- `email` (string, requerido)
- `password` (string, requerido)
- `password_confirmation` (string, requerido)

**Respuesta exitosa:** Código 201  
```json
{
  "id": 1,
  "email": "usuario@mail.com",
  "created_at": "2024-06-10T12:00:00Z"
}
```

### GET /users/:id
Muestra los datos de un usuario.

### PUT /users/:id
Actualiza el usuario autenticado.

### DELETE /users/:id
Elimina el usuario autenticado.

---

## Productos

> Todos los endpoints requieren autenticación (header: `Authorization: Bearer <token>`)

### GET /products
Lista todos los productos.

### POST /products
Crea un producto.

### PUT /products/:id
Actualiza un producto.

### DELETE /products/:id
Elimina un producto.

---

## Órdenes

### GET /orders
Lista las órdenes del usuario autenticado.

### POST /orders/checkout
Crea una orden de compra con los productos seleccionados.

**Parámetros:**
- `products`: array de IDs de productos

**Ejemplo de request:**
```json
{
  "products": [1, 2, 3]
}
```

**Respuesta exitosa:** Código 201  
```json
{
  "id": 1,
  "user_id": 1,
  "created_at": "2024-06-10T12:00:00Z",
  "products": [
    { "id": 1, "name": "Producto 1", "price": "10.00" },
    { "id": 2, "name": "Producto 2", "price": "20.00" }
  ]
}
```

---

## Códigos de estado comunes

- 200 OK: Operación exitosa
- 201 Created: Recurso creado
- 401 Unauthorized: No autenticado o sin permisos
- 422 Unprocessable Entity: Error de validación

---

## Notas

- Todos los endpoints (excepto login y registro) requieren autenticación JWT.
- Los parámetros deben enviarse en formato JSON.

---

## Notas adicionales

- Verifica que los nombres de archivos y rutas en tu proyecto coincidan con los ejemplos de esta documentación.
- Si cambias algún nombre de modelo, tabla o ruta, actualiza este archivo y el README para mantener la coherencia.
