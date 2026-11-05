# /sdd-archive — Cierre Manual de Iteración

1. Si no hay módulo: lista los de `specs/` con `- [x]` y pregunta.
2. Invoca `@1-planner.md` **MODO 6**: mueve lo cerrado a `history/<dominio>.md` y actualiza `history/index.md`.
3. Si hay `[x]` sin evidencia de tests en verde (Exit Code 0), avisa y ofrece `/review` MODO 2 antes.
4. 🛑 Resumen + confirmación antes de escribir.

## Salida
Iteración añadida por dominio en `history/`; índice actualizado; IDs archivados; tareas pendientes. Sin compactación: no se resume nada.
