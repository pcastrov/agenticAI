---
name: stack-conventions
description: Convenciones condensadas (solo Debe) para SDD Lite. Leer solo la guía de `conventions`.
---

# Stack Conventions (Lite)

Si `conventions` falta → solo Principios Generales.

| Valor | Archivo |
|-------|---------|
| laravel | `references/laravel.md` |
| filament | `references/filament.md` |
| nativephp | `references/nativephp.md` |
| django | `references/django.md` |
| fastapi | `references/fastapi.md` |
| flutter | `references/flutter.md` |

Prioridad: constitution > Convenciones AGENTS > esta guía.

## Principios Generales
1. Entradas delgadas (Debe).
2. Lógica en Action/servicio cuando hay transacción/regla (Debe).
3. Validar en frontera (Debe).
4. Sin N+1; sin capas vacías (Debe).
5. Auth nativa (Debe).
6. DRY/KISS/YAGNI: preguntar (Preferir).
