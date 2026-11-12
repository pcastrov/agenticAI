# SDD Lite Compacto — 8K–32K

Copia `sdd-lite/.agents/` → `.cursor/` (Cursor) o `.agents/` (otros). No combines con Full.

## Instalación
1. `setup_sdd_lite.sh` / `.ps1` o copia manual.
2. `/sdd-init` (GATE compacto si auto-carga `global-sdd`; Pi: completo).
3. `/sdd` → 2 paradas Micro-Spec → `/implement` → `/review` → `/sdd-archive`.
4. `/sdd-update`.

## Presupuesto
| Pieza | Tope |
|-------|------|
| `AGENTS.md` | 45 líneas |
| `MEMORY.md` | 30 |
| `spec.md` | ~85 · 1 HU · ≤5 tareas |
| `history/index.md` | 30 |
| `history/<dominio>.md` | 100 |

Turno ≈ 2–3.5K tokens. ANCLAJE → Triage → Micro-Spec.

## Archivos del paquete
```text
sdd-kit.md · sdd-kit/README.md · sdd-kit/CHANGELOG.md
rules/global-sdd.md
subagents/1-planner.md · 2-implementer.md · 3-qa-reviewer.md
commands/sdd-init · sdd · architect · implement · review · sdd-archive · sdd-update · retrofit · ui-check · mcp-mode
skills/sdd-docs-generator/** · stack-conventions/** · on-demand-tools/SKILL.md
```

## Hosts
Nativos: `.cursor/agents/`, `.claude/agents/`, `.opencode/agents/`. Copilot/Pi: `subagents/` + chat limpio entre tareas.
