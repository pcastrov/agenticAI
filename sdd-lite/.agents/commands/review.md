# /review (Lite)

## PASO 0 — Lectura obligatoria
Abre:
1. `subagents/3-qa-reviewer.md`
2. `specs/<NNN>-<id>/spec.md` ruta real (ej. `001-...`) — Criterios de Aceptación + Tareas
3. El `git diff` / `git status` del cambio

Actúa como **testeador**: verifica que el cambio cumple el Spec. Puedes crear/ejecutar tests; **no** modifiques código de producción.

## Pasos
1. Por cada CA (CA-1, CA-2…) revisa si existe un test que lo cubra. Si falta, **créalo** en la ruta de tests del Perfil técnico (`AGENTS.md`), con nombre que cite el CA.
2. Ejecuta los tests (`test` / `test_single` del Perfil técnico) y, si el Perfil lo define, el chequeo de estilo (`lint`). Si no hay lint → "no aplica".
3. Compara el diff contra el Spec: archivos tocados vs sección Archivos.
4. Responde **únicamente** con esta tabla (sin prosa previa):

| Criterio | Estado [SÍ/NO] | Evidencia / Salida de terminal |
|----------|----------------|--------------------------------|
| Cumple contrato del Spec (cada CA tiene test y pasa) | | |
| Cero cambios fuera de alcance | | |
| Cero prints/logs residuales | | |
| Exit Code 0 en tests (y lint si aplica) | | |

## Reglas
- Evidencia obligatoria: fragmento del diff o salida literal de terminal con exit code. Sin evidencia → `NO`.
- Cualquier `NO` → `CAMBIOS NECESARIOS` + lista corta; todo `SÍ` → `APROBADO`.
- Un test rojo nunca se ajusta para que pase: se reporta (`REPORTE DE FALLO`). No debilites ni borres tests existentes.
- Si `APROBADO` y todas las tareas de `spec.md` están `- [x]`: recuerda el siguiente paso → `/sdd-archive`.
