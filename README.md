# SDD Kit

Este repositorio es un **kit de herramientas** para programar con agentes de IA de forma ágil, guiados por **Spec-Driven Development (SDD)** — desarrollo dirigido por especificaciones.

**Repositorio público**: [https://github.com/pcastrov/agenticAI](https://github.com/pcastrov/agenticAI)

**Licencia**: [MIT](LICENSE) — uso, copia, modificación y distribución libres; sin garantía.

## De qué se trata

La idea es simple: antes de tocar código, el agente (y tú) dejan claro **qué** se va a construir, **por qué** y **cómo** se va a verificar. Eso reduce cambios a ciegas, código que no pediste y “arreglos” que rompen lo que ya funcionaba.

El kit no es una aplicación ni un framework. Es un **paquete portable** (reglas, comandos, subagentes, plantillas y convenciones de stack) que copias a la raíz de tu proyecto. A partir de ahí, el agente trabaja con un flujo fijo:

1. **Especificar** — historias, requisitos y criterios comprobables (`spec.md`).
2. **Diseñar** — arquitectura y tareas (`plan.md`, `tasks.md`).
3. **Implementar** — TDD, una tarea a la vez.
4. **Validar** — QA contra la spec, no contra “lo que parece bien”.

Es **agnóstico de lenguaje y framework**. Lo que cambia entre proyectos es el bloque `## Perfil técnico` de `AGENTS.md` (lo genera `/init`).

Inspirado en el flujo de specs de distintas metodologías (requisitos, diseño, tareas y verificación), adaptado a subagentes y a stacks reales (Laravel, Filament, NativePHP, Django, FastAPI, Flutter, etc.).

### Más detalle (READMEs internos)

Este README solo da el contexto del repositorio. La guía completa del flujo vive dentro de cada paquete:

| Host | Uso del flujo | Historial de versiones |
|---|---|---|
| Cursor | [`.cursor/sdd-kit/README.md`](.cursor/sdd-kit/README.md) | [CHANGELOG](.cursor/sdd-kit/CHANGELOG.md) |
| Otros agentes | [`.agents/sdd-kit/README.md`](.agents/sdd-kit/README.md) | [CHANGELOG](.agents/sdd-kit/CHANGELOG.md) |

Ahí encontrarás: trinidad de contexto (`AGENTS.md`, constitución, memoria), perfil técnico, estructura de `specs/`, fases de `/sdd`, comandos, lista de archivos del paquete, convenciones por stack, simplicidad DRY/KISS/YAGNI y cómo evolucionar el kit.

---

## Dos carpetas, mismo contenido

| Carpeta | Para quién | Qué copias al proyecto |
|---|---|---|
| [`.cursor/`](.cursor/) | **Cursor** | Solo `.cursor/` |
| [`.agents/`](.agents/) | **Cualquier otro agente** (Claude Code, Codex, Gemini, Copilot, Junie, etc.) | Solo `.agents/` |

Son **exactamente el mismo flujo**. La única diferencia práctica es el prefijo de rutas: dentro de `.cursor/` todo apunta a `.cursor/...`; dentro de `.agents/` todo apunta a `.agents/...`.

### No uses las dos a la vez en un proyecto

En un proyecto de trabajo **elige una**:

- Si desarrollas con Cursor → copia **solo** `.cursor/`.
- Si usas otro agente → copia **solo** `.agents/`.

Tener ambas en el mismo proyecto puede hacer que el agente lea reglas, skills o comandos duplicados y se confunda. Este repositorio sí las tiene las dos porque es el **origen del paquete**, no un proyecto de aplicación.

---

## Documentación de cada paquete

Remite a la tabla de [Más detalle](#más-detalle-readmes-internos). Versión instalada y origen: `.cursor/sdd-kit.md` o `.agents/sdd-kit.md`.

---

## Qué incluye el paquete

```text
.cursor/   (o .agents/)
├── sdd-kit.md              # Versión y source
├── sdd-kit/
│   ├── README.md           # Cómo usar el flujo
│   └── CHANGELOG.md        # Versiones y migraciones
├── rules/
│   └── global-sdd.md       # Reglas globales del flujo
├── commands/               # init, sdd, retrofit, implement, review, …
├── subagents/              # 1-planner, 2-implementer, 3-qa-reviewer
└── skills/
    ├── sdd-docs-generator/ # Plantillas de spec/plan/tasks/history y diagramas
    └── stack-conventions/  # Guías idiomáticas (Laravel, Filament 5, NativePHP, Django, FastAPI, Flutter)
```

Lo que **no** va en el paquete (se instala por proyecto): Laravel Boost, MCP del IDE, linters del stack, skills de terceros, etc.

---

## Instalación rápida

1. Clona o descarga [pcastrov/agenticAI](https://github.com/pcastrov/agenticAI).
2. Copia **solo** `.cursor/` **o** `.agents/` a la raíz de tu proyecto (no las dos).
3. Ejecuta `/init` (y `/retrofit` si ya hay código).
4. Para cambios de producto: `/sdd`. Para actualizar el kit: `/sdd-update`.

Detalle: [`.cursor/sdd-kit/README.md`](.cursor/sdd-kit/README.md) · [`.agents/sdd-kit/README.md`](.agents/sdd-kit/README.md).

### Cómo funciona `/sdd-update`

En cada proyecto, `.cursor/sdd-kit.md` (o `.agents/sdd-kit.md`) guarda la versión instalada y un `source`. Por defecto ese `source` es la URL pública del kit. Al ejecutar `/sdd-update`, el agente:

1. Lee `source`.
2. Si es una **URL de Git**, clona el repo en una carpeta temporal (`git clone --depth 1`) y compara.
3. Si es una **ruta local**, compara contra esa carpeta en disco.
4. Te muestra el resumen y solo escribe tras tu confirmación.

No hace falta que el proyecto tenga el kit en una ruta fija: basta con acceso a internet (repo público) o a un clone local.

---

## Cómo se mantiene este repositorio

1. Los cambios del flujo se hacen primero en **`.cursor/`**.
2. Cuando quieras alinear el otro host, se pide explícitamente sincronizar `.agents/` desde `.cursor/` (mismas rutas, prefijo `.agents/`, y los matices propios de hosts no Cursor: Boost, carga de reglas, etc.).
3. **No hay sync automático**: no se asume que un cambio en `.cursor/` se propague solo a `.agents/`.
4. Tras publicar en GitHub, los proyectos actualizan su copia con `/sdd-update` (usan el `source` con la URL del repo).

---

## Licencia

Este proyecto está bajo la licencia [MIT](LICENSE). Puedes usarlo, copiarlo y adaptarlo en proyectos propios (incluido uso comercial), siempre que conserves el aviso de copyright y el texto de la licencia. El software se ofrece **tal cual**, sin garantías.
