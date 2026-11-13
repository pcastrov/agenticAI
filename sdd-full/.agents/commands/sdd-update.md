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
   - **Prioridad**: si el usuario pasó una ruta/URL en el mensaje, **esa gana** (sirve para migrar kits cuyo `/sdd-update` todavía es el de `agenticAI`).
   - **Alias de rename (obligatorio en esta versión)**: si `source` (URL o ruta) contiene `agenticAI` / `AgenticAI`, **sustitúyelo por `stay-on-rails`** antes de clonar o leer. Ej.: `https://github.com/pcastrov/agenticAI` → `https://github.com/pcastrov/stay-on-rails`. Avisa en una línea y, al cerrar (paso 11), persiste el `source` nuevo.
   - **Fallback si el clone/fetch falla** (404, repo missing): reintenta una vez con `https://github.com/pcastrov/stay-on-rails` y explica el rename. Si también falla, 🛑 pide URL o ruta local.
   - **Ruta local**: si apunta a la raíz del repo `stay-on-rails` (o carpeta local aún llamada `agenticAI` con este kit), usa `…/sdd-full/.agents`. Si ya apunta a `…/sdd-full` o `…/sdd-full/.agents`, úsala.
   - **URL de Git**: `git clone --depth 1` (o fetch/checkout en caché) de la URL **ya normalizada**. Paquete Full = **`sdd-full/.agents/`** dentro del clone. No dejes el clone temporal dentro del proyecto.
   - Si falta `source`, pregunta ruta o URL (preferir `https://github.com/pcastrov/stay-on-rails`).

> **Huevo y gallina:** un proyecto con el comando **viejo** no ejecuta este alias hasta que actualice. Para el primer salto: el usuario debe **indicar la URL nueva** en el mensaje o editar `source` en `sdd-kit.md` (ver README raíz → Migración desde agenticAI).
3. Versión: primera entrada de `sdd-kit/CHANGELOG.md` del origen.
4. Si misma versión: informa al día (salvo verificación de los pasos 7–8).
5. **Sobrescribe ÚNICAMENTE los archivos base del paquete** listados en `sdd-kit/README.md` del origen — `rules/global-sdd.md`, comandos base, subagentes base, `skills/sdd-docs-generator/**` y `skills/stack-conventions/**` del paquete, y templates en `skills/sdd-docs-generator/references/`:
   - Sin cambios locales → reemplazar.
   - Con cambios locales → diff + preguntar.
   - Nuevos del paquete → copiar.
   - Eliminados del paquete → borrar solo si no fueron personalizados (p. ej. `sequence-business-template.md` sustituido por `flowchart-business-template.md`).
   - **Convenciones opcionales**: si el usuario eliminó `skills/stack-conventions/` o archivos de `references/` (para ahorrar tokens), **no los restaures**; actualiza solo las guías que sigan presentes. Instálalas únicamente si el usuario lo pide.
   - Al reemplazar `rules/global-sdd.md` o `rules/stack-*.md` del paquete, escribe el resultado con la extensión del host (`.mdc` en Cursor).
   - `rules/stack-*.md`: refrescar desde `skills/stack-conventions/references/` solo si no fueron personalizadas.
6. **No toques**: skills/archivos creados por el usuario (REGLA DE PROTECCIÓN), comandos/reglas ajenos al paquete, `specs/` (salvo paso 8, con aprobación), `MEMORY.md`, dominio de `AGENTS.md`, ni README/CHANGELOG de la raíz del proyecto.
7. **Corregir `AGENTS.md` y `docs/constitution.md` según el host en uso** (proponer; **no borrar dominio** del proyecto). Plantillas GATE: `skills/sdd-docs-generator/references/init-templates.md` §§1–2.
   - Rutas del framework: `.cursor/rules/global-sdd.mdc` (Cursor) o `.agents/rules/global-sdd.md` (otros).
   - Constitution: integridad de tests + revisión de diseño + Triage.
   - **`AGENTS.md` — GATE según host** (primera sección; no borrar dominio/stack):
     - **Carga automática** (Cursor alwaysApply; OpenCode con `instructions` → `global-sdd.md`; Claude/Copilot con puente): escribe **GATE compacto** (§1). Si hay GATE completo duplicado → **reemplázalo** por el puntero de 3 líneas (ahorro de tokens; la fuente de verdad es `rules/global-sdd.md` §0).
     - **Sin carga automática** (Pi o chat libre sin `instructions`/puente): escribe **GATE completo** (§2) con `[ANCLAJE]` + `[TRIAGE SDD]`. Si falta ANCLAJE → actualiza al completo.
   - Tras escribir: verificar puntero a `global-sdd` §0 (hosts con auto-carga) **o** `[ANCLAJE]` en el GATE completo (Pi/chat libre).
   - **OpenCode**: si existe `opencode.json` / `.opencode/` o el usuario usa OpenCode: (1) `instructions` debe incluir `".agents/rules/global-sdd.md"`; (2) regenera `.opencode/commands/<nombre>.md` por cada `commands/*.md` del kit (template: leer y ejecutar esa ruta; `$ARGUMENTS`). OpenCode **no** lee `.agents/commands/` como slash — solo `.opencode/commands/`. No borres otras claves de `opencode.json`.
   - **Pi**: si existe `.pi/extensions/` o el usuario usa Pi: regenera `.pi/extensions/sdd-commands.ts` leyendo e **inyectando** el cuerpo de cada `commands/*.md` en el `sendUserMessage` (no solo pedir “lee el archivo”; modelos locales inventan placeholders).
   - **GitHub Copilot (VS Code) — *delegate session***: regenera `.github/skills/<nombre>/SKILL.md` (`disable-model-invocation: true`) y `.github/prompts/<nombre>.prompt.md`. **Local** → prompts; **Copilot** → skills. Con modelos locales recomendar delegate **Local**.
   - **Rename `/init` → `/sdd-init`**: si aún existe `commands/init.md` (o `.opencode/commands/init.md` / `.github/prompts/init.prompt.md` / registro Pi `init`), elimínalo tras instalar `sdd-init` para no chocar con el `/init` built-in de OpenCode.
   - Si existe `<laravel-boost-guidelines>`: propone eliminarlo o ≤5 líneas y `boost.json` con `"guidelines": false`, `"mcp": true`.
   - Higiene MCP: `/mcp-mode` y `/ui-check`.
   - Solo escribe tras confirmación.
8. **Migración de historial (pregunta siempre)**: si algún módulo real bajo `specs/<NNN>-<id>/` tiene `history.md` monolítico, **pregunta** si migrarlo. Con "sí", invoca `@1-planner.md` para separarlo en `history/index.md` + `history/<dominio>.md` **sin resumir ni perder decisiones**; muestra el plan de dominios antes de escribir y no borres `history.md` hasta que el usuario confirme el resultado. Con "no", déjalo (sigue siendo legible por ID) y recuérdalo en el resumen.
9. **Subagentes nativos aislados** (origen siempre `subagents/1-planner.md`, `2-implementer.md`, `3-qa-reviewer.md` del kit; destino con nombres `sdd-planner.md`, `sdd-implementer.md`, `sdd-qa-reviewer.md`):
   - Copia el origen **tal cual** (frontmatter `name`/`description` + permisos por rol; **sin** añadir `model:` — heredan el del entorno).
   - Cursor: `.cursor/agents/` (si la raíz es `.cursor/`, proyecta ahí; sin `mode`).
   - Claude Code: `.claude/agents/` (si existe o hay `CLAUDE.md`).
   - OpenCode: `.opencode/agents/` e inserta `mode: subagent` en el frontmatter (tras `description`).
   - Copilot / Pi: no crean carpeta nativa; leen `<raíz>/subagents/`.
   - No inventes contenido: copia desde el origen del paquete tras el paso 5.
10. 🛑 Resumen (archivos reemplazados, preservados y omitidos por la protección; correcciones de `AGENTS.md`; proyecciones de agents; migraciones) + confirmación antes de escribir.
11. Actualiza `version` y `source` en `sdd-kit.md` (URL pública `https://github.com/pcastrov/stay-on-rails` o la ruta local a `sdd-full` usada; **nunca** dejes `agenticAI` en `source` tras un update exitoso).
