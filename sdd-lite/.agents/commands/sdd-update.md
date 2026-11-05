# /sdd-update (Lite)

Actualiza desde el repo origen, carpeta **`sdd-lite/.agents/`** (no la raíz Full). Rutas relativas a la **raíz del framework**.

## Carpeta raíz (depende del host)
Mismo contenido, distinto nombre: **`.cursor/`** si el usuario usa Cursor, **`.agents/`** en cualquier otra herramienta. Cursor solo acepta reglas `.mdc`: en `.cursor/` las reglas son `rules/global-sdd.mdc` y `rules/stack-*.mdc`; en `.agents/`, `.md`. Si la extensión no corresponde al host, propón renombrarlas (🛑 confirmación; mismo contenido, misma carpeta). Detecta la que contenga `../sdd-kit.md` (si hay ambas, pregunta). **Actualiza en el sitio; no renombres ni muevas** la carpeta del usuario. Sin instalación previa: pregunta la herramienta y crea `.cursor/` o `.agents/`; solo hosts sin lectura directa necesitan puente (`CLAUDE.md`, etc.) apuntando a la carpeta detectada.

## Pasos
1. Lee `sdd-kit.md` (`edition: lite`, `source`).
2. Clona/ruta local → compara `sdd-lite/.agents/` del origen vs la raíz del framework del proyecto.
3. **Sobrescribe solo archivos del paquete** (`rules/global-sdd.md`, con extensión del host, comandos, subagentes, plantillas de `skills/sdd-docs-generator/` y guías de `skills/stack-conventions/` que sigan presentes). **Prohibido** alterar skills/archivos creados por el usuario; no restaures guías de framework que eliminó.
4. **Corrige `AGENTS.md`/constitution según el host**: punteros a la carpeta detectada (`.cursor/rules/global-sdd.mdc` o `.agents/rules/global-sdd.md`); agrega o repara la "Gobernanza" (3 líneas). Solo tras confirmación.
5. **Historial (pregunta siempre)**: si hay `history/h-NN.md`, `h-archive.md`, `summary.md` o un `history.md` monolítico (Lite 1.x), **pregunta** si migrar a `history/index.md` + `history/<dominio>.md` (fichas atómicas ≤100 líneas). Si acepta: abre `subagents/1-planner.md` (modo Archivar) + plantillas `history-index-template.md` / `domain-shard-template.md`. Muestra el plan antes de escribir y no borres lo viejo hasta que confirme. **Prohibido** crear `tareas_completadas.md`.
6. Resumen + 🛑 confirmación. Actualiza `version`.
