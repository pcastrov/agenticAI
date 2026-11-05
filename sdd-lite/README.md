# SDD Lite

Edición del kit para **modelos locales** en hardware modesto. El presupuesto de tokens se midió y diseñó para un escenario como este:

- **GPU ~8 GB VRAM**
- **Ollama** con ventana **32K** (a veces 16K)
- Modelos **8B–14B** que quepan ahí (cuantizados), p. ej. **Qwen 2.5 Coder 14B**, y otros **9B / 8B** coder/instruct
- Cliente de agente: **Pi** (ideal, más liviano) u **OpenCode**; también Cursor, VS Code + Copilot/Ollama (más overhead)

Versión del paquete: **2.0.2** — ver [`.agents/sdd-kit.md`](.agents/sdd-kit.md) · Guía: [`.agents/sdd-kit/README.md`](.agents/sdd-kit/README.md) · [CHANGELOG](.agents/sdd-kit/CHANGELOG.md)

No instales Full y Lite a la vez. Comparativa y tokens: [README de la raíz](../README.md).

---

## Estructura del paquete (origen)

Una sola carpeta de origen: [`.agents/`](.agents/). Al instalar: **`.cursor/`** (Cursor) o **`.agents/`** (otros). Mismo contenido; solo cambia el nombre. En Cursor, las reglas pasan a `.mdc`.

```text
sdd-lite/
├── README.md                 ← este archivo
├── setup_sdd_lite.ps1 / .sh  ← instalador (pide la ruta de tu proyecto)
└── .agents/                  ← paquete (se copia como .cursor/ o .agents/)
    ├── sdd-kit.md
    ├── sdd-kit/
    │   ├── README.md
    │   └── CHANGELOG.md
    ├── rules/
    │   └── global-sdd.md     ← Triage Gate + integridad de tests (versión Lite)
    ├── commands/             ← slash commands (/init, /sdd, …)
    ├── subagents/            ← planner / implementer / QA (condensados)
    └── skills/
        ├── sdd-docs-generator/   ← plantillas tabulares + shards ≤100 líneas
        ├── stack-conventions/    ← guías opcionales (versión condensada)
        └── on-demand-tools/      ← CLI UI/devtools bajo demanda (0 tokens en reposo)
```

### Qué genera el kit en **tu proyecto** (después de `/init` y `/sdd`)

```text
tu-proyecto/
├── .agents/  (o .cursor/)
├── AGENTS.md
├── MEMORY.md
├── docs/constitution.md
└── specs/
    └── NNN-nombre-modulo/
        ├── spec.md              ← tabular (Entradas / Salidas / CA / tareas)
        └── history/
            ├── index.md         ← ≤30 líneas (solo índice de dominios)
            └── <dominio>.md     ← shard ≤100 líneas (contratos / endpoints; sin prosa)
```

Lite **no** usa `plan.md` / `tasks.md` separados: las tareas viven dentro de `spec.md`. El historial se **condensa** por dominio (ficha atómica), a diferencia de Full (decisiones íntegras).

---

## Comandos (`commands/`)

| Comando | Para qué |
|---------|----------|
| `/init` | Trinidad liviana: `AGENTS.md` + constitution corta + `MEMORY.md` + Perfil técnico. |
| `/sdd` | Planear: Triage (Nivel 0 directo \| Nivel 1 Spec tabular **sin código**) y espera aprobación. |
| `/architect` | Planner Lite: spec unificada, iterar o archivar shards de dominio. |
| `/implement` | Una tarea `- [ ]` de `spec.md` con TDD; marca `- [x]`; no archiva. |
| `/review` | Tabla determinista de 4 criterios + evidencia; **puede crear tests faltantes**. |
| `/sdd-archive` | Escribe/actualiza `history/<dominio>.md` (≤100 líneas) + `history/index.md` (≤30). |
| `/retrofit` | Ingeniería inversa condensada → `spec.md` + shards por dominio. |
| `/sdd-update` | Actualiza el kit en el sitio; no toca skills del usuario; pregunta antes de migrar history monolítico. |
| `/ui-check` | Veredicto visual corto (ideal con `on-demand-tools`, sin MCP siempre-on). |
| `/mcp-mode` | `code` por defecto; enciende UI solo cuando hace falta. |

Lite **no incluye** `/security`, `/validation-trace` ni `/validation-properties` (están en Full).

---

## Subagentes (`subagents/`)

| Archivo | Rol |
|---------|-----|
| `1-planner.md` | Spec atómico / iterar / archivar shards / trazabilidad corta. Solo escribe en `specs/`. |
| `2-implementer.md` | Una tarea TDD; reporte de fallo y STOP si el test/UI falla. |
| `3-qa-reviewer.md` | Audita spec o código; en implementación crea tests faltantes y exige Exit Code 0. |

---

## Skills (`skills/`)

| Skill | Contenido | Uso |
|-------|-----------|-----|
| `sdd-docs-generator/` | `spec-template.md`, `history-index-template.md`, `domain-shard-template.md` | Specs e historial compactos |
| `stack-conventions/` | Guías Lite: Laravel, Filament, NativePHP, Django, FastAPI, Flutter | Opcionales; si faltan, sin error |
| `on-demand-tools/` | Recetas Playwright / DevTools / artisan bajo demanda | Solo cuando la tarea toca UI o schema |

---

## Reglas (`rules/`)

| Archivo | Qué impone |
|---------|------------|
| `global-sdd.md` | Triage Gate Nivel 0/1, integridad de tests, topes de líneas (spec/history), convenciones de framework opcionales |

---

## Instalación (script)

Desde la raíz de **tu proyecto**:

- Windows: `powershell -ExecutionPolicy Bypass -File ruta\a\sdd-lite\setup_sdd_lite.ps1 -ProjectPath "C:\Users\tu\mi-proyecto"`
- Mac/Linux: `bash ruta/a/sdd-lite/setup_sdd_lite.sh "/Users/tu/mi-proyecto"`
- Sin ruta del proyecto: el script muestra un ejemplo y sale.

El script instala en **`.cursor/`** (Cursor) o **`.agents/`** (otros), crea el puente solo si hace falta (Copilot / Claude) y puede dejar solo la guía de tu framework.

Menú del instalador: **1** Cursor · **2** Copilot · **3** Claude Code · **4** Pi (genera `.pi/extensions/sdd-commands.ts`) · **5** OpenCode (solo `.agents/`, sin extensión de Pi).

Manual: copia el contenido de [`.agents`](.agents/) a `.cursor/` o `.agents/`.

## Flujo rápido

`/init` → Triage (también sin `/sdd`) → Spec + 🛑 OK → `[CADENCIA TDD]` A|B → `/implement` → `/review` → `/sdd-archive`

## Tokens / MCP

Kit + spec del módulo ≈ **3–3.5K** por turno normal. Usa `/mcp-mode code` por defecto. UI: `/ui-check` o skill `on-demand-tools`. Boost (Laravel): `guidelines: false`.
