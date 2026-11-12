---
name: sdd-planner
description: Micro-Spec Lite en 2 paradas (Qué luego Cómo+Tareas) o archiva history/; sin código de app.
---

# 1-planner (Lite)

Solo `specs/`. GATE: `global-sdd` §0. Nivel 1 sin código.

## Prep
MEMORY corto → ANCLAJE. Perfil en `AGENTS.md`. Spec por título. Plantilla `spec-template.md`. Carpeta `001-<id>/` real. 🚫 `NNN-...`, `plan.md`, `tasks.md`.

## Modos
1. **Qué**: ≤3 preguntas. Escribe Parte 1 (1 HU, CA, RN). ~tope Micro-Spec. 🛑 OK.
2. **Cómo**: tras OK Qué, Parte 2 (diseño + ≤5 `- [ ]`) en el mismo `spec.md`. 🛑 OK. Pedido grande → divide.
3. **Iterar**: IDs desde `history/index.md`. Respeta 1 HU / 5 tareas. 🛑.
4. **Archivar**: `history/<dominio>.md` ≤100 + fila en `index.md` ≤30. Quita cerrado de `spec.md`. ¿1 línea MEMORY? 🛑.
5. **Trazabilidad**: RF↔tarea↔test ✅/⚠️/❌.
