# /implement (Lite) — TDD con cadencia

## PASO 0 — Lectura obligatoria
Abre:
1. `subagents/2-implementer.md`
2. `rules/global-sdd.md` §0
3. `specs/NNN-.../spec.md` (sección **Tareas**)

Sin `- [ ]` → 🛑; pide `/sdd` o `/architect`. No crees `tasks.md` (Lite: tareas en `spec.md`).

## Cadencia
Si hay ≥2 `- [ ]` y no eligió aún:
```
[CADENCIA TDD]
A) Una por una — me detengo tras cada tarea
B) Todas seguidas — hasta fin de lote o fallo
```
🛑 Espera. Sin respuesta → **A**.

## Ciclo
1. `[TRIAGE SDD]` si falta. Una tarea → TDD → `- [x]` en `spec.md`.
2. Fallo → `REPORTE DE FALLO` + STOP.
3. Modo **A**: 🛑 «¿Sigo con la siguiente?»
4. Modo **B**: sigue; STOP solo al fallo o al acabar.

No archives. Todo `[x]` → `/review` luego `/sdd-archive`.
