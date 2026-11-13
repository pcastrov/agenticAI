# /sdd-init (Lite Compacto)

Trinidad para 8K–32K. Topes: `AGENTS.md` ≤45 · `MEMORY.md` ≤30 · constitution ≤12.

## PASO 0
Lee `sdd-kit.md` (`edition: lite`) + `global-sdd` §0. Detecta `<raíz>` (`.cursor`|`.agents`).

1. Detecta stack o entrevista corta → `## Perfil técnico`.
2. `docs/constitution.md` ≤12 líneas.
3. **GATE en `AGENTS.md`** (primera sección):
   - Auto-carga (Cursor / OpenCode+`instructions` / Claude·Copilot puente) → **puntero**:
     ```markdown
     ## Gobernanza SDD (GATE)
     Antes de editar: ejecuta `<raíz>/rules/global-sdd.md` §0 (`[ANCLAJE]` → `[TRIAGE SDD]`).
     Aplica con o sin `/sdd`. No dupliques el GATE aquí.
     ```
   - Pi / chat libre → GATE completo corto (ANCLAJE 3 líneas + Triage 0/1 + cadencia A|B + REPORTE).
4. Hechos + Perfil + Código Compartido (dentro del tope 45).
5. `MEMORY.md` ≤30.
6. Laravel: Boost opcional `guidelines: false`. MCP UI off.
7. `stack-*.md` si hay `conventions`. `specs/` vacía; no `NNN-...`.
8. 🛑 Aprueba antes de escribir.
