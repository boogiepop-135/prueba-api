# Prueba API - Comercio Electrónico

## Requisitos
- Ruby 1.9.3
- Rails 3.1.2
- PostgreSQL

## Instalación

1. Instala las dependencias:
   ```bash
   bundle install
   ```

2. Configura la base de datos (asegúrate de tener PostgreSQL corriendo):
   ```bash
   rake db:create db:migrate
   ```

3. (Opcional) Configura la variable de entorno `SECRET_KEY_BASE` para producción.

## Ejecución

```bash
rails server
```

La API estará disponible en `http://localhost:3000`.

## Pruebas

Para ejecutar los tests automáticos:
```bash
rspec
```

## Documentación de la API

Consulta el archivo [API_DOC.md](API_DOC.md) para ver los endpoints, parámetros y ejemplos de uso.

## Notas

- Todos los endpoints (excepto login y registro) requieren autenticación JWT.
- Los parámetros deben enviarse en formato JSON.
- Para autenticación, usa el header: `Authorization: Bearer <token>`.

## Variables de entorno

Copia el archivo `.env.example` a `.env` y personaliza los valores según tu entorno antes de iniciar la aplicación.

## Revisión de nombres de archivos y rutas

Antes de ejecutar la aplicación, asegúrate de que los nombres de archivos, rutas y carpetas coincidan con los ejemplos y convenciones de este proyecto.  
Si tu estructura difiere, ajusta los nombres en los archivos de migración, modelos, controladores, rutas y pruebas para evitar errores de carga o referencia.

## Checklist final

- [ ] Archivo `.env` configurado con tus variables de entorno.
- [ ] Base de datos creada y migraciones aplicadas.
- [ ] Dependencias instaladas (`bundle install`).
- [ ] Pruebas ejecutadas y pasando (`rspec`).
- [ ] API probada manualmente (login, CRUD, checkout).
- [ ] Documentación revisada en `API_DOC.md`.

## Checklist final de revisión

- [ ] `.env` configurado correctamente con tus variables de entorno.
- [ ] Base de datos creada y migraciones aplicadas (`rake db:create db:migrate`).
- [ ] Dependencias instaladas (`bundle install`).
- [ ] Pruebas ejecutadas y exitosas (`rspec`).
- [ ] Probaste manualmente los endpoints principales (login, CRUD de usuarios, productos, órdenes y checkout).
- [ ] Revisaste la documentación en `API_DOC.md` y la usaste como referencia para tus pruebas.
- [ ] Verificaste que los nombres de archivos y rutas coincidan con tu estructura real.