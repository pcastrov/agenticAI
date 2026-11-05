# /init (Lite)

Genera Trinidad liviana para modelos 16K–32K.

## PASO 0 — Lectura obligatoria
Abre `sdd-kit.md` (debe decir `edition: lite`) y `rules/global-sdd.md` §0.

1. Comprueba `sdd-lite` instalado. Detecta la carpeta raíz del framework (`.cursor/` si el host es Cursor, `.agents/` en otro caso) y úsala en toda ruta que escribas en `AGENTS.md`/constitution.
2. Detecta stack o entrevista corta.
3. Escribe `## Perfil técnico` (mismas claves que Full).
4. `docs/constitution.md`: ≤12 líneas (simplicidad, relación spec-código, tests, datos, idioma).
5. `AGENTS.md`: hechos + Perfil + Código Compartido vacío + **Gobernanza** (3 líneas apuntando a `<raíz>/rules/global-sdd.md` GATE). Sin Boost guidelines.
6. Laravel: opcional Boost con `"guidelines": false`, `"mcp": true`. MCP navegador: off (ver `/mcp-mode`).
7. `MEMORY.md` ≤40 líneas.
8. 🛑 Aprueba antes de escribir.
9. Copia guías lite de `conventions` a `../rules/stack-*.md` (`.mdc` si el host es Cursor) si aplica.
