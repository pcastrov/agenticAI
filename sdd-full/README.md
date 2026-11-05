# SDD Full

Edición para herramientas agénticas avanzadas (**Cursor, Claude Code, GitHub Copilot**, Pi/OpenCode…) y modelos frontier (ventanas grandes). Flujo completo: Triage + 8 fases, subagentes, diagramas, propiedades y QA a ciegas.

## Instalación
Una sola carpeta de origen: [`.agents/`](.agents/). Al instalarla, su nombre depende de tu herramienta: **`.cursor/`** si usas Cursor, **`.agents/`** en las demás. El contenido es el mismo (rutas relativas), solo cambia el nombre.

Con script (indica la ruta de **tu proyecto**; sin ella, el script muestra un ejemplo y sale):
- Windows: `powershell -ExecutionPolicy Bypass -File ruta\a\sdd-full\setup_sdd_full.ps1 -ProjectPath "C:\Users\tu\mi-proyecto"`
- Mac/Linux: `bash ruta/a/sdd-full/setup_sdd_full.sh "/Users/tu/mi-proyecto"`

Sin script: copia el contenido de `.agents/` a `.cursor/` (Cursor) o `.agents/` (otros) y ejecuta `/init`.

Con la opción **Pi / OpenCode / Cline**, el script genera además `.pi/extensions/sdd-commands.ts` (un solo archivo que registra todos los comandos de `.agents/commands/` como slash commands; la lógica sigue en los `.md`).

No combines con **SDD Lite**.

## Uso
`/init` → `/sdd` · Actualizar: `/sdd-update` (compara `sdd-full/.agents` del origen contra tu carpeta en el sitio —`.cursor/` o `.agents/`—; no la renombra, corrige las rutas de `AGENTS.md` según tu host y no toca tus skills personalizadas).

Guía del flujo: [`sdd-kit/README.md`](.agents/sdd-kit/README.md) · [CHANGELOG](.agents/sdd-kit/CHANGELOG.md) (en el origen, dentro de `.agents/`)

Comparativa Full vs Lite y tokens: [README de la raíz](../README.md).