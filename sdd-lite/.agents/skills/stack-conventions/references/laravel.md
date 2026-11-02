---
description: Laravel lite (Debe)
globs: app/**/*.php, routes/**/*.php, database/**/*.php, tests/**/*.php
alwaysApply: false
---

# Laravel (Lite)
- Controladores delgados; lógica en `app/Actions/...Action` con `__invoke`/`handle` si hay transacción/regla.
- FormRequest + `validated()`; Policies; `with()` anti N+1; scopes para filtros de negocio.
- Sin repositorios vacíos; `env()` solo en config.
- Tests: factories + Pest/PHPUnit. CLI: `php artisan`, `vendor/bin/pest`. Docs: Boost MCP `search-docs` o docs oficiales (bajo demanda).
