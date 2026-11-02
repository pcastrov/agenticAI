# SDD Lite

Edición del kit para **modelos locales** en hardware modesto. El presupuesto de tokens se midió y diseñó para un escenario como este:

- **GPU ~8 GB VRAM**
- **Ollama** con ventana **32K** (a veces 16K)
- Modelos **8B–14B** que quepan ahí (cuantizados), p. ej. **Qwen 2.5 Coder 14B**, y otros **9B / 8B** coder/instruct
- Cliente de agente: **Pi** (ideal, más liviano) u **OpenCode**; también VS Code + Copilot/Ollama (más overhead)

## Qué copiar
- Cursor / VS Code: carpeta [`.cursor`](.cursor/) → raíz del proyecto como `.cursor/`
- Otros agentes (Pi, OpenCode…): [`.agents`](.agents/) → `.agents/`

No instales Full y Lite a la vez en el mismo proyecto.

## Flujo
`/init` → `/sdd` (planear) → `/implement` → `/sdd-archive`

Specs: `spec.md` + `summary.md` + `history/h-NN.md` (máx 3 shards + `h-archive.md`).

## Tokens / MCP
Kit + docs del módulo ≈ **3–3.5K** por turno normal. Usa `/mcp-mode code` por defecto. UI: `/ui-check` o skill `on-demand-tools`. Boost: `guidelines: false`.

En el repo, Full vive en [`../sdd-full/`](../sdd-full/) y Lite aquí — carpetas hermanas; la raíz solo tiene el índice.

Números y tabla Full vs Lite: [README de la raíz](../README.md).

Detalle del paquete: [`.cursor/sdd-kit/README.md`](.cursor/sdd-kit/README.md).