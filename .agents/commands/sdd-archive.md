# /sdd-archive - Cierre Manual de Iteración

Mueve lo completado de un módulo a su `history.md` para que los documentos activos queden solo con lo pendiente.

## Instrucción para la IA

1. Si el usuario no indicó el módulo, lista los módulos de `specs/` que tengan tareas `- [x]` en `tasks.md` y pregunta cuál cerrar.
2. Invoca a `@1-planner.md` en **MODO 6: Cierre de Iteración** para ese módulo.
3. Si alguna tarea `- [x]` no tiene evidencia de tests en verde (sin dictamen QA reciente), avísalo y pregunta si se archiva igual o se ejecuta antes `/review` (MODO 2).
4. 🛑 **DETENTE Y ESPERA**: Muestra el resumen de lo que se va a archivar y pide confirmación antes de escribir.

## Formato de Salida
- Iteración creada en `history.md` (número y título).
- IDs archivados (`RF`, `P`, `T`, `S`).
- Tareas que siguen pendientes en `tasks.md`.
