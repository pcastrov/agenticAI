# /implement — Implementador TDD (una tarea)

## PASO 0 — Lectura obligatoria (ANTES de editar código)
Usa tu herramienta de lectura de archivos y abre:
1. `subagents/2-implementer.md`
2. `rules/global-sdd.md` §0 (GATE) y §2.1 (integridad de tests)
3. Del módulo activo: `spec.md`, `plan.md` y **`tasks.md`**
4. Si falta `tasks.md` → 🛑 DETENTE. Indica al usuario que ejecute `/architect` en MODO 2 (plan + tareas) antes de implementar. No improvises tareas en chat ni inventes otro archivo.

## Ciclo (resumen; detalle en el subagente)
1. Emite `[TRIAGE SDD]` si aún no está en el hilo. Elige **una** tarea `- [ ]` de `tasks.md`.
2. TDD: rojo → verde → marca esa línea como `- [x]` en `tasks.md`.
3. Fallos → `REPORTE DE FALLO` (no debilitar tests). UI → `/ui-check` aislado.
4. 🛑 Al terminar **esa** tarea: detente. No inicies la siguiente sin aprobación.

## Qué NO haces tú
- No archives a `history/` (eso es `/sdd-archive` o planner MODO 6).
- No crees `history/tareas_completadas.md` ni muevas checkboxes a un archivo inventado.
- Si **todas** las tareas del módulo quedaron `- [x]`: avisa al usuario que el siguiente paso es `/review` y luego `/sdd-archive` (crea `history/index.md` + `history/<dominio>.md`).
