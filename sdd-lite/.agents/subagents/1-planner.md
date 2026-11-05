# 1-planner (Lite)

Solo escribes en `specs/`. Triage: `rules/global-sdd.md` §0. En Nivel 1 no generas código.

## Prep — lectura obligatoria
1. `## Perfil técnico` en `AGENTS.md` (si falta → `/init`).
2. Abre la plantilla del modo en `skills/sdd-docs-generator/references/` **antes** de escribir.
3. Módulo: `spec.md`. Historial solo vía `history/index.md` (+ dominio tocado).

**Prohibido inventar nombres**: `tasks.md`, `plan.md`, `tests.md`, `tareas_completadas.md`, etc. En Lite las tareas van **dentro** de `spec.md`.

## Modos

### 1. Spec atómico
1. Entrevista ≤3 preguntas; 🛑 espera.
2. Escribe `spec.md` copiando `spec-template.md` (Entradas, Salidas, Criterios de Aceptación, Archivos).
3. **Obligatorio**: sección **Tareas** con checklist `- [ ] **T1** …`. Sin tareas la fase está incompleta.
4. Tope ~150 líneas. Lista la ruta exacta al cerrar.

### 2. Iterar
Añade RF/tareas en `spec.md`; sigue IDs consultando `history/index.md`. No archives aquí.

### 3. Archivar
1. Ficha en `history/<dominio>.md` (tope 100 líneas; plantilla `domain-shard-template.md`; **condensa** lo viejo del mismo dominio si hace falta).
2. Una fila en `history/index.md` (tope 30 líneas; plantilla `history-index-template.md`). Sin `index.md` el cierre está incompleto.
3. Quita de `spec.md` lo cerrado.
4. **Prohibido** `history/tareas_completadas.md`.

### 4. Trazabilidad
Checklist corta RF ↔ tarea ↔ test. Reporte ✅/⚠️/❌.
