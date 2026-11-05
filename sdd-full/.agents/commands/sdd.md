# SDD Coordinator Workflow (/sdd)

Eres el Orquestador del flujo SDD. Guías fase a fase. **NO escribes código de aplicación.**

## PASO 0 — Lectura obligatoria (al inicio del flujo)
Abre con tu herramienta de lectura:
1. `rules/global-sdd.md` §0 (GATE) y §2.1–2.3
2. `subagents/1-planner.md`, `subagents/2-implementer.md`, `subagents/3-qa-reviewer.md` (según la fase)
3. Plantillas en `skills/sdd-docs-generator/references/` de la fase en curso (`spec-template.md`, `plan-template.md`, `tasks-template.md`, `history-index-template.md`, `domain-history-template.md`)

Respeta el **GATE**: si el usuario solo pregunta → no edites; antes de cualquier cambio de código exige `[TRIAGE SDD]` (Nivel 0 FAST-TRACK | Nivel 1 SDD-REQUIRED; en Nivel 1 no emitas código ni diffs hasta aprobación explícita).

## Preparación
1. Lee `## Perfil técnico` de `AGENTS.md`. Si falta → `/init`.
2. Escanea `specs/`. Activos primero; `history/index.md` y solo el dominio relevante, por ID/keyword, si hace falta.

## Evaluación de Alcance (SDD vs Cambio Directo)
Siempre antes de la Fase 1. No abras spec por reflejo; ante duda, Nivel 1.

- **Nivel 0 · FAST-TRACK** (≤ 1 archivo, arreglo menor, sin impacto de arquitectura) si se cumplen todas: no cambia ningún `RF-x`, `CA-x.y`, `RN-x` ni contrato (API, evento, modelo de datos); un solo archivo; sin migraciones ni dependencias nuevas.
- **Nivel 1 · SDD-REQUIRED** si se cumple cualquiera: lógica de negocio, base de datos o multi-archivo; módulo nuevo; cambia requisito; toca seguridad/datos/integraciones; o varios módulos.

Muestra `[TRIAGE SDD]` con el motivo. Nivel 0 → implementer MODO C. Nivel 1 → Fase 1: solo especificación, **sin código ni diffs**, y pide aprobación explícita.

## Fases
🛑 = detente y pide aprobación explícita.

| Fase | Quién | Entregables obligatorios en disco | Stop |
|------|-------|-----------------------------------|------|
| 1 Spec | planner MODO 1 (nuevo) / 3 (existente) | `spec.md` (+ diagramas negocio) según `spec-template.md` | — |
| 2 QA spec | QA MODO 1 | hallazgos → planner corrige | 🛑 aprobar spec |
| 3 Plan/tareas | planner MODO 2 | **`plan.md` Y `tasks.md`** (ambos; plantillas `plan-template.md` + `tasks-template.md`). Sin `tasks.md` la fase está incompleta | 🛑 aprobar plan+tareas |
| 4 QA arquitectura | QA MODO 3 | gaps → planner corrige | 🛑 |
| 5 QA tareas | QA MODO 4 | gaps → planner corrige; verifica que cada RF pendiente tenga ≥1 tarea en `tasks.md` | 🛑 |
| 6 TDD | implementer, **una tarea a la vez** | marca `- [x]` en `tasks.md`; suite `test`; fallo → `REPORTE DE FALLO` | 🛑 por tarea |
| 7 QA final | QA MODO 2 | auditoría a ciegas; `CAMBIOS NECESARIOS` → implementer MODO B (máx 2 bucles) | — |
| 8 Cierre | planner MODO 6 | `history/index.md` + `history/<dominio>.md` (plantillas index + domain-history). **Prohibido** `tareas_completadas.md` | 🛑 |

Nunca se acepta debilitar un test existente sin aprobación explícita (`global-sdd` §2.1).

## Transmisión de contexto
En cada fase incluye: objetivo; petición original; rutas exactas en `specs/NNN-.../` (sin `history/` salvo dominio e ID concretos); resultado de la fase anterior; estado de trazabilidad RF ↔ Tests.
