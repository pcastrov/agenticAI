# /review — Auditoría a ciegas contra la Spec

## PASO 0 — Lectura / delegación
1. **Nativo** (Cursor / Claude Code / OpenCode): delega en **`sdd-qa-reviewer`** aislado (Task / `@sdd-qa-reviewer`) para no acumular ruido en el hilo principal. Pásale solo: modo (1–4), rutas `AGENTS.md` + `spec.md` (+ `plan.md`/`tasks.md` según modo) y, en MODO 2, que ejecute `git diff`/`status` + suite. Exige **primera línea** `VEREDICTO: …`, tabla corta y, si aplica, `Diagnóstico y sugerencia de corrección`.
2. **Fallback** (Copilot / Pi): recomienda **chat limpio** antes de `/review`; lee `subagents/3-qa-reviewer.md` en ese hilo.

## Auditoría de implementación (MODO 2): "a ciegas"
El QA **no confía en lo que el implementador dice haber hecho**. Audita solo con evidencia:

1. Lee el **`git diff`** completo del cambio (y `git status` para archivos nuevos).
2. Lee el **`spec.md` aprobado** (RF, CA, propiedades) y `tasks.md`; compara diff ↔ spec: cada RF/CA debe tener código y test en el diff; todo cambio sin RF asociado es **fuera de alcance**.
3. **Ejecuta obligatoriamente en terminal** la suite `test` del Perfil técnico (y `lint` si está definido). **Validación por Exit Code 0**: sin ejecución real no hay veredicto. Incluye Playwright / Chrome DevTools CLI si el módulo lo exige (`ui_check`).
4. **Prohibido** aprobar por inspección visual, por "se ve correcto" o por la descripción del implementador.
5. **El QA nunca edita código** ni tests: solo reporta. Los fixes los aplica `sdd-implementer`.

| Criterio | Estado [SÍ/NO] | Evidencia (diff / salida de terminal + exit code) |
|----------|----------------|---------------------------------------------------|
| Cada RF/CA del spec tiene código y test en el diff | | |
| Cero cambios fuera de alcance del spec | | |
| Tests existentes no debilitados ni borrados | | |
| Cero prints/logs/depuración residual | | |
| Suite `test` ejecutada con Exit Code 0 | | |
| `lint` (si aplica) con Exit Code 0 | | |
| UI/`ui_check` (si aplica) con Exit Code 0 | | |

Veredicto en la **primera línea**: `VEREDICTO: APROBADO` (todo `SÍ`) o `VEREDICTO: CAMBIOS NECESARIOS` (cualquier `NO` o sin evidencia).

Si el veredicto es `VEREDICTO: CAMBIOS NECESARIOS` (test rojo, fallo Playwright/DevTools o desviación contra `spec.md`), **debajo de la tabla** añade:

```
## Diagnóstico y sugerencia de corrección
| Archivo afectado | Causa raíz | Propuesta concreta de arreglo (para sdd-implementer) |
|------------------|------------|------------------------------------------------------|
| ruta/archivo     | …          | …                                                    |
```

Si el veredicto es `APROBADO` y todas las tareas del módulo están `- [x]`, recuerda al usuario el siguiente paso: `/sdd-archive`.
