# SDD Lite Compacto (v3.0.0)

Full Compacto para **modelos locales** y ventanas **8K–32K** (Ollama, Pi, OpenCode; también Cursor/Claude/Copilot).

- GPU ~8 GB · modelos **8B–14B** cuantizados
- Micro-Specs + MEMORY activa + 2 paradas (Qué / Cómo) + aislamiento de contexto
- Sin `plan.md`/`tasks.md`/diagramas; history condensado; `on-demand-tools`; QA determinista

Versión: **3.0.0** — [`.agents/sdd-kit.md`](.agents/sdd-kit.md) · [CHANGELOG](.agents/sdd-kit/CHANGELOG.md) · [Guía](.agents/sdd-kit/README.md)

No combines con **SDD Full**. Comparativa: [README raíz](../README.md).

---

## Origen del paquete

```text
sdd-lite/
├── README.md
├── setup_sdd_lite.ps1 / .sh
└── .agents/                  ← se instala como .cursor/ o .agents/
    ├── rules/global-sdd.md   ← ANCLAJE + Micro-Spec + topes
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
Nivel 1: **Qué** 🛑 OK → **Cómo+Tareas** 🛑 OK → cadencia A|B → `/implement` (1 tarea; nativo aislado o chat limpio) → `/review` (tests silenciosos) → `/sdd-archive`

Nivel 0: ≤1 archivo, <15 líneas, sin BD (+ 1 línea MEMORY si aporta).

## Subagentes nativos

`sdd-planner` · `sdd-implementer` · `sdd-qa-reviewer`  
Cursor → `.cursor/agents/` · Claude → `.claude/agents/` · OpenCode → `.opencode/agents/` (`mode: subagent`) · Pi/Copilot → `subagents/`

## Instalación

- Mac/Linux: `bash ruta/a/sdd-lite/setup_sdd_lite.sh "/ruta/proyecto"`
- Windows: `powershell -ExecutionPolicy Bypass -File ruta\a\sdd-lite\setup_sdd_lite.ps1 -ProjectPath "C:\ruta\proyecto"`

Menú: 1 Cursor · 2 Copilot · 3 Claude · 4 Pi · 5 OpenCode. Actualizar: `/sdd-update`.

## Tokens

Turno tipico ≈ **2–3.5K** (ANCLAJE + Perfil + Micro-Spec). UI: `/mcp-mode code` + `/ui-check`. Boost Laravel: `guidelines: false`.
