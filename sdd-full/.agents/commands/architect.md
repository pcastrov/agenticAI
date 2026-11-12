# /architect — Planificador (spec / plan / tasks / cierre)

## PASO 0 — Lectura / delegación
1. Emite `[ANCLAJE]` (MEMORY corto) antes de inventar diseño.
2. **Nativo** (Cursor / Claude Code / OpenCode): delega en el subagente aislado **`sdd-planner`** (Task / `@sdd-planner`). Pásale solo petición + rutas `AGENTS.md`, `spec.md`/`plan.md`/`tasks.md` del módulo candidato. Pide entregable corto (rutas + resumen ≤5 líneas o 🛑 preguntas).
3. **Fallback** (Copilot / Pi): lee `subagents/1-planner.md` en este hilo; no inventes el flujo.
4. Specs **solo por título** (0–2 candidatos). Plantillas del modo en `skills/sdd-docs-generator/references/` (el planner las abre).
5. Módulo nuevo: `specs/<NNN>-<id-kebab>/` real. 🚫 no `NNN-...` literal.

Si la petición es ambigua: máximo 5 preguntas y espera. No generes código de aplicación.
Sin `/architect` pero Nivel 1: igual Anclaje + Triage (`global-sdd` §0) y estas paradas.
Cierre (MODO 6): puntero mínimo en `MEMORY.md` si el aprendizaje no cabe solo en history.

## Entregables y paradas (🛑 = espera OK explícito)

| Modo | Archivos | Tras escribir |
|------|----------|---------------|
| Spec (MODO 1 / 3) | `spec.md` (+ flowchart negocio/cliente) | 🛑 aprobar spec — **no** crees plan/tasks aún |
| Plan (MODO 2a) | **solo** `plan.md` (+ secuencia técnica/dev) | 🛑 aprobar plan — **no** crees tasks aún |
| Tareas (MODO 2b) | **solo** `tasks.md` | 🛑 aprobar tasks — luego el orquestador pregunta `[CADENCIA TDD]` |
| Cierre (MODO 6) | `history/index.md` + `history/<dominio>.md` | 🛑 resumen |

**Prohibido**: inventar `tests.md` / `tareas_completadas.md`; saltarse paradas; escribir plan y tasks en el mismo turno sin OK intermedio.

## Higiene de contexto
Tras **tasks aprobadas** (y QA de plan/tareas si aplica): recomienda un **hilo limpio** antes de `/implement`. El estado vive en `spec.md` / `plan.md` / `tasks.md` / `MEMORY.md`; evita reenviar el chat de planificación.
