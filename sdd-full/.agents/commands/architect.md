# /architect — Planificador (spec / plan / tasks / cierre)

## PASO 0 — Lectura obligatoria (ANTES de responder)
Usa tu herramienta de lectura de archivos y abre, en este orden:
1. `MEMORY.md` (siempre, lectura corta) → emite `[ANCLAJE]` antes de inventar diseño o abrir specs en masa.
2. `AGENTS.md` (pasada corta: dominio / límites) + `subagents/1-planner.md` (modos; no inventes el flujo).
3. Specs **solo por título**: índice o nombres de carpetas; 0–2 candidatos. 🚫 No abras todos los módulos.
4. La plantilla del modo en `skills/sdd-docs-generator/references/`:
   - Spec → `spec-template.md` (+ `flowchart-business-template.md` si hay HU → flujo de cliente).
   - Plan → `plan-template.md` (MODO 2a) (+ `sequence-technical-template.md` → secuencia de desarrollo).
   - Tareas → `tasks-template.md` (MODO 2b).
   - Cierre → `history-index-template.md` **y** `domain-history-template.md`.
5. Si el módulo candidato existe: sección 0 + RF/RNF vigentes → `tasks.md` → `history/index.md` y solo el dominio tocado.
6. Módulo nuevo (ningún título encaja y merece SDD): carpeta real `specs/<NNN>-<id-kebab>/` (ej. `001-api-tasks`). 🚫 no crees `NNN-...` literal; `/sdd-init` no deja módulos de ejemplo.

Si la petición es ambigua: máximo 5 preguntas y espera. No generes código de aplicación.
Si el usuario pidió trabajo **sin** `/architect` pero es Nivel 1: igual aplica Anclaje + Triage (`global-sdd` §0) y estas paradas.
En cierre (MODO 6): si el aprendizaje no cabe solo en history → puntero mínimo en `MEMORY.md`.

## Entregables y paradas (🛑 = espera OK explícito)

| Modo | Archivos | Tras escribir |
|------|----------|---------------|
| Spec (MODO 1 / 3) | `spec.md` (+ flowchart negocio/cliente) | 🛑 aprobar spec — **no** crees plan/tasks aún |
| Plan (MODO 2a) | **solo** `plan.md` (+ secuencia técnica/dev) | 🛑 aprobar plan — **no** crees tasks aún |
| Tareas (MODO 2b) | **solo** `tasks.md` | 🛑 aprobar tasks — luego el orquestador pregunta `[CADENCIA TDD]` |
| Cierre (MODO 6) | `history/index.md` + `history/<dominio>.md` | 🛑 resumen |

**Prohibido**: inventar `tests.md` / `tareas_completadas.md`; saltarse paradas; escribir plan y tasks en el mismo turno sin OK intermedio.
