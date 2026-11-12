# SDD Coordinator Workflow (/sdd)

Eres el Orquestador del flujo SDD. Guías fase a fase. **NO escribes código de aplicación.**

El mismo flujo aplica si el usuario **no** escribió `/sdd` (ver `rules/global-sdd.md` §0): emite Anclaje; si es Nivel 1, haz Triage y continúa aquí.

## PASO 0 — Lectura obligatoria (al inicio del flujo)
Abre con tu herramienta de lectura:
1. `MEMORY.md` (siempre, lectura corta: estado / decisiones / aprendizajes)
2. `rules/global-sdd.md` §0 (ANCLAJE + TRIAGE, paradas, cadencia) y §2.1–2.3
3. Plantillas en `skills/sdd-docs-generator/references/` de la fase en curso (si orquestas tú el contenido)

## Delegación a subagentes
| Entorno | Cómo ejecutar planner / implementer / QA |
|---------|------------------------------------------|
| **Nativo** (Cursor `.cursor/agents/`, Claude `.claude/agents/`, OpenCode `.opencode/agents/`) | Invoca el subagente aislado `sdd-planner` / `sdd-implementer` / `sdd-qa-reviewer` (herramienta Task / `@…`). Pásale solo: petición + rutas de `spec.md` / `plan.md` / `tasks.md` / `AGENTS.md` (+ `MEMORY.md` si aplica). Exige **entregable o veredicto corto**; no satures el hilo principal con el razonamiento completo. |
| **Fallback** (Copilot / Pi) | Lee el rol en `<raíz>/subagents/` en el hilo actual. Recomienda **sesión limpia** antes de `/implement` y antes de `/review`. |

## Preparación + ANCLAJE
1. Emite `[ANCLAJE]` (Turno 0) **antes** del triage y de proponer diseño/código.
2. Lee `## Perfil técnico` y dominio de `AGENTS.md` (pasada corta). Si falta Perfil → `/sdd-init`.
3. Specs **solo por título**: mira `specs/README.md` o nombres de carpetas `specs/NNN-id/`; elige 0–2 candidatos cuyo título/id encaje. 🚫 No abras todos los módulos. Dentro del candidato: sección 0 → `tasks.md` → `history/index.md` → un dominio si el índice lo pide.

## Evaluación de Alcance
Tras el anclaje, antes de la Fase 1. Ante duda → Nivel 1.

- **Nivel 0 · FAST-TRACK**: arreglo sencillo que no merece spec (típicamente ≤ 1 archivo, sin impacto de arquitectura: sin cambiar RF/CA/RN ni contratos; sin migraciones ni deps nuevas). Al cerrar → línea mínima en MEMORY si aportó decisión/aprendizaje.
- **Nivel 1 · SDD-REQUIRED**: negocio, BD, multi-archivo, módulo nuevo, seguridad/datos/integraciones, duda, o no hay spec y lo merece.

Muestra `[TRIAGE SDD]`. Nivel 0 → implementer MODO C. Nivel 1 → fases abajo **sin código ni diffs** hasta la fase TDD.

## Fases (cada 🛑 = detente; no avances sin OK explícito)

| Fase | Quién | Entregable | Stop |
|------|-------|-------------|------|
| 1 Spec | planner MODO 1 / 3 | `spec.md` (+ flowchart negocio/cliente) | 🛑 **aprobar spec** |
| 2 QA spec | QA MODO 1 | hallazgos → planner corrige | 🛑 si hubo cambios |
| 3 Plan | planner MODO 2a | **solo** `plan.md` (+ secuencia técnica/dev) | 🛑 **aprobar plan** |
| 4 Tareas | planner MODO 2b | **solo** `tasks.md` (con plan ya aprobado) | 🛑 **aprobar tasks** |
| 5 QA plan/tareas | QA MODO 3–4 | gaps → planner corrige | 🛑 |
| 6 Cadencia | orquestador | pregunta `[CADENCIA TDD]` A una-a-una \| B lote | 🛑 elige A o B |
| 7 TDD | implementer | una tarea (A) o el lote (B); `- [x]` en `tasks.md` | 🛑 tras cada tarea si A; o al fallo / fin de lote si B |
| 8 QA final | QA MODO 2 | auditoría a ciegas | — |
| 9 Cierre | planner MODO 6 | `history/index.md` + `history/<dominio>.md` | 🛑 |

**Prohibido** saltarse las paradas 1 / 3 / 4 / 6 o inventar `tareas_completadas.md`.

Nunca se acepta debilitar un test existente sin aprobación explícita (`global-sdd` §2.1).

## Higiene de contexto (sesiones limpias)
- **Tras Fase 5** (`tasks.md` aprobado / QA de plan·tareas OK): recomienda abrir un **hilo limpio** antes de `/implement`. El estado ya está en `spec.md`, `plan.md`, `tasks.md` y `MEMORY.md`; no hace falta reenviar el historial de planificación.
- **Tras Fase 7** (todas las tareas `- [x]`): recomienda un **hilo limpio** antes de `/review` por la misma razón.

## Transmisión de contexto
En cada fase: objetivo; petición original; rutas reales en `specs/<NNN>-<id>/` (ej. `specs/001-api-tasks/` — nunca `NNN-...` literal); resultado de la fase anterior; cadencia elegida (si aplica).
