# README for E-commerce API

## Descripción del Proyecto

Este proyecto es una API RESTful para una aplicación de comercio electrónico, desarrollada en Ruby on Rails (versión 3.1.2) y utilizando PostgreSQL como base de datos. La API permite gestionar usuarios, productos y órdenes, así como realizar recomendaciones de productos.

## Entidades

- **Usuarios**: Permite la creación, actualización, eliminación y consulta de usuarios.
- **Productos**: Permite la creación, actualización, eliminación y consulta de productos.
- **Órdenes**: Permite la creación, actualización, eliminación y consulta de órdenes.
- **Recomendaciones**: Proporciona recomendaciones de productos basadas en las compras anteriores de los usuarios.

## Requisitos

- Ruby 3.1.2
- Rails 3.1.2
- PostgreSQL

## Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd Apellido-Nombre-Developer
   ```

2. **Instalar las gemas**:
   ```bash
   bundle install
   ```

3. **Configurar la base de datos**:
   - Editar el archivo `config/database.yml` para ajustar las credenciales de la base de datos.
   - Crear la base de datos:
   ```bash
   rake db:create
   ```

4. **Ejecutar las migraciones**:
   ```bash
   rake db:migrate
   ```

## Uso

- **Iniciar el servidor**:
   ```bash
   rails server
   ```

- **Endpoints disponibles**:
   - **Usuarios**:
     - `POST /users`: Crear un nuevo usuario.
     - `GET /users`: Listar todos los usuarios.
     - `GET /users/:id`: Obtener un usuario específico.
     - `PUT /users/:id`: Actualizar un usuario.
     - `DELETE /users/:id`: Eliminar un usuario.
   - **Productos**:
     - `POST /products`: Crear un nuevo producto.
     - `GET /products`: Listar todos los productos.
     - `GET /products/:id`: Obtener un producto específico.
     - `PUT /products/:id`: Actualizar un producto.
     - `DELETE /products/:id`: Eliminar un producto.
   - **Órdenes**:
     - `POST /orders`: Crear una nueva orden.
     - `GET /orders`: Listar todas las órdenes.
     - `GET /orders/:id`: Obtener una orden específica.
     - `PUT /orders/:id`: Actualizar una orden.
     - `DELETE /orders/:id`: Eliminar una orden.
   - **Recomendaciones**:
     - `GET /recommendations`: Obtener recomendaciones de productos.

## Pruebas

Para ejecutar las pruebas, utiliza el siguiente comando:

```bash
rspec
```

## Documentación de la API

La documentación detallada de la API se encuentra en `doc/api_documentation.md`.

## Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o envía un pull request para discutir cambios.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulte el archivo LICENSE para más detalles.