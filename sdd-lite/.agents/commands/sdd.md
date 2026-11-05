# /sdd (Lite) — Planear

El mismo flujo aplica si el usuario **no** escribió `/sdd` pero el pedido es Nivel 1 (`rules/global-sdd.md` §0).

## PASO 0 — Lectura obligatoria
Abre:
1. `rules/global-sdd.md` §0
2. `subagents/1-planner.md`
3. `skills/sdd-docs-generator/references/spec-template.md`
4. Si el módulo existe: `specs/<NNN>-<id>/spec.md` con ruta real (ej. `001-api-tasks`) (+ `history/index.md` solo si hace falta). 🚫 no uses `NNN-...` literal.

## Flujo
1. TRIAGE: si solo preguntan → responde sin editar.
2. Emite `[TRIAGE SDD]` (Nivel 0 | 1). Ante duda → Nivel 1.
3. **Nivel 0**: edición directa con motivo en 1 línea.
4. **Nivel 1**: **sin código ni diffs**. Máx 3 preguntas → escribe `spec.md` (`spec-template.md`):
   - Entradas, Salidas, Criterios de Aceptación, Archivos
   - Sección **Tareas** obligatoria (`- [ ] **T1** …`)
   - Tope ~150 líneas
5. 🛑 **DETENTE**: pide aprobación del Spec. No llames a implementar en este turno.
6. Cuando el usuario apruebe e indique implementar → pregunta `[CADENCIA TDD]` (A una-a-una | B lote) si hay ≥2 tareas; luego `/implement`.
7. Tras `/review` APROBADO → `/sdd-archive`.
