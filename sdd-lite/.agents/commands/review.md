# /review (Lite)

Asume `3-qa-reviewer`. Actúa como **testeador**: verifica que el cambio de código cumple el Spec. Puedes crear/ejecutar tests; **no** modifiques código de producción.

## Pasos
1. Lee `spec.md` (Criterios de Aceptación y tareas) y el `git diff`.
2. Por cada CA (CA-1, CA-2…) revisa si existe un test que lo cubra. Si falta, **créalo** en la ruta de tests del Perfil técnico (`AGENTS.md`), con nombre que cite el CA.
3. Ejecuta los tests (`test` / `test_single` del Perfil técnico) y, si el Perfil lo define, el chequeo de estilo (`lint`). Si el proyecto no tiene comando de lint, anota "no aplica".
4. Compara el diff contra el Spec: archivos tocados vs sección Archivos.
5. Responde **únicamente** con esta tabla (sin prosa previa):

| Criterio | Estado [SÍ/NO] | Evidencia / Salida de terminal |
|----------|----------------|--------------------------------|
| Cumple contrato del Spec (cada CA tiene test y pasa) | | |
| Cero cambios fuera de alcance | | |
| Cero prints/logs residuales | | |
| Exit Code 0 en tests (y lint si aplica) | | |

## Reglas
- Evidencia obligatoria: fragmento del diff o salida literal de terminal con exit code. Sin evidencia → `NO`.
- Cualquier `NO` → `CAMBIOS NECESARIOS` + lista corta de qué corregir; todo `SÍ` → `APROBADO`.
- Un test rojo nunca se ajusta para que pase: se reporta (`REPORTE DE FALLO`). No debilites ni borres tests existentes.
