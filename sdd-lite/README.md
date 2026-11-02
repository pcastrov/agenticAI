# SDD Lite

Edición del kit para **modelos locales 8B–14B** (ventana típica **16K–32K**): Pi, OpenCode, VS Code + Ollama/Copilot, Cursor con modelo local.

## Qué copiar
- Cursor / VS Code: carpeta [`/.cursor`](.cursor/) → raíz del proyecto como `.cursor/`
- Otros agentes: [`/.agents`](.agents/) → `.agents/`

No instales Full y Lite a la vez en el mismo proyecto.

## Flujo
`/init` → `/sdd` (planear) → `/implement` → `/sdd-archive`

Specs: `spec.md` + `summary.md` + `history/h-NN.md` (máx 3 shards + `h-archive.md`).

## Tokens / MCP
Usa `/mcp-mode code` por defecto. UI: `/ui-check` o skill `on-demand-tools`. Boost: `guidelines: false`.

Detalle: [`.cursor/sdd-kit/README.md`](.cursor/sdd-kit/README.md).
