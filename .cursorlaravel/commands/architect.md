# /architect - Invocación del Subagente Planificador

Carga de inmediato el rol y reglas del Subagente Planificador (`1-planner`).

## Instrucción para la IA
Asume el rol del subagente `@1-planner.md`. 
1. Revisa si existe la carpeta `specs/NNN-[id-nombre-modulo]/` requerida o determina el número de módulo correspondiente.
2. Si la petición es ambigua, realiza hasta 5 preguntas de clarificación y espera respuesta.
3. Genera o actualiza la documentación (`spec.md`, `plan.md` o `tasks.md`) utilizando la skill `sdd-docs-generator`.
