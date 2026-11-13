# /sdd-archive — Cierre de iteración en history/ por dominio

## PASO 0 — Lectura obligatoria
Abre con tu herramienta de lectura:
1. `MEMORY.md` (ventana 2–3 entradas; para no duplicar ni olvidar punteros)
2. `subagents/1-planner.md` (MODO 6)
3. `skills/sdd-docs-generator/references/history-index-template.md`
4. `skills/sdd-docs-generator/references/domain-history-template.md`
5. Activos del módulo candidato (por título): `spec.md`, `plan.md`, `tasks.md` (y `history/index.md` si ya existe)

## Pasos
1. Si no hay módulo: lista **nombres** de carpetas en `specs/` con tareas `- [x]` y pregunta cuál cerrar (no abras todos los spec.md).
2. Si hay `[x]` sin evidencia de tests en verde (Exit Code 0), avisa y ofrece `/review` MODO 2 antes.
3. 🛑 Resumen de lo que vas a archivar + confirmación explícita **antes** de escribir.
4. Ejecuta planner **MODO 6**:
   - Agrupa lo cerrado por **dominio** (ej. `tasks`, `auth`).
   - Crea o actualiza `specs/<NNN>-<id>/history/<dominio>.md` (ruta real, ej. `001-api-tasks`) con la plantilla (texto íntegro de RF/HU/decisiones; append-only).
   - Crea o actualiza `specs/<NNN>-<id>/history/index.md` (una fila por dominio).
   - Actualiza activos (`Ya implementado`, quita `[x]` archivados de `tasks.md`).
   - Si el aprendizaje no cabe solo en history → **puntero** de una línea en `MEMORY.md`. Si ya hay **3** entradas recientes, **desplaza** la más antigua (el histórico íntegro queda en `history/`).

## Prohibido
- Crear `history/tareas_completadas.md`, `history/archive.md`, `tests.md` u otros nombres no definidos en las plantillas.
- Resumir o borrar iteraciones anteriores en `history/` (sin compactar).
- Archivar sin `index.md` (el índice es obligatorio junto con al menos un dominio).
- Convertir MEMORY en bitácora ni superar ~20 líneas / 3 entradas activas.

## Salida
Rutas escritas: `history/index.md`, `history/<dominio>.md`…; IDs archivados; tareas que siguen pendientes; si hubo, línea añadida (y posible desplazamiento) en MEMORY.
