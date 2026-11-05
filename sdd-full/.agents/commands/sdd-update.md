# /sdd-update — Gestor de paquetes del flujo SDD

Actúa como gestor de paquetes **seguro** de la metodología: instala o actualiza solo lo que pertenece al paquete **SDD Full** (`sdd-full/.agents/` del repo origen, no la raíz ni `sdd-lite/`). No requiere scripts de shell.

## Carpeta raíz del framework (depende del host)
El paquete se instala **con el mismo contenido y rutas relativas** en una carpeta cuyo nombre depende de la herramienta: **`.cursor/`** si el usuario usa Cursor, **`.agents/`** en cualquier otra. Toda ruta de este documento es relativa a esa carpeta (la "raíz del framework").

- **Detéctala**: es la carpeta del proyecto que contiene `sdd-kit.md` (`.cursor/` o `.agents/`). Si hay una sola, esa es. Si hay ambas, pregunta cuál se usa y no dupliques.
- **Respétala**: actualiza **en el sitio**. No renombres ni muevas la carpeta del usuario: si usa Cursor, sigue siendo `.cursor/`; si usa `.agents/`, sigue siendo `.agents/`.
- Si no hay ninguna (instalación nueva por este comando): pregunta la herramienta y crea `.cursor/` (Cursor) o `.agents/` (otras). Solo los hosts que no leen la carpeta directamente necesitan puente (`CLAUDE.md` o `.github/copilot-instructions.md`), apuntando a la carpeta detectada; Cursor no necesita puente.

## REGLA DE PROTECCIÓN (prevalece sobre todo)
**Prohibido alterar, borrar o sobrescribir** subcarpetas o archivos dentro de `skills/` que haya creado el usuario para su proyecto. Solo pertenece al paquete lo listado en "Archivos del paquete" (`sdd-kit/README.md` del origen). Todo lo demás en `skills/`, `rules/`, `commands/` y `subagents/` es del usuario: no lo toques. Si un archivo del paquete fue personalizado → diff y pregunta; nunca sobrescribas en silencio.

## Paso 0 — Extensión de las reglas según el host
El contenido es el mismo, pero **Cursor solo acepta reglas `.mdc`**:
- Raíz `.cursor/`: `rules/global-sdd.mdc` y `rules/stack-*.mdc`.
- Raíz `.agents/`: `rules/global-sdd.md` y `rules/stack-*.md`.

Si la extensión instalada no corresponde al host (p. ej. Cursor con `.md`, u otro host con `.mdc` de una instalación 3.x), 🛑 propón y, con confirmación, renómbralas conservando el frontmatter, **sin cambiar el nombre de la carpeta**. No toques nada ajeno al kit (`mcp.json`, reglas propias, ajustes del host). En todo este documento, `rules/global-sdd.md` y `rules/stack-*.md` se leen con la extensión del host.

## Actualización
1. Lee `sdd-kit.md` de la raíz detectada: versión instalada y `source`.
2. Si el usuario no indica otra ruta/URL, usa `source`. **Resuelve el origen**:
   - **Ruta local**: si apunta a la raíz del repo `agenticAI`, usa `…/sdd-full/.agents`. Si ya apunta a `…/sdd-full` o `…/sdd-full/.agents`, úsala.
   - **URL de Git**: `git clone --depth 1` (o fetch/checkout en caché). Paquete Full = **`sdd-full/.agents/`** dentro del clone. No dejes el clone temporal dentro del proyecto.
   - Si falta `source`, pregunta ruta o URL.
3. Versión: primera entrada de `sdd-kit/CHANGELOG.md` del origen.
4. Si misma versión: informa al día (salvo verificación de los pasos 7–8).
5. **Sobrescribe ÚNICAMENTE los archivos base del paquete** listados en `sdd-kit/README.md` del origen — `rules/global-sdd.md`, comandos base, subagentes base, `skills/sdd-docs-generator/**` y `skills/stack-conventions/**` del paquete, y templates en `skills/sdd-docs-generator/references/`:
   - Sin cambios locales → reemplazar.
   - Con cambios locales → diff + preguntar.
   - Nuevos del paquete → copiar.
   - Eliminados del paquete → borrar solo si no fueron personalizados.
   - **Convenciones opcionales**: si el usuario eliminó `skills/stack-conventions/` o archivos de `references/` (para ahorrar tokens), **no los restaures**; actualiza solo las guías que sigan presentes. Instálalas únicamente si el usuario lo pide.
   - Al reemplazar `rules/global-sdd.md` o `rules/stack-*.md` del paquete, escribe el resultado con la extensión del host (`.mdc` en Cursor).
   - `rules/stack-*.md`: refrescar desde `skills/stack-conventions/references/` solo si no fueron personalizadas.
6. **No toques**: skills/archivos creados por el usuario (REGLA DE PROTECCIÓN), comandos/reglas ajenos al paquete, `specs/` (salvo paso 8, con aprobación), `MEMORY.md`, dominio de `AGENTS.md`, ni README/CHANGELOG de la raíz del proyecto.
7. **Corregir `AGENTS.md` y `docs/constitution.md` según el host en uso** (proponer; no borrar dominio):
   - Rutas del framework: `.cursor/rules/global-sdd.mdc` (Cursor) o `.agents/rules/global-sdd.md` (otros).
   - Constitution: integridad de tests + revisión de diseño + Triage.
   - **`AGENTS.md` — GATE obligatorio**: si solo hay un puntero de 2–3 líneas a `global-sdd`, **reemplázalo** por el bloque completo `## Gobernanza SDD (GATE)` de `/sdd-init` (PASO 7). Debe quedar **al inicio** del archivo. Motivo: OpenCode/Pi cargan `AGENTS.md`, no el `alwaysApply` de Cursor.
   - **OpenCode**: si existe `opencode.json` / `.opencode/` o el usuario usa OpenCode: (1) `instructions` debe incluir `".agents/rules/global-sdd.md"`; (2) regenera `.opencode/commands/<nombre>.md` por cada `commands/*.md` del kit (template: leer y ejecutar esa ruta; `$ARGUMENTS`). OpenCode **no** lee `.agents/commands/` como slash — solo `.opencode/commands/`. No borres otras claves de `opencode.json`.
   - **Rename `/init` → `/sdd-init`**: si aún existe `commands/init.md` (o `.opencode/commands/init.md` / registro Pi `init`), elimínalo tras instalar `sdd-init` para no chocar con el `/init` built-in de OpenCode.
   - Si existe `<laravel-boost-guidelines>`: propone eliminarlo o ≤5 líneas y `boost.json` con `"guidelines": false`, `"mcp": true`.
   - Higiene MCP: `/mcp-mode` y `/ui-check`.
   - Solo escribe tras confirmación.
8. **Migración de historial (pregunta siempre)**: si algún módulo real bajo `specs/<NNN>-<id>/` tiene `history.md` monolítico, **pregunta** si migrarlo. Con "sí", invoca `@1-planner.md` para separarlo en `history/index.md` + `history/<dominio>.md` **sin resumir ni perder decisiones**; muestra el plan de dominios antes de escribir y no borres `history.md` hasta que el usuario confirme el resultado. Con "no", déjalo (sigue siendo legible por ID) y recuérdalo en el resumen.
9. 🛑 Resumen (archivos reemplazados, preservados y omitidos por la protección; correcciones de `AGENTS.md`; migraciones) + confirmación antes de escribir.
10. Actualiza `version` y `source` en `sdd-kit.md` (deja `source` en la URL pública del repo o la ruta a `sdd-full` usada).
