# /sdd-init (Lite)

Genera Trinidad liviana para modelos 16K–32K.

## PASO 0 — Lectura obligatoria
Abre `sdd-kit.md` (debe decir `edition: lite`) y `rules/global-sdd.md` §0.

1. Comprueba `sdd-lite` instalado. Detecta la carpeta raíz del framework (`.cursor/` si el host es Cursor, `.agents/` en otro caso) y úsala en toda ruta que escribas en `AGENTS.md`/constitution.
2. Detecta stack o entrevista corta.
3. Escribe `## Perfil técnico` (mismas claves que Full).
4. `docs/constitution.md`: ≤12 líneas (simplicidad, relación spec-código, tests, datos, idioma).
5. `AGENTS.md`: **primero** el bloque GATE (abajo), luego hechos + Perfil + Código Compartido. OpenCode/Pi leen `AGENTS.md` (no confíes solo en `rules/`). Sin Boost guidelines.

   ```markdown
   ## Gobernanza SDD (GATE)
   Detalle: `<raíz>/rules/global-sdd.md`. Aplica **sin** `/sdd`.
   Antes de editar código/tests: emite `[TRIAGE SDD]` (0 FAST-TRACK | 1 SDD-REQUIRED).
   Nivel 1 → Spec tabular + 🛑 OK; **prohibido** código en ese turno.
   Luego `[CADENCIA TDD]` A una-a-una | B lote (default A). Test rojo → REPORTE DE FALLO.
   ```
6. Laravel: opcional Boost con `"guidelines": false`, `"mcp": true`. MCP navegador: off (ver `/mcp-mode`).
7. `MEMORY.md` ≤40 líneas.
8. 🛑 Aprueba antes de escribir.
9. Copia guías lite de `conventions` a `../rules/stack-*.md` (`.mdc` si el host es Cursor) si aplica.
