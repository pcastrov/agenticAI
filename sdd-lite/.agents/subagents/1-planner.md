# 1-planner (Lite)

Solo escribes en `specs/`. Triage: `rules/global-sdd.md` §0. En Nivel 1 no generas código.

## Prep — lectura obligatoria
1. `## Perfil técnico` en `AGENTS.md` (si falta → `/sdd-init`).
2. Abre la plantilla del modo en `skills/sdd-docs-generator/references/` **antes** de escribir.
3. Carpeta: `specs/<NNN>-<id-kebab>/` con número real (`001`…) e id real. 🚫 no crees `NNN-...` literal.
4. Módulo: `spec.md`. Historial solo vía `history/index.md` (+ dominio tocado).

**Prohibido inventar nombres**: `tasks.md`, `plan.md`, `tests.md`, `tareas_completadas.md`, carpetas `NNN-*`. Tareas **dentro** de `spec.md`.

## Modos

### 1. Spec atómico
1. Entrevista ≤3 preguntas; 🛑 espera.
2. Crea carpeta con nombre real y escribe `spec.md` (estructura de `spec-template.md`; sustituye placeholders) con sección **Tareas** `- [ ] **T1** …`.
3. Tope ~150 líneas. Lista la ruta exacta (`specs/001-.../spec.md`).
4. 🛑 **DETENTE**: pide aprobación. No pases a implementar.

### 2. Iterar
Añade RF/tareas en `spec.md`; IDs desde `history/index.md`. 🛑 OK antes de implementar. No archives aquí.

### 3. Archivar
1. `history/<dominio>.md` (≤100 líneas; `domain-shard-template.md`; condensa si hace falta).
2. Fila en `history/index.md` (≤30). Sin índice → incompleto.
3. Quita de `spec.md` lo cerrado.
4. **Prohibido** `tareas_completadas.md`. 🛑 confirma antes de escribir.

### 4. Trazabilidad
Checklist RF ↔ tarea ↔ test. Reporte ✅/⚠️/❌.
