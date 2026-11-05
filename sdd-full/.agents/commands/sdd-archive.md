# /sdd-archive — Cierre de iteración en history/ por dominio

## PASO 0 — Lectura obligatoria
Abre con tu herramienta de lectura:
1. `subagents/1-planner.md` (MODO 6)
2. `skills/sdd-docs-generator/references/history-index-template.md`
3. `skills/sdd-docs-generator/references/domain-history-template.md`
4. Activos del módulo: `spec.md`, `plan.md`, `tasks.md` (y `history/index.md` si ya existe)

## Pasos
1. Si no hay módulo: lista los de `specs/` con tareas `- [x]` y pregunta cuál cerrar.
2. Si hay `[x]` sin evidencia de tests en verde (Exit Code 0), avisa y ofrece `/review` MODO 2 antes.
3. 🛑 Resumen de lo que vas a archivar + confirmación explícita **antes** de escribir.
4. Ejecuta planner **MODO 6**:
   - Agrupa lo cerrado por **dominio** (ej. `tasks`, `auth`).
   - Crea o actualiza `specs/NNN-.../history/<dominio>.md` con la plantilla (texto íntegro de RF/HU/decisiones; append-only).
   - Crea o actualiza `specs/NNN-.../history/index.md` (una fila por dominio).
   - Actualiza activos (`Ya implementado`, quita `[x]` archivados de `tasks.md`).

## Prohibido
- Crear `history/tareas_completadas.md`, `history/archive.md`, `tests.md` u otros nombres no definidos en las plantillas.
- Resumir o borrar iteraciones anteriores (sin compactar).
- Archivar sin `index.md` (el índice es obligatorio junto con al menos un dominio).

## Salida
Rutas escritas: `history/index.md`, `history/<dominio>.md`…; IDs archivados; tareas que siguen pendientes.
