# SDD Lite

Edición del kit para **modelos locales** en hardware modesto. El presupuesto de tokens se midió y diseñó para un escenario como este:

- **GPU ~8 GB VRAM**
- **Ollama** con ventana **32K** (a veces 16K)
- Modelos **8B–14B** que quepan ahí (cuantizados), p. ej. **Qwen 2.5 Coder 14B**, y otros **9B / 8B** coder/instruct
- Cliente de agente: **Pi** (ideal, más liviano) u **OpenCode**; también Cursor, VS Code + Copilot/Ollama (más overhead)

## Instalación (script)
Desde la raíz de **tu proyecto**:

- Windows: `powershell -ExecutionPolicy Bypass -File ruta\a\sdd-lite\setup_sdd_lite.ps1 -ProjectPath "C:\Users\tu\mi-proyecto"`
- Mac/Linux: `bash ruta/a/sdd-lite/setup_sdd_lite.sh "/Users/tu/mi-proyecto"`
- Sin ruta del proyecto: el script muestra un ejemplo y sale.

El script instala el paquete en **`.cursor/`** si usas Cursor o en **`.agents/`** si usas otra herramienta (mismo contenido), crea el archivo puente solo si tu agente lo necesita y deja solo la guía de tu framework.

Con **Pi / OpenCode / Cline** el script genera además `.pi/extensions/sdd-commands.ts` (slash commands que apuntan a `.agents/commands/*.md`).

Manual: copia el contenido de [`.agents`](.agents/) a `.cursor/` (Cursor) o `.agents/` (otros). Mismo contenido; solo cambia el nombre.

No instales Full y Lite a la vez en el mismo proyecto.

## Flujo
`/init` → `/sdd` (Triage: Nivel 0 directo | Nivel 1 Spec sin código) → `/implement` → `/sdd-archive`

Specs: `spec.md` (tabular) + `history/index.md` (≤30 líneas) + `history/<dominio>.md` (≤100 líneas).

## Tokens / MCP
Kit + spec del módulo ≈ **3–3.5K** por turno normal. Usa `/mcp-mode code` por defecto. UI: `/ui-check` o skill `on-demand-tools`. Boost: `guidelines: false`.

En el repo, Full vive en [`../sdd-full/`](../sdd-full/) y Lite aquí — carpetas hermanas; la raíz solo tiene el índice.

Números y tabla Full vs Lite: [README de la raíz](../README.md).

Detalle del paquete: [`.agents/sdd-kit/README.md`](.agents/sdd-kit/README.md).
