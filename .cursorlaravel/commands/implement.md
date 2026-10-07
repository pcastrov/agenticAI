# /implement - Invocación del Subagente Implementador

Carga de inmediato el rol y reglas del Subagente Implementador (`2-implementer`).

## Instrucción para la IA
Asume el rol del subagente `@2-implementer.md`.
1. Lee `docs/constitution.md` y la carpeta `specs/NNN-[id-nombre-modulo]/` indicada por el usuario.
2. Selecciona la tarea activa en `tasks.md` (o la tarea especificada).
3. Aplica TDD estricto en Laravel/Filament (crea/ajusta los tests primero, ejecuta `php artisan test`, escribe el código, valida y marca `- [x]`).
4. Detente al terminar la tarea.
