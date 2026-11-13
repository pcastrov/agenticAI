# /implement — Implementador TDD

## PASO 0 — Lectura / delegación (ANTES de editar código)
1. Emite `[ANCLAJE]` + `[TRIAGE SDD]` si aún no están en el hilo. Si falta `tasks.md` (Nivel 1) → 🛑 pide `/architect` MODO 2b.
2. **Nativo** (Cursor / Claude Code / OpenCode): delega **cada tarea TDD** (y cada fix de QA) al subagente **`sdd-implementer`** aislado para no acumular ruido en el hilo principal. Pásale solo: tarea o pedido, rutas `AGENTS.md` + `spec.md`/`plan.md`/`tasks.md`, cadencia A|B (y, si aplica, el bloque `Diagnóstico y sugerencia` del QA). Exige reporte corto (archivos tocados, suite, `- [x]`).
3. **Fallback** (Copilot / Pi): recomienda **chat limpio** antes de `/implement`; lee `subagents/2-implementer.md` + `global-sdd` §0/§2.1 en ese hilo.

## Cadencia (obligatoria si hay más de una `- [ ]`)
Si el usuario aún no eligió, pregunta y **espera**:
```
[CADENCIA TDD]
A) Una por una — me detengo tras cada tarea para que revises
B) Todas seguidas — continuo hasta terminar el lote o hasta un fallo
```
Sin respuesta clara → **A**.

## Ciclo
1. Emite `[ANCLAJE]` y `[TRIAGE SDD]` si aún no están en el hilo.
2. Elige la siguiente `- [ ]` de `tasks.md` (o MODO C Nivel 0). TDD: rojo → verde → marca `- [x]`.
3. Fallos → `REPORTE DE FALLO` (no debilitar tests). UI → `/ui-check`.
4. **Modo A**: 🛑 tras cada tarea; pregunta si continúa con la siguiente.
5. **Modo B**: sigue con la siguiente sin preguntar; 🛑 solo al fallo o al acabar el lote.
6. Cierre Nivel 0 / aprendizaje útil → ¿línea mínima en `MEMORY.md`?

## Qué NO haces tú
- No archives (`/sdd-archive` / planner MODO 6).
- No crees `history/tareas_completadas.md`.
- Si todas quedaron `- [x]`: avisa → abre **hilo limpio** para `/review` (estado ya en `spec`/`plan`/`tasks`/`MEMORY`) y luego `/sdd-archive`.
