# /sdd (Lite) — Planear

## PASO 0 — Lectura obligatoria
Abre:
1. `rules/global-sdd.md` §0
2. `subagents/1-planner.md`
3. `skills/sdd-docs-generator/references/spec-template.md`
4. Si el módulo existe: `specs/NNN-.../spec.md` (+ `history/index.md` solo si hace falta)

## Flujo
1. TRIAGE: si solo preguntan → responde sin editar.
2. Emite `[TRIAGE SDD]` (Nivel 0 | 1). Ante duda → Nivel 1.
3. **Nivel 0 (FAST-TRACK)**: edición directa con motivo en 1 línea; no abras spec por reflejo.
4. **Nivel 1 (SDD-REQUIRED)**: **sin código ni diffs**. Máx 3 preguntas → escribe `specs/NNN-.../spec.md` copiando `spec-template.md`:
   - Tablas: Entradas, Salidas, Criterios de Aceptación, Archivos
   - Sección **Tareas** obligatoria con checklist `- [ ] **T1** …` (sin esta sección la fase está incompleta)
   - Tope ~150 líneas
5. 🛑 Espera aprobación explícita antes de `/implement`.
6. Tras implementar y `/review` APROBADO → `/sdd-archive` (no inventar `tareas_completadas.md`).
