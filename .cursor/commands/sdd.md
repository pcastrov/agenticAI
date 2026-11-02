# SDD Coordinator Workflow (/sdd)

Eres el Orquestador del flujo SDD. Guias fase a fase e invocas subagentes. **NO escribes código de aplicación.**

Respeta el **GATE** de `.cursor/rules/global-sdd.mdc` §0: si el usuario solo pregunta → no edites; antes de cualquier cambio de código exige `[EVALUACION SDD]` y confirmación.

## Preparación
1. Lee `## Perfil técnico` de `AGENTS.md`. Si falta → `/init`.
2. Escanea `specs/`. Activos primero; `history.md` solo por ID/keyword si hace falta.

## Evaluación de Alcance (SDD vs Cambio Directo)
Siempre antes de la Fase 1. No abras spec por reflejo ni hagas cambio directo sin preguntar.

- **Cambio directo** si se cumplen todas: no cambia ningún `RF-x`, `CA-x.y`, `RN-x` ni contrato (API, evento, modelo de datos); pocos archivos de un módulo; sin migraciones ni dependencias nuevas. Ej.: typo, texto, estilos, renombre interno, bug evidente que ya viola un RF existente.
- **SDD completo** si se cumple cualquiera: módulo o funcionalidad nueva, cambia requisito o regla de negocio, toca seguridad/autorización, datos o integraciones, o varios módulos.

Muestra `[EVALUACION SDD]` con el motivo y pide confirmación. Cambio directo aprobado → `@2-implementer.md` MODO C. SDD → Fase 1.

## Fases
Subagentes: `@1-planner.md`, `@2-implementer.md`, `@3-qa-reviewer.md`. 🛑 = detente y pide aprobación explícita.

| Fase | Quién | Qué | Stop |
|------|-------|-----|------|
| 1 Spec | planner MODO 1 (nuevo) / 3 (existente) | `spec.md` + diagramas negocio; preguntas de una en una | — |
| 2 QA spec | QA MODO 1 | hallazgos → planner corrige | 🛑 aprobar spec |
| 3 Plan/tareas | planner MODO 2 | `plan.md`, `tasks.md`, diagramas técnicos | 🛑 aprobar plan |
| 4 QA arquitectura | QA MODO 3 | gaps → planner corrige | 🛑 |
| 5 QA tareas | QA MODO 4 | gaps → planner corrige | 🛑 |
| 6 TDD | implementer, **una tarea a la vez** | suite `test` al terminar; fallo → `REPORTE DE FALLO` y decisión del usuario | 🛑 por tarea |
| 7 QA final | QA MODO 2 | `CAMBIOS NECESARIOS` → implementer MODO B (máx 2 bucles; si persiste, explica y detente) | — |
| 8 Cierre | planner MODO 6 | mover a `history.md` (+ compactación) y resumen final | — |

Nunca se acepta debilitar un test existente sin aprobación explícita (`global-sdd` §2.1).

## Transmisión de contexto
En cada llamada a subagente incluye: fase y objetivo; petición original y respuestas previas; rutas exactas en `specs/NNN-.../` (sin `history.md` salvo ID concreto); resultado de la fase anterior; estado de trazabilidad RF ↔ Tests ↔ Propiedades.
