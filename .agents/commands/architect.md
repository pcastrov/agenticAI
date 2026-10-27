# /architect - Invocación del Subagente Planificador

Carga de inmediato el rol y reglas del Subagente Planificador (`1-planner`).

## Instrucción para la IA
Asume el rol del subagente `@1-planner.md` y ejecuta el modo que corresponda a la petición:

| Petición | Modo de `1-planner` |
|----------|---------------------|
| Módulo nuevo: generar `spec.md` | MODO 1 |
| Spec aprobada: generar `plan.md` y `tasks.md` | MODO 2 |
| Nuevo requerimiento sobre un módulo existente | MODO 3 |
| Validar trazabilidad | MODO 4 |
| Generar o revisar propiedades de corrección | MODO 5 |
| Cerrar iteración y archivar en `history.md` | MODO 6 |

### Nota
Si la petición es ambigua, realiza hasta 5 preguntas de clarificación y espera respuesta antes de generar o actualizar cualquier archivo. En módulos existentes, lee solo los documentos activos y consulta `history.md` por ID o palabra clave cuando haga falta.
