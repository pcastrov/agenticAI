# SDD Lite Compacto (v3.0.0)

Edición compacta (Micro-Spec, topes bajos) para ventanas **8K / 16K / 32K**. Misma familia de hosts que Full; **recomendación** según si el modelo es local o no.

- GPU tipica de diseño ~8 GB · modelos locales **8B–14B** cuantizados (Ollama)
- Micro-Specs + MEMORY activa + 2 paradas (Qué / Cómo) + aislamiento de contexto
- Sin `plan.md`/`tasks.md`/diagramas; history condensado; `on-demand-tools`; QA determinista

Versión: **3.0.0** — [`.agents/sdd-kit.md`](.agents/sdd-kit.md) · [CHANGELOG](.agents/sdd-kit/CHANGELOG.md) · [Guía](.agents/sdd-kit/README.md)

No combines con **SDD Full**. Comparativa: [README raíz](../README.md).

### ¿Qué host usar?

| Situación | Recomendación |
|-----------|----------------|
| **Modelo local** (~8 GB VRAM, Ollama) | **Pi** (más liviano) u **OpenCode** |
| **Modelo cloud / no local** (API frontier) | **Cursor**, **VS Code + Copilot**, **Claude Code**, Pi u OpenCode — Lite funciona igual |
| **Local + Cursor/Copilot/Claude** | Viable si la GPU es **> ~8 GB**; ahí suele ir bien e incluso puedes **subir el contexto** |

Contexto típico local: **8K / 16K / 32K** (buen tokens/s). Más contexto es posible, pero suele bajar el throughput por overhead.

---

## Origen del paquete

```text
sdd-lite/
├── README.md
├── setup_sdd_lite.ps1 / .sh
└── .agents/                  ← se instala como .cursor/ (Cursor) o .agents/ (resto)
    ├── rules/global-sdd.md
    ├── commands/ · subagents/
    └── skills/ (docs, stack, on-demand-tools)
```

### En tu proyecto

```text
AGENTS.md (≤45) · MEMORY.md (≤30) · docs/constitution.md
specs/001-<id>/
├── spec.md              ← Parte 1 Qué | Parte 2 Cómo+Tareas (1 HU · ≤5 tareas · ~85 líneas)
└── history/
    ├── index.md         ← ≤30
    └── <dominio>.md     ← ≤100
```

---

## Flujo

`/sdd-init` → **[ANCLAJE]** → Triage →  
Nivel 1: **Qué** 🛑 OK → **Cómo+Tareas** 🛑 OK → cadencia A|B → `/implement` (nativo aislado o chat limpio) → `/review` → `/sdd-archive`

Nivel 0: ≤1 archivo, <15 líneas, sin BD (+ 1 línea MEMORY si aporta).

## Hosts (instalador)

| Host | Dónde queda el kit |
|------|--------------------|
| Cursor | `.cursor/` (+ `.cursor/agents/`) |
| GitHub Copilot (VS Code) | `.agents/` + `.github/copilot-instructions.md` |
| Claude Code | `.agents/` + `CLAUDE.md` + `.claude/agents/` |
| Pi | `.agents/` + `.pi/extensions/sdd-commands.ts` |
| OpenCode | `.agents/` + `opencode.json` + `.opencode/commands/` + `.opencode/agents/` |

## Instalación

- Mac/Linux: `bash ruta/a/sdd-lite/setup_sdd_lite.sh "/ruta/proyecto"`
- Windows: `powershell -ExecutionPolicy Bypass -File ruta\a\sdd-lite\setup_sdd_lite.ps1 -ProjectPath "C:\ruta\proyecto"`

Menú: **1 Cursor · 2 Copilot · 3 Claude · 4 Pi · 5 OpenCode**. Actualizar: `/sdd-update`.

## Tokens (estimación)

> Cifras **orientativas**; varían. Comparativa: [README raíz](../README.md#estimación-de-tokens-orientativa).

| | Estimación |
|--|------------|
| Kit en disco | ~**8.0K** tok. estáticos |
| Base fija / turno | ~**1.5–1.6K** |
| Turno + Micro-Spec | ~**2–3.5K** |
| Feature Nivel 1 (acumulado) | ~**30–65K** |

UI: `/mcp-mode code` + `/ui-check`. Boost Laravel: `guidelines: false`.
