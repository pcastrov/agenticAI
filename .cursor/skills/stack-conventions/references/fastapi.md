---
description: Convenciones idiomáticas de FastAPI (routers delgados, Pydantic, Depends, servicios, SQLAlchemy/SQLModel, tareas)
globs: **/*.py
alwaysApply: false
---

# Convenciones FastAPI

> Fuente: `.cursor/skills/stack-conventions/references/fastapi.md`. Las decisiones propias del proyecto van en **Convenciones** de `AGENTS.md` y tienen prioridad. Aplica a código nuevo o modificado.

## 1. Responsabilidades y Estructura
- **Debe**: Endpoints delgados agrupados en `APIRouter` por dominio: reciben el esquema validado, obtienen dependencias con `Depends` y delegan en un servicio.
- **Debe**: Lógica de negocio en servicios (`services/[feature].py`), sin dependencias de FastAPI (no importan `Request`, `HTTPException` ni `Depends`), para poder probarlos y reutilizarlos.
- **Debe**: Los servicios lanzan errores de dominio propios; un exception handler (o el endpoint) los convierte en `HTTPException` con el código correcto.
- **Preferir**: `Annotated[..., Depends(...)]` para declarar dependencias reutilizables (sesión, usuario actual, permisos).

## 2. Datos y Validación
- **Debe**: Esquemas Pydantic para entrada y salida (`response_model` o tipo de retorno); nunca devolver modelos del ORM sin esquema.
- **Debe**: Separar los esquemas Pydantic de los modelos del ORM (`schemas/` y `models/`, o la convención del proyecto), aunque se usen SQLModel.
- **Debe**: Pasar a los servicios el esquema validado o argumentos tipados, nunca `Request`.
- **Debe**: Configuración con `pydantic-settings` (`BaseSettings`) desde variables de entorno.

## 3. Consultas (SQLAlchemy / SQLModel)
- **Debe**: Una sesión por petición, entregada con `Depends`; los servicios la reciben como argumento.
- **Debe**: Evitar N+1 con `selectinload()` (colecciones) o `joinedload()` (relaciones a uno). Con sesiones asíncronas la carga perezosa lanza error, así que el eager loading es obligatorio.
- **Preferir**: Consultas reutilizables en funciones de consulta con nombre (ej. `queries/[feature].py`) en lugar de repetir `select()` en varios servicios. Un repositorio solo se justifica si abstrae algo más que reenviar al ORM.
- **Debe**: Migraciones con Alembic; nunca `create_all()` en producción.

## 4. Async
- **Debe**: No hacer llamadas bloqueantes (driver de BD síncrono, `requests`, `time.sleep`, I/O de archivos pesado) dentro de `async def`. Usa librerías async (`httpx.AsyncClient`, driver async) o define el endpoint como `def` para que corra en el threadpool.

## 5. Autorización
- **Debe**: Autenticación y permisos como dependencias (`Depends(get_current_user)`, `Depends(require_permission(...))`) o `Security` con scopes; no chequeos sueltos dentro del endpoint.

## 6. Efectos Secundarios
- **Preferir**: `BackgroundTasks` solo para trabajo ligero que puede perderse si el proceso se reinicia; para trabajo confiable o pesado, una cola (Celery, ARQ, Dramatiq).
- **Debe**: Encolar después de confirmar la transacción; nunca llamar a una API externa con la transacción abierta.

## 7. Tests
- **Preferir**: pytest con `TestClient` (o `httpx.AsyncClient` con `ASGITransport` para tests async).
- **Debe**: Sustituir dependencias externas con `app.dependency_overrides` (sesión de BD de test, usuario autenticado, clientes HTTP).
- **Preferir**: Servicios probados de forma unitaria, sin levantar la app.

## DRY en este stack
- **Duplicación aceptable (no es hallazgo)**: schemas Pydantic separados por operación (`Create`, `Update`, `Read`) aunque compartan campos; un router por recurso con endpoints parecidos.
- **Sí es hallazgo**: la misma regla de negocio en dos endpoints o servicios; la misma dependencia (auth, paginación, sesión) reescrita en lugar de un `Depends` compartido; la misma consulta con filtros de negocio repetida.
- **Excluir de la búsqueda**: `.venv/`, `venv/`, `alembic/versions/`, `__pycache__/`, clientes generados desde OpenAPI.

## Verificación Automática
- **Lint y formato**: ruff (`ruff check . && ruff format --check .`), con reglas `ASYNC` para detectar llamadas bloqueantes en código async.
- **Tipos**: mypy o pyright.
- **Arquitectura**: `import-linter` con contratos, por ejemplo que `services` no importe `fastapi` y que `routers` no importe `sqlalchemy` directamente.
