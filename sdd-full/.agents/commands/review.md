# /review — Auditoría a ciegas contra la Spec

## PASO 0 — Lectura obligatoria
Abre con tu herramienta de lectura:
1. `subagents/3-qa-reviewer.md` (modo que pida el usuario: 1 spec | 2 implementación | 3 arquitectura | 4 tareas)
2. `commands/review.md` no sustituye al subagente: sigue sus checklists.
3. Del módulo: `spec.md` aprobado (+ `plan.md`/`tasks.md` según el modo). En MODO 2 también el `git diff` / `git status`.

## Auditoría de implementación (MODO 2): "a ciegas"
El QA **no confía en lo que el implementador dice haber hecho**. Audita solo con evidencia:

1. Lee el **`git diff`** completo del cambio (y `git status` para archivos nuevos).
2. Lee el **`spec.md` aprobado** (RF, CA, propiedades) y `tasks.md`; compara diff ↔ spec: cada RF/CA debe tener código y test en el diff; todo cambio sin RF asociado es **fuera de alcance**.
3. **Ejecuta obligatoriamente en terminal** la suite `test` del Perfil técnico (y `lint` si está definido). **Validación por Exit Code 0**: sin ejecución real no hay veredicto.
4. **Prohibido** aprobar por inspección visual, por "se ve correcto" o por la descripción del implementador.

| Criterio | Estado [SÍ/NO] | Evidencia (diff / salida de terminal + exit code) |
|----------|----------------|---------------------------------------------------|
| Cada RF/CA del spec tiene código y test en el diff | | |
| Cero cambios fuera de alcance del spec | | |
| Tests existentes no debilitados ni borrados | | |
| Cero prints/logs/depuración residual | | |
| Suite `test` ejecutada con Exit Code 0 | | |
| `lint` (si aplica) con Exit Code 0 | | |

Veredicto en la **primera línea**: `VEREDICTO: APROBADO` (todo `SÍ`) o `VEREDICTO: CAMBIOS NECESARIOS` (cualquier `NO` o sin evidencia). El QA no corrige: reporta.

Si el veredicto es `APROBADO` y todas las tareas del módulo están `- [x]`, recuerda al usuario el siguiente paso: `/sdd-archive`.
