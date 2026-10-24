# /implement - Invocación del Subagente Implementador

Carga de inmediato el rol y reglas del Subagente Implementador (`2-implementer`).

## Instrucción para la IA
Asume el rol del subagente `@2-implementer.md`.
1. Lee `docs/constitution.md`, el bloque `## Perfil técnico` de `AGENTS.md` y los documentos activos de `specs/NNN-[id-nombre-modulo]/` indicados por el usuario.
2. Selecciona la tarea activa en `tasks.md` (o la tarea especificada). Si el usuario pide un cambio que no está en `tasks.md`, aplica la **Evaluación de Alcance** de `/sdd` antes de tocar código.
3. Aplica TDD estricto: crea los tests primero, ejecútalos con `test_single` o `test`, escribe el código, valida en verde y marca `- [x]`.
4. Si un test falla, entrega el **Reporte de Fallo** del implementador. Nunca modifiques ni debilites un test existente para que pase.
5. Detente al terminar la tarea.
