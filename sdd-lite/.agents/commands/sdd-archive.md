# /sdd-archive (Lite) — Cierre en history/ por dominio

## PASO 0 — Lectura obligatoria
Abre:
1. `subagents/1-planner.md` (modo Archivar)
2. `skills/sdd-docs-generator/references/history-index-template.md`
3. `skills/sdd-docs-generator/references/domain-shard-template.md`
4. `specs/<NNN>-<id>/spec.md` ruta real (ej. `001-...`) (y `history/index.md` si existe)

## Pasos
1. Verifica tests en verde (Exit Code 0) o avisa y ofrece `/review` antes.
2. 🛑 Resumen de lo a archivar + confirmación **antes** de escribir.
3. Por cada dominio cerrado:
   - Escribe/actualiza `history/<dominio>.md` (ficha atómica, **máx 100 líneas**, plantilla `domain-shard-template.md`: endpoints, contratos JSON, archivos; cero prosa).
   - Si el shard ya existía y se pasa del tope: **condensa** lo viejo del mismo dominio (Lite sí compacta).
4. Actualiza `history/index.md` (**máx 30 líneas**, una fila por dominio).
5. Elimina de `spec.md` lo cerrado (RF/tareas `[x]` archivados); deja solo lo pendiente.

## Prohibido
- `history/tareas_completadas.md`, `history/archive.md`, `tests.md` u otros nombres no definidos en las plantillas.
- Archivar sin `index.md`.
- Inventar `plan.md` / `tasks.md` (en Lite no existen).

## Salida
Rutas: `history/index.md`, `history/<dominio>.md`…; qué quedó pendiente en `spec.md`.
