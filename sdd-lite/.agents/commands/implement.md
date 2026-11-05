# /implement (Lite) — Una tarea TDD

## PASO 0 — Lectura obligatoria (ANTES de editar código)
Abre con tu herramienta de lectura:
1. `subagents/2-implementer.md`
2. `rules/global-sdd.md` §0 (GATE) e integridad de tests
3. `specs/NNN-.../spec.md` del módulo activo (sección **Tareas**)

Si **no hay** sección de tareas con al menos un `- [ ]` → 🛑 DETENTE. Pide `/architect` (spec atómico / iterar) o `/sdd`. No improvises tareas en chat ni crees `tasks.md` (en Lite las tareas viven **dentro** de `spec.md`).

## Ciclo (detalle en el subagente)
1. Emite `[TRIAGE SDD]` si aún no está. Elige **una** tarea `- [ ]` de `spec.md`.
2. TDD: rojo → verde → marca esa línea `- [x]` en `spec.md`.
3. Fallos → `REPORTE DE FALLO` y STOP (no debilitar tests). UI → `/ui-check` o skill `on-demand-tools`.
4. 🛑 Al terminar esa tarea: detente. No inicies la siguiente sin aprobación.

## Qué NO haces tú
- No archives a `history/` (eso es `/sdd-archive`).
- No crees `history/tareas_completadas.md` ni muevas checkboxes a un archivo inventado.
- Si **todas** las tareas de `spec.md` quedaron `- [x]`: avisa → `/review` y luego `/sdd-archive` (`history/index.md` + `history/<dominio>.md`).
