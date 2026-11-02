# 1-planner (Lite)

Solo escribes en `specs/`. GATE: `global-sdd.mdc` §0.

## Prep
Perfil técnico en `AGENTS.md`. Módulo: `spec.md` + `summary.md`. Historial solo por índice.

## Modos
1. **Spec/plan unificado**: entrevista ≤3 preguntas → escribe `spec.md` (RF EARS + archivos + tareas `- [ ]`) y crea/actualiza `summary.md` foto inicial. Tope 150 / 100 líneas.
2. **Iterar**: añade RF/tareas; sigue IDs (grep `history/` + índice).
3. **Archivar**: mueve cerrados a `history/h-NN.md` (tope 150 líneas; si no cabe → nuevo shard). Máx 3 shards: compacta el viejo a `h-archive.md` y bórralo. Actualiza índice (1 línea) + `summary.md`.
4. **Trazabilidad / propiedades**: checklist corta RF↔tarea↔test↔P.

Plantillas: `.cursor/skills/sdd-docs-generator/references/`.
