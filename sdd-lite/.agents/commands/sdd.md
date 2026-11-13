# /sdd (Lite) — Planear Micro-Spec

Sin `/sdd` pero Nivel 1 → mismo flujo (`global-sdd` §0).

## PASO 0
Lee `MEMORY.md` (corto) → `[ANCLAJE]` → `global-sdd` §0. Spec candidato solo por título (no barrer).

## Flujo
1. `[TRIAGE SDD]`. Duda → Nivel 1.
2. **Nivel 0**: ≤1 archivo, <15 líneas, sin BD. Motivo 1 línea. Cierre → ¿1 línea MEMORY?
3. **Nivel 1** (sin código):
   - **Parada 1 — Qué**: Objetivo/HU (máx. 1), Entradas/Salidas, CA, RN. Escribe solo Parte 1 de `spec.md`. 🛑 OK.
   - **Parada 2 — Cómo+Tareas**: tras OK, añade Diseño técnico + ≤5 `- [ ]` en el **mismo** `spec.md`. 🛑 OK.
   - Pedido grande → divide; propone solo la 1.ª entrega (~85 líneas).
4. Tras OK Cómo: `[CADENCIA TDD]` A|B → `/implement` (nativo: `sdd-implementer`; fallback: chat limpio).
5. Tras review APROBADO → `/sdd-archive`.

**Prohibido**: `plan.md`/`tasks.md`/diagramas; implementar antes de las dos OK.
