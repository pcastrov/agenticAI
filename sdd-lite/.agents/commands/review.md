# /review (Lite)

## PASO 0
- **Nativo**: delega `sdd-qa-reviewer` aislado (rutas `AGENTS` + `spec.md` + diff).
- **Fallback**: lee `3-qa-reviewer`; preferible chat limpio tras TDD.

Crea tests faltantes; **no** edites producción.

## Pasos
1. Cada CA → test; si falta, créalo.
2. Ejecuta `test`/`test_single` (y `lint` si hay) con flags **compactos** si existen: `-q`, `--compact`, `--reporter=dot`, `--quiet`. Sin logs largos en el hilo.
3. Diff vs Spec (Archivos / Diseño).
4. Solo esta tabla:

| Criterio | SÍ/NO | Evidencia (diff / exit code) |
|----------|-------|------------------------------|
| Cada CA tiene test y pasa | | |
| Cero fuera de alcance | | |
| Cero prints/logs residuales | | |
| Exit Code 0 (tests; lint si aplica) | | |

Cualquier NO → `CAMBIOS NECESARIOS`. Todo SÍ → `APROBADO` → `/sdd-archive` si no quedan `- [ ]`.
