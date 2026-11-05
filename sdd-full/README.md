# SDD Full

Edición para herramientas agénticas avanzadas (**Cursor, Claude Code, GitHub Copilot, Pi, OpenCode**) y modelos frontier (ventanas grandes). Flujo completo: Triage + 8 fases, subagentes, diagramas, propiedades y QA a ciegas.

Versión del paquete: **4.0.2** — ver [`.agents/sdd-kit.md`](.agents/sdd-kit.md) · Guía del flujo: [`.agents/sdd-kit/README.md`](.agents/sdd-kit/README.md) · [CHANGELOG](.agents/sdd-kit/CHANGELOG.md)

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
    │   └── global-sdd.md     ← Triage Gate, DRY/KISS/YAGNI, integridad de tests
    ├── commands/             ← slash commands (/init, /sdd, …)
    ├── subagents/            ← roles: planner, implementer, QA
    └── skills/
        ├── sdd-docs-generator/   ← plantillas de specs / history / diagramas
        └── stack-conventions/    ← guías opcionales por framework
```

### Qué genera el kit en **tu proyecto** (después de `/init` y `/sdd`)

```text
tu-proyecto/
├── .agents/  (o .cursor/)     ← el kit instalado
├── AGENTS.md                  ← Perfil técnico + gobernanza
├── MEMORY.md
├── docs/constitution.md
└── specs/
    └── NNN-nombre-modulo/
        ├── spec.md            ← qué / por qué (tabular)
        ├── plan.md            ← cómo / arquitectura
        ├── tasks.md           ← checklist TDD (- [ ] / - [x])
        ├── diagramas/         ← Mermaid HU-x-negocio / HU-x-tecnico
        └── history/
            ├── index.md       ← índice ligero (~20 líneas)
            └── <dominio>.md   ← decisiones íntegras por dominio (sin compactar)
```

---

## Comandos (`commands/`)

| Comando | Para qué |
|---------|----------|
| `/init` | Detecta el stack y crea/actualiza `AGENTS.md`, `MEMORY.md`, `docs/constitution.md` (+ reglas `stack-*` si hay guías). |
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

## Subagentes (`subagents/`)

| Archivo | Rol |
|---------|-----|
| `1-planner.md` | Spec, plan, `tasks.md`, diagramas, trazabilidad, propiedades, archivado en `history/`. **No escribe código de app.** |
| `2-implementer.md` | Traduce **una** tarea a código con TDD (rojo → verde). Reporta fallos; no debilita tests; no archiva. |
| `3-qa-reviewer.md` | Audita spec / plan / tareas / implementación. Solo lectura + ejecución de tests. |

Los comandos deben **abrir estos archivos** (y las plantillas) con la herramienta de lectura; no basta con mencionarlos.

---

## Skills (`skills/`)

| Skill | Contenido | Uso |
|-------|-----------|-----|
| `sdd-docs-generator/` | Plantillas: `spec`, `plan`, `tasks`, `history-index`, `domain-history`, diagramas de secuencia | Obligatorias al crear docs SDD |
| `stack-conventions/` | Guías opcionales: Laravel, Filament, NativePHP, Django, FastAPI, Flutter | Si no hay guía, el agente usa buenas prácticas del lenguaje **sin error** |

---

## Reglas (`rules/`)

| Archivo | Qué impone |
|---------|------------|
| `global-sdd.md` | **§0 Triage Gate** (Nivel 0 FAST-TRACK / Nivel 1 SDD-REQUIRED), integridad de tests, consultas DRY/KISS/YAGNI y de diseño, historial por dominio, convenciones de framework opcionales |

Tras `/init`, pueden aparecer `rules/stack-*.md` (o `.mdc` en Cursor) copiadas desde `stack-conventions` según tu `conventions` en `AGENTS.md`.

---

## Instalación

Con script (indica la ruta de **tu proyecto**; sin ella, el script muestra un ejemplo y sale):

- Windows: `powershell -ExecutionPolicy Bypass -File ruta\a\sdd-full\setup_sdd_full.ps1 -ProjectPath "C:\Users\tu\mi-proyecto"`
- Mac/Linux: `bash ruta/a/sdd-full/setup_sdd_full.sh "/Users/tu/mi-proyecto"`

Sin script: copia el contenido de `.agents/` a `.cursor/` (Cursor) o `.agents/` (otros) y ejecuta `/init`.

Menú del instalador: **1** Cursor · **2** Copilot · **3** Claude Code · **4** Pi (genera `.pi/extensions/sdd-commands.ts`) · **5** OpenCode (solo `.agents/`, sin extensión de Pi).

## Uso rápido

`/init` → `/sdd` (o pedido en lenguaje natural: el Triage aplica **igual** sin slash) · Paradas: OK de **spec** → OK de **plan** → OK de **tasks** → elige cadencia TDD (**A** una-a-una | **B** lote) → `/review` → `/sdd-archive` · Código existente → `/retrofit` · Actualizar → `/sdd-update`
