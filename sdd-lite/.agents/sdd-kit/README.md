# SDD Lite — Spec-Driven Development para modelos locales (8B–14B, 16K–32K)

Copia el contenido de **`sdd-lite/.agents/`** a la raíz del proyecto como **`.cursor/`** (Cursor) o **`.agents/`** (otros): mismo contenido, solo cambia el nombre. No combines con el paquete Full. Todas las rutas internas son relativas.

## Instalación
1. Copia `sdd-lite/.agents/` → `.cursor/` (Cursor) o `.agents/` (otros), o corre `setup_sdd_lite.sh` / `.ps1`.
2. `/sdd-init` → Trinidad liviana.
3. Cambios: `/sdd` (Triage) → `/implement` → `/sdd-archive`.
4. Actualizar: `/sdd-update` (compara `sdd-lite/.agents/` del `source` contra tu carpeta en el sitio).

## Presupuesto
Reglas + spec del módulo ≈ 3–3.5K tokens. Spec ≤150 líneas; índice de historial ≤30; shard de dominio ≤100.

## Archivos del paquete
```text
sdd-kit.md
sdd-kit/README.md
sdd-kit/CHANGELOG.md
rules/global-sdd.md
subagents/1-planner.md
subagents/2-implementer.md
subagents/3-qa-reviewer.md
commands/sdd-init.md
commands/sdd.md
commands/implement.md
commands/sdd-archive.md
commands/sdd-update.md
commands/ui-check.md
commands/mcp-mode.md
commands/architect.md
commands/review.md
commands/retrofit.md
skills/sdd-docs-generator/...
skills/stack-conventions/...
skills/on-demand-tools/SKILL.md
```

## Hosts
Cualquier agente (Cursor, VS Code + Ollama/Copilot, OpenCode, Pi…): preferir MCP navegador off (`/mcp-mode code`) y `/ui-check` o CLI (`on-demand-tools`).
