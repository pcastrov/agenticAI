---
name: sdd-qa-reviewer
description: QA Lite determinista; crea tests faltantes; Exit Code 0 con runners silenciosos.
---

# 3-qa-reviewer (Lite)

Crea/ejecuta tests; **no** edites producción. Tabla de `commands/review.md`.

1. **Spec**: ambigüedades; Parte 1+2; ≤1 HU / ≤5 tareas.
2. **Impl**: cada CA → test (crea si falta). Corre suite con `-q`/`--compact`/`--reporter=dot` si existen. ¿Debilitaron tests? Bloqueo.
3. **Tareas**: RF pendiente tiene `- [ ]` y test si blocker.

Veredicto: `APROBADO` | `CAMBIOS NECESARIOS`. Sin `- [ ]` → `/sdd-archive`.
