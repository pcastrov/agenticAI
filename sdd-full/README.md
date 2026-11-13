# SDD Full — stay-on-rails

Edición Full de **stay-on-rails** (framework SDD ligero, declarativo y sin dependencias). Para herramientas agénticas avanzadas (**Cursor, Claude Code, GitHub Copilot, Pi, OpenCode**) y modelos frontier (ventanas grandes). Flujo completo: Triage + 8 fases, subagentes, diagramas, propiedades y QA a ciegas.

Versión del paquete: **4.2.0** — ver [`.agents/sdd-kit.md`](.agents/sdd-kit.md) · Guía del flujo: [`.agents/sdd-kit/README.md`](.agents/sdd-kit/README.md) · [CHANGELOG](.agents/sdd-kit/CHANGELOG.md)

No combines con **SDD Lite**. Comparativa Full vs Lite: [README de la raíz](../README.md).

---

## Estructura del paquete (origen)

Una sola carpeta de origen: [`.agents/`](.agents/). Al instalarla, su nombre depende de tu herramienta: **`.cursor/`** (Cursor) o **`.agents/`** (las demás). El contenido es el mismo (rutas relativas); solo cambia el nombre. En Cursor, las reglas se instalan como `.mdc`.

```text
sdd-full/
├── README.md                 ← este archivo
├── setup_sdd_full.ps1 / .sh  ← instalador (pide la ruta de tu proyecto)
└── .agents/                  ← paquete (se copia como .cursor/ o .agents/)
    ├── sdd-kit.md            ← edición + versión + source
    ├── sdd-kit/
    │   ├── README.md         ← guía detallada del flujo
    │   └── CHANGELOG.md
    ├── rules/
    │   └── global-sdd.md     ← ANCLAJE + Triage Gate, DRY/KISS/YAGNI, integridad de tests
    ├── commands/             ← slash commands (/sdd-init, /sdd, …)
    ├── subagents/            ← roles: planner, implementer, QA
    └── skills/
        ├── sdd-docs-generator/   ← plantillas de specs / history / diagramas
        └── stack-conventions/    ← guías opcionales por framework
```

### Qué genera el kit en **tu proyecto** (después de `/sdd-init` y `/sdd`)

```text
tu-proyecto/
├── .agents/  (o .cursor/)     ← el kit instalado
├── AGENTS.md                  ← Perfil técnico + gobernanza
├── MEMORY.md
├── docs/constitution.md
└── specs/
    └── 001-nombre-modulo/   ← número real + id kebab (nunca "NNN-...")
        ├── spec.md            ← qué / por qué (tabular)
        ├── plan.md            ← cómo / arquitectura
        ├── tasks.md           ← checklist TDD (- [ ] / - [x])
        ├── diagramas/         ← HU-x-negocio (flowchart) / HU-x-tecnico (secuencia)
        └── history/
            ├── index.md       ← índice ligero (~20 líneas)
            └── <dominio>.md   ← decisiones íntegras por dominio (sin compactar)
```

---

## Comandos (`commands/`)

| Comando | Para qué |
|---------|----------|
| `/sdd-init` | Detecta el stack y crea/actualiza `AGENTS.md`, `MEMORY.md`, `docs/constitution.md` (+ reglas `stack-*` si hay guías). |
| `/sdd` | Orquesta el flujo completo (8 fases): Triage → spec → plan+tareas → TDD → QA → archivo en `history/`. No escribe código de app. |
| `/architect` | Subagente planner: spec, plan+`tasks.md`, iteración, trazabilidad, propiedades o cierre (MODO 6). |
| `/implement` | Subagente implementer: **una** tarea de `tasks.md` con TDD; marca `- [x]`; no archiva. |
| `/review` | QA a ciegas: `git diff` vs `spec.md` + suite en terminal (Exit Code 0); tabla SÍ/NO. |
| `/sdd-archive` | Cierra la iteración: `history/index.md` + `history/<dominio>.md` (prohíbe inventar otros nombres). |
| `/retrofit` | Ingeniería inversa de código existente → specs + history por dominio + deuda. |
| `/sdd-update` | Actualiza el kit en el sitio (`.cursor/` o `.agents/`); no toca tus skills; pregunta antes de migrar `history.md`. |
| `/security` | Auditoría (OWASP / skill del stack) e integración de remediaciones en specs. |
| `/validation-trace` | Cobertura HU ↔ RF ↔ archivo ↔ test. |
| `/validation-properties` | Propiedades de corrección (property-based) vs RF. |
| `/ui-check` | Verificación visual aislada (veredicto corto; sin saturar el hilo con DOM). |
| `/mcp-mode` | Enciende/apaga MCPs pesados (`code` / `ui`) para ahorrar tokens. |

---

## Subagentes (`subagents/` → proyección nativa)

Origen único: `subagents/1-planner.md`, `2-implementer.md`, `3-qa-reviewer.md` (frontmatter `name`: `sdd-planner` / `sdd-implementer` / `sdd-qa-reviewer`).

| Host | Dónde viven al instalar |
|------|-------------------------|
| Cursor | `.cursor/agents/sdd-*.md` (+ copia en `.cursor/subagents/`) |
| Claude Code | `.claude/agents/sdd-*.md` (+ `.agents/subagents/`) |
| OpenCode | `.opencode/agents/sdd-*.md` con `mode: subagent` |
| Copilot / Pi | Solo `<raíz>/subagents/` (sin carpeta nativa) |

| Archivo | Rol | Permisos |
|---------|-----|----------|
| `1-planner.md` | Spec, plan, tasks, diagramas, cierre | Escritura solo `specs/**` + `MEMORY.md` |
| `2-implementer.md` | TDD + fixes de QA; no archiva | Único con escritura completa de código/tests |
| `3-qa-reviewer.md` | Auditoría a ciegas; Exit Code 0; diagnóstico accionable | Lectura + Bash; **sin** editar archivos |

Sin `model:` fijo (heredan el del entorno). En Cursor/Claude/OpenCode, `/sdd` **delegan** al nativo aislado; en Copilot/Pi → chat limpio antes de `/implement` y `/review`.

---

## Skills (`skills/`)

| Skill | Contenido | Uso |
|-------|-----------|-----|
| `sdd-docs-generator/` | Plantillas: `spec`, `plan`, `tasks`, `history-index`, `domain-history`, flowchart negocio + secuencia técnica | Obligatorias al crear docs SDD |
| `stack-conventions/` | Guías opcionales: Laravel, Filament, NativePHP, Django, FastAPI, Flutter | Si no hay guía, el agente usa buenas prácticas del lenguaje **sin error** |

---

## Reglas (`rules/`)

| Archivo | Qué impone |
|---------|------------|
| `global-sdd.md` | **§0 ANCLAJE + Triage Gate** (MEMORY → título de spec → Nivel 0 / 1), integridad de tests, consultas DRY/KISS/YAGNI y de diseño, historial por dominio, convenciones de framework opcionales |

Tras `/sdd-init`, pueden aparecer `rules/stack-*.md` (o `.mdc` en Cursor) copiadas desde `stack-conventions` según tu `conventions` en `AGENTS.md`.

---

## Instalación

Con script (indica la ruta de **tu proyecto**; sin ella, el script muestra un ejemplo y sale):

- Windows: `powershell -ExecutionPolicy Bypass -File ruta\a\sdd-full\setup_sdd_full.ps1 -ProjectPath "C:\Users\tu\mi-proyecto"`
- Mac/Linux: `bash ruta/a/sdd-full/setup_sdd_full.sh "/Users/tu/mi-proyecto"`

Sin script: copia el contenido de `.agents/` a `.cursor/` (Cursor) o `.agents/` (otros) y Ejecuta `/sdd-init`.

Menú del instalador: **1** Cursor · **2** Copilot · **3** Claude Code · **4** Pi (`.pi/extensions/sdd-commands.ts`) · **5** OpenCode (`opencode.json` + **`.opencode/commands/*.md`**).

**OpenCode vs Pi (slash commands):** Pi → `.pi/extensions/`. OpenCode → `.opencode/commands/` (no lee `.agents/commands/` como menú). El `/init` de OpenCode es el **nativo** del host; el del kit es **`/sdd-init`**.

**GATE:** Cursor / OpenCode (`instructions`) / Claude·Copilot (puente): **puntero compacto** en `AGENTS.md` a `rules/global-sdd` §0. Pi / chat libre: GATE **completo** con `[ANCLAJE]`. Plantillas: `skills/sdd-docs-generator/references/init-templates.md`.

### Orden de anclaje (tokens)

`MEMORY` → `AGENTS` → ¿título de carpeta `specs/` encaja? → solo ese módulo → triage → Nivel 0 (código + huella MEMORY) o Nivel 1 (spec → plan → tasks).

**Nativo:** delega `/implement` y `/review` al subagente aislado. **Copilot/Pi:** chat limpio antes de esas fases.

### Presupuesto de tokens (estimación)

> Cifras **orientativas**; varían con tokenizer, specs, diff, tests, MCPs y el system prompt del host (**no** incluido). Detalle comparativo Full vs Lite: [README raíz](../README.md#estimación-de-tokens-orientativa).

| | Estimación |
|--|------------|
| Kit en disco (`.agents/` / `.cursor/`) | ~**45.6K** tok. estáticos (no se cargan todos a la vez) |
| Base fija / turno | ~**5.3–6.7K** (`global-sdd` + `AGENTS` + `MEMORY` + stack) |
| Feature Nivel 1 (8–14 turnos) | ~**120–260K** acumulados · **~90–130K** con aislamiento / chat limpio en TDD y QA |
| Nivel 0 (2–4 turnos) | ~**18–35K** |

## Uso rápido

`/sdd-init` → pedido en lenguaje natural o `/sdd` (**ANCLAJE** luego Triage) · Paradas Nivel 1: OK **spec** → OK **plan** → OK **tasks** → (hilo limpio) cadencia TDD → (hilo limpio) `/review` → `/sdd-archive` · `/retrofit` · `/sdd-update`
