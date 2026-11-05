# Shard de dominio — [dominio]

**Tope**: 100 líneas. Ficha atómica: SOLO firmas de endpoints y contratos JSON. Sin texto conversacional, sin explicaciones, sin saludos.

## Formato

### Endpoints
| Método | Ruta | Request | Response | RF |
|--------|------|---------|----------|----|
| [VERBO] | `[/ruta]` | `[json]` | `[json]` | RF-0N |

### Contratos JSON
```json
{ "[campo]": "[tipo]" }
```

### Archivos
- `[ruta]` — RF-0N

## Ejemplo 1 (Few-Shot) — correcto

### Endpoints
| Método | Ruta | Request | Response | RF |
|--------|------|---------|----------|----|
| POST | `/api/login` | `{"email":"string","password":"string"}` | `200 {"token":"string"}` / `401 {"error":"string"}` | RF-01 |
| POST | `/api/logout` | `{}` | `204` | RF-02 |

### Contratos JSON
```json
{ "token": "string", "expires_in": "int" }
```

### Archivos
- `app/Http/Controllers/AuthController.php` — RF-01
- `tests/Feature/AuthTest.php` — RF-01, RF-02

## Ejemplo 2 (Few-Shot) — INCORRECTO (no hacer)

> "Claro, implementé el login con un controlador que valida las credenciales y luego devuelve un token..."

Motivo: texto conversacional. Solo se firman rutas, contratos y archivos.
