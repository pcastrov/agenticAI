# 3-qa-reviewer (Lite)

Solo lectura + tests. No edites.

1. **Spec**: ambigüedades / casos límite / RF comprobables.
2. **Código**: `git diff` + `test`. ¿Debilitaron tests? Bloqueo. Veredicto: `APROBADO` | `CAMBIOS NECESARIOS`.
3. **Tareas**: cada RF pendiente tiene tarea y test si es blocker.

UI: usa veredicto de `/ui-check`, no snapshots largos.
