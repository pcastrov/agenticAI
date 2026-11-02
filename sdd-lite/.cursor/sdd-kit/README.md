# SDD Lite — Spec-Driven Development para modelos locales (16K–32K)

Copia **`sdd-lite/.cursor/`** (o `.agents/`) a la raíz del proyecto. No combines con el paquete Full en el mismo proyecto.

## Instalación
1. Copia `sdd-lite/.cursor/` → `.cursor/` del proyecto (o `.agents/`).
2. `/init` → Trinidad liviana.
3. Cambios: `/sdd` → `/implement` → `/sdd-archive`.
4. Actualizar: `/sdd-update` (compara `sdd-lite/.cursor` del `source`).

## Presupuesto
Reglas + docs del módulo ≈ 3–3.5K tokens. Historial shard ≤150 líneas; máx 3 recientes + `h-archive.md`.

## Archivos del paquete
```text
.cursor/sdd-kit.md
.cursor/sdd-kit/README.md
.cursor/sdd-kit/CHANGELOG.md
.cursor/rules/global-sdd.mdc
.cursor/subagents/1-planner.md
.cursor/subagents/2-implementer.md
.cursor/subagents/3-qa-reviewer.md
.cursor/commands/init.md
.cursor/commands/sdd.md
.cursor/commands/implement.md
.cursor/commands/sdd-archive.md
.cursor/commands/sdd-update.md
.cursor/commands/ui-check.md
.cursor/commands/mcp-mode.md
.cursor/commands/architect.md
.cursor/commands/review.md
.cursor/commands/retrofit.md
.cursor/skills/sdd-docs-generator/...
.cursor/skills/stack-conventions/...
.cursor/skills/on-demand-tools/SKILL.md
```

## Hosts
Cursor, VS Code + Ollama/Copilot, OpenCode, Pi: preferir MCP navegador off (`/mcp-mode code`) y `/ui-check` o CLI (`on-demand-tools`).
