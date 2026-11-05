# /architect — Planificador (spec / plan / tasks / cierre)

## PASO 0 — Lectura obligatoria (ANTES de responder)
Usa tu herramienta de lectura de archivos y abre, en este orden:
1. `subagents/1-planner.md` (modos y reglas; no inventes el flujo).
2. La plantilla del modo en `skills/sdd-docs-generator/references/`:
   - Spec → `spec-template.md` (+ `sequence-business-template.md` si hay HU).
   - Plan → `plan-template.md` (MODO 2a).
   - Tareas → `tasks-template.md` (MODO 2b).
   - Cierre → `history-index-template.md` **y** `domain-history-template.md`.
3. Si el módulo ya existe: activos del modo. Historial: solo `history/index.md` y el dominio tocado.

Si la petición es ambigua: máximo 5 preguntas y espera. No generes código de aplicación.
Si el usuario pidió trabajo **sin** `/architect` pero es Nivel 1: igual aplica Triage (`global-sdd` §0) y estas paradas.

## Entregables y paradas (🛑 = espera OK explícito)

| Modo | Archivos | Tras escribir |
|------|----------|---------------|
| Spec (MODO 1 / 3) | `spec.md` (+ diagramas negocio) | 🛑 aprobar spec — **no** crees plan/tasks aún |
| Plan (MODO 2a) | **solo** `plan.md` (+ diagramas técnicos) | 🛑 aprobar plan — **no** crees tasks aún |
| Tareas (MODO 2b) | **solo** `tasks.md` | 🛑 aprobar tasks — luego el orquestador pregunta `[CADENCIA TDD]` |
| Cierre (MODO 6) | `history/index.md` + `history/<dominio>.md` | 🛑 resumen |

**Prohibido**: inventar `tests.md` / `tareas_completadas.md`; saltarse paradas; escribir plan y tasks en el mismo turno sin OK intermedio.
