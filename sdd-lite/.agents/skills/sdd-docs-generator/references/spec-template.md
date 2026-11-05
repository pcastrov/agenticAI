# [Nombre del módulo]

> Plantilla: sustituye por carpeta real (`001-api-tasks`). 🚫 No crees `NNN-...` literal.

**Módulo**: `001-[id]` | **Estado**: Borrador | Aprobado | **Tope**: ~150 líneas
Historial: `history/index.md` (solo si hace falta).

## 1. Spec atómico
| Campo | Valor |
|-------|-------|
| RF | RF-0N `[Must/Should]` |
| Entradas | [datos, tipos, origen] |
| Salidas | [datos, tipos, destino] |

### Criterios de Aceptación
| ID | DADO | CUANDO | ENTONCES |
|----|------|--------|----------|
| CA-1 | [estado] | [acción] | [resultado verificable] |

## 2. Archivos
| Acción | Ruta | RF |
|--------|------|----|
| Nuevo | `[ruta]` | RF-0N |
| Modificar | `[ruta]` | RF-0N |

## 3. Tareas
- [ ] **T1** — RF-0N — `[archivos]` — Test: `[ruta]` — Hecho cuando: [criterio].

## 4. Fuera de alcance
- [ítem]

## Ejemplo (Few-Shot)

| Campo | Valor |
|-------|-------|
| RF | RF-03 `[Must]` |
| Entradas | `email` (string, body), `password` (string, body) |
| Salidas | `token` (string, JSON 200) o `error` (string, JSON 401) |

| ID | DADO | CUANDO | ENTONCES |
|----|------|--------|----------|
| CA-1 | usuario existente | POST `/api/login` con credenciales válidas | 200 y `token` |
| CA-2 | usuario existente | POST `/api/login` con password errónea | 401 y `error` |

| Acción | Ruta | RF |
|--------|------|----|
| Nuevo | `app/Http/Controllers/AuthController.php` | RF-03 |
| Modificar | `routes/api.php` | RF-03 |

- [ ] **T1** — RF-03 — `AuthController.php` — Test: `tests/Feature/AuthTest.php` — Hecho cuando: CA-1 y CA-2 en verde.
