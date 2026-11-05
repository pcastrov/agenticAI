# /architect — Planificador (spec / plan / tasks / cierre)

## PASO 0 — Lectura obligatoria (ANTES de responder)
Usa tu herramienta de lectura de archivos y abre, en este orden:
1. `subagents/1-planner.md` (modos y reglas; no inventes el flujo).
2. La plantilla del modo que vas a ejecutar en `skills/sdd-docs-generator/references/`:
   - Spec → `spec-template.md` (+ `sequence-business-template.md` si hay HU).
   - Plan/tareas → `plan-template.md` **y** `tasks-template.md` (ambos).
   - Cierre → `history-index-template.md` **y** `domain-history-template.md`.
3. Si el módulo ya existe: `specs/NNN-.../spec.md` (y `plan.md`/`tasks.md` solo si el modo lo pide). Historial: solo `history/index.md` y el dominio que toca la tarea.

Si la petición es ambigua: máximo 5 preguntas y espera. No generes código de aplicación.

## Entregables obligatorios por modo (en disco)
| Modo | Archivos que DEBES crear/actualizar | Prohibido |
|------|-------------------------------------|-----------|
| Spec (MODO 1 / 3) | `specs/NNN-<id>/spec.md` (+ diagramas `HU-x-negocio.md` si aplica) | Inventar `tests.md` u otros nombres |
| Plan + tareas (MODO 2) | **Los dos**: `plan.md` **y** `tasks.md` en el mismo paso | Entregar plan sin `tasks.md` |
| Cierre (MODO 6) | `history/index.md` + `history/<dominio>.md` (uno por dominio cerrado) | `history/tareas_completadas.md` u otros inventados |

Copia la estructura de la plantilla (tablas, IDs `T1`, `RF-x`, `HU-x`). No inventes formatos.
