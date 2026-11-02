# SDD Lite — Spec-Driven Development para modelos locales (16K–32K)

Copia **`sdd-lite/.agents/`** (o `.agents/`) a la raíz del proyecto. No combines con el paquete Full en el mismo proyecto.

## Instalación
1. Copia `sdd-lite/.agents/` → `.agents/` del proyecto (o `.agents/`).
2. `/init` → Trinidad liviana.
3. Cambios: `/sdd` → `/implement` → `/sdd-archive`.
4. Actualizar: `/sdd-update` (compara `sdd-lite/.agents` del `source`).

## Presupuesto
Reglas + docs del módulo ≈ 3–3.5K tokens. Historial shard ≤150 líneas; máx 3 recientes + `h-archive.md`.

## Archivos del paquete
```text
.agents/sdd-kit.md
.agents/sdd-kit/README.md
.agents/sdd-kit/CHANGELOG.md
.agents/rules/global-sdd.md
.agents/subagents/1-planner.md
.agents/subagents/2-implementer.md
.agents/subagents/3-qa-reviewer.md
.agents/commands/init.md
.agents/commands/sdd.md
.agents/commands/implement.md
.agents/commands/sdd-archive.md
.agents/commands/sdd-update.md
.agents/commands/ui-check.md
.agents/commands/mcp-mode.md
.agents/commands/architect.md
.agents/commands/review.md
.agents/commands/retrofit.md
.agents/skills/sdd-docs-generator/...
.agents/skills/stack-conventions/...
.agents/skills/on-demand-tools/SKILL.md
```

## Hosts
Cursor, VS Code + Ollama/Copilot, OpenCode, Pi: preferir MCP navegador off (`/mcp-mode code`) y `/ui-check` o CLI (`on-demand-tools`).
