# /ui-check — Verificación visual aislada

Ejecuta `ui_check` (Playwright, Chrome DevTools u otra herramienta del Perfil técnico) **fuera del hilo de implementación**, para no saturar el contexto con DOM.

## Instrucción
1. Lee `ui_check` del `## Perfil técnico` y la ruta/URL o criterio que indicó el usuario (o la tarea `Tx`).
2. Preferencias:
   - Subagente / sesión con MCP de navegador **solo para este chequeo**, o
   - CLI (`npx playwright`, skill `chrome-devtools-cli`, etc.) vía terminal.
3. 🚫 No pegues el DOM completo ni dumps largos en el chat principal.
4. Devuelve **solo** un veredicto ≤5 líneas:

```
UI-CHECK: PASS | FAIL
- URL/ruta: [...]
- Criterio: [...]
- Hallazgo: [1–3 líneas; si FAIL, selector/error de consola]
- Evidencia: [ruta de screenshot o log corto, si aplica]
```

5. Si **FAIL**: no auto-arregles código ni tests. Entrega el veredicto al implementer/QA para `REPORTE DE FALLO` (`global-sdd` §0 y §2.1).
