# /architect (Lite) — Spec / iterar / archivar / trazabilidad

## PASO 0 — Lectura obligatoria (ANTES de responder)
Usa tu herramienta de lectura de archivos y abre, en este orden:
1. `subagents/1-planner.md`
2. `rules/global-sdd.md` §0 (Triage)
3. La plantilla del modo en `skills/sdd-docs-generator/references/`:
   - Spec / iterar → `spec-template.md`
   - Archivar → `history-index-template.md` **y** `domain-shard-template.md`
4. Si el módulo existe: `specs/NNN-.../spec.md`. Historial: solo `history/index.md` y el dominio tocado.

Si la petición es ambigua: máximo 3 preguntas y espera. **No generes código de aplicación.**

## Entregables obligatorios (en disco)

| Modo | Debes crear/actualizar | Prohibido |
|------|------------------------|-----------|
| Spec atómico | `specs/NNN-<id>/spec.md` con sección **Tareas** (`- [ ] **T1** …`). Tope ~150 líneas | Inventar `plan.md`, `tasks.md`, `tests.md` u otros nombres |
| Iterar | Actualizar `spec.md` (RF + tareas nuevas); IDs continúan desde `history/index.md` | Archivar en este modo |
| Archivar | `history/index.md` (≤30 líneas) + `history/<dominio>.md` (≤100 líneas, ficha atómica) | `history/tareas_completadas.md` u otros inventados |
| Trazabilidad | Reporte RF ↔ tarea ↔ test (no escribe archivos salvo que el usuario lo pida) | — |

Copia la estructura de la plantilla (tablas + Few-Shot). Sin prosa conversacional en shards.
