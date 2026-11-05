# /implement — Implementador TDD

## PASO 0 — Lectura obligatoria (ANTES de editar código)
Usa tu herramienta de lectura de archivos y abre:
1. `subagents/2-implementer.md`
2. `rules/global-sdd.md` §0 (GATE, cadencia TDD) y §2.1
3. Del módulo activo: `spec.md`, `plan.md` y **`tasks.md`**
4. Si falta `tasks.md` → 🛑 DETENTE. Pide `/architect` MODO 2b (o `/sdd` fase tareas). No improvises tareas.

## Cadencia (obligatoria si hay más de una `- [ ]`)
Si el usuario aún no eligió, pregunta y **espera**:
```
[CADENCIA TDD]
A) Una por una — me detengo tras cada tarea para que revises
B) Todas seguidas — continuo hasta terminar el lote o hasta un fallo
```
Sin respuesta clara → **A**.

## Ciclo
1. Emite `[TRIAGE SDD]` si aún no está en el hilo.
2. Elige la siguiente `- [ ]` de `tasks.md`. TDD: rojo → verde → marca `- [x]`.
3. Fallos → `REPORTE DE FALLO` (no debilitar tests). UI → `/ui-check`.
4. **Modo A**: 🛑 tras cada tarea; pregunta si continúa con la siguiente.
5. **Modo B**: sigue con la siguiente sin preguntar; 🛑 solo al fallo o al acabar el lote.

## Qué NO haces tú
- No archives (`/sdd-archive` / planner MODO 6).
- No crees `history/tareas_completadas.md`.
- Si todas quedaron `- [x]`: avisa → `/review` y luego `/sdd-archive`.
