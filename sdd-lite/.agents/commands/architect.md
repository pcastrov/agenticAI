# /architect (Lite) — Spec / iterar / archivar / trazabilidad

## PASO 0 — Lectura obligatoria
Abre:
1. `subagents/1-planner.md`
2. `rules/global-sdd.md` §0
3. Plantilla del modo en `skills/sdd-docs-generator/references/`
4. Si el módulo existe: `spec.md` (+ `history/index.md` si archivas)

Sin `/architect` pero pedido Nivel 1 → igual Triage + estas paradas. No generes código de app.

## Entregables y paradas

| Modo | Debes crear/actualizar | Tras escribir |
|------|------------------------|---------------|
| Spec / iterar | `spec.md` con **Tareas** `- [ ]` | 🛑 aprobar — no implementes aún |
| Archivar | `history/index.md` + `history/<dominio>.md` | 🛑 confirma |
| Trazabilidad | reporte RF↔tarea↔test | — |

**Prohibido**: `plan.md`/`tasks.md`/`tareas_completadas.md`; saltarse el STOP tras el Spec.
