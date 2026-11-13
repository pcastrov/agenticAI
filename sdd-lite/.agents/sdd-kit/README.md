# SDD Lite Compacto — stay-on-rails (8K / 16K / 32K)

**stay-on-rails**: framework ligero, declarativo y sin dependencias para desarrollo asistido por agentes de IA bajo SDD. Esta edición es la compacta (Micro-Spec) para ventanas cortas. Instala en Cursor, Copilot (VS Code), Claude Code, Pi u OpenCode.

**Recomendación:** modelos **locales** (~8 GB) → **Pi** / **OpenCode**. Modelos **cloud** → cualquier host. Local + Cursor/Copilot/Claude → mejor con GPU **> ~8 GB** (puedes subir contexto).

Copia `sdd-lite/.agents/` → `.cursor/` (Cursor) o `.agents/` (otros). No combines con Full.

## Instalación
1. `setup_sdd_lite.sh` / `.ps1` (menú 1–5).
2. `/sdd-init` (GATE compacto si el host auto-carga `global-sdd`; Pi: completo).
3. `/sdd` → 2 paradas Micro-Spec → `/implement` → `/review` → `/sdd-archive`.
4. `/sdd-update`.

## Presupuesto (líneas)
| Pieza | Tope |
|-------|------|
| `AGENTS.md` | 45 líneas |
| `MEMORY.md` | 30 |
| `spec.md` | ~85 · 1 HU · ≤5 tareas |
| `history/index.md` | 30 |
| `history/<dominio>.md` | 100 |

## Tokens (estimación)

> **Estimaciones**; varían. Detalle: README raíz.

| | Tok. est. |
|--|-----------|
| Kit `.agents/` en disco | ~7.97K |
| Base fija / turno | ~1.5–1.6K |
| Turno + subagente + `spec.md` | ~2–3.5K |
| Feature Nivel 1 acumulada | ~30–65K |

## Archivos del paquete
```text
sdd-kit.md · sdd-kit/README.md · sdd-kit/CHANGELOG.md
rules/global-sdd.md
subagents/1-planner.md · 2-implementer.md · 3-qa-reviewer.md
commands/… · skills/…
```

## Hosts
Nativos: `.cursor/agents/`, `.claude/agents/`, `.opencode/agents/` (`mode: subagent`). Copilot/Pi: `subagents/` + chat limpio entre tareas.
