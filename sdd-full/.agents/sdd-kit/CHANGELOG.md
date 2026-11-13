# Changelog

Formato: la primera entrada es la versión vigente del paquete (la que lee `/sdd-update`).

---

## 4.2.0 — 2026-11-12

### Agregado
- **Subagentes nativos aislados**: frontmatter `name`/`description` en `subagents/` (`sdd-planner`, `sdd-implementer`, `sdd-qa-reviewer`); **sin `model:`** (heredan el del entorno).
- **Permisos por rol**: planner → solo `specs/**` + `MEMORY.md`; implementer → único con escritura completa de código/tests (TDD y fixes QA); QA → solo lectura + `Bash` (tests/lint/`git diff`/Playwright/DevTools), sin editar archivos.
- **QA accionable**: si `VEREDICTO: CAMBIOS NECESARIOS`, sección `Diagnóstico y sugerencia de corrección` (archivo, causa raíz, propuesta para `sdd-implementer`) en `3-qa-reviewer.md` y `/review`.
- Instaladores y `/sdd-update` proyectan a `.cursor/agents/`, `.claude/agents/` y `.opencode/agents/` (este último con `mode: subagent`). Copilot/Pi leen `.agents/subagents/`.
- Comandos `/sdd`, `/architect`, `/implement`, `/review`: delegan al subagente nativo aislado; fallback recomienda chat limpio.

### Cambiado (tokens; supersede 4.1.1)
- **Lazy loading `/sdd-init`**: plantillas Trinidad en `references/init-templates.md` (PASO 0).
- **GATE en `AGENTS.md`**: puntero compacto (3 líneas) si el host auto-carga `global-sdd`; GATE completo solo en Pi / chat libre.
- **`MEMORY.md` ventana deslizante**: últimos 2–3 cambios/decisiones/trampas (máx. ~20 líneas); al archive/cierre Nivel 0 con 3 entradas → desplaza la más antigua (`history/` conserva el íntegro).
- **Higiene de contexto**: aislamiento nativo o chat limpio antes de `/implement` y `/review`.
- **Docs de tokens**: inventarios y rangos actualizados en README raíz, `sdd-full/README.md` y `sdd-kit/README.md` (estimaciones; varían).

### Migración
1. `/sdd-update` o reinstalar (opciones 1/3/5 regeneran agents nativos).
2. Cursor/OpenCode/Claude/Copilot: `AGENTS.md` con **GATE compacto**; Pi: GATE completo.
3. Comprueba `.cursor/agents/` o `.claude/agents/` o `.opencode/agents/` según host.
4. Recorta `MEMORY.md` del proyecto a ≤3 entradas recientes si creció como bitácora.

---

## 4.1.0 — 2026-11-12

### Agregado
- **Compuerta ANCLAJE (Turno 0)** en `rules/global-sdd.md` §0.1: bloque `[ANCLAJE]` obligatorio **antes** del `[TRIAGE SDD]` y antes de proponer fixes, migraciones o refactors. Aplica a preguntas, bugs y features, con o sin `/sdd`.
- Orden mental: **MEMORY → AGENTS → ¿título de carpeta `specs/` encaja? → solo ese módulo → ¿ya estaba? → ¿merece SDD? → TRIAGE → Nivel 0 | 1**.
- Specs **solo por título**: mirar índice/nombres de carpetas; máximo 1–2 candidatos; dentro: sección 0 → `tasks.md` → `history/index.md` → un dominio. Prohibido barrer todos los `spec.md` / `history/<dominio>.md`.
- Nivel 0: al cerrar, línea mínima en `MEMORY.md` si hubo decisión/aprendizaje. Archive/cierre: puntero en MEMORY si el aprendizaje no cabe solo en history.
- GATE proyectado en `AGENTS.md` (`/sdd-init`, `/sdd-update`): ANCLAJE + TRIAGE; en **Siempre**, anclar antes de diagnosticar a fondo o editar.

### Cambiado
- Comandos `/sdd`, `/architect`, `/implement`, `/sdd-archive` y subagentes `1-planner` / `2-implementer`: MEMORY primero; specs por título.
- Trinidad: MEMORY como entrada obligatoria del anclaje (estado/decisiones/aprendizajes; no bitácora).
- **Diagramas**: `HU-x-negocio.md` pasa a Mermaid **`flowchart`** (cliente/negocio); `HU-x-tecnico.md` sigue como **`sequenceDiagram`** (desarrollo). Plantilla nueva `flowchart-business-template.md`; se elimina `sequence-business-template.md`.

### Migración
1. Ejecuta **`/sdd-update`** en cada proyecto consumidor.
2. **Verifica** que `AGENTS.md` muestre el bloque `[ANCLAJE]` delante de `[TRIAGE SDD]` (si solo había el GATE viejo, el update lo reemplaza **sin borrar** el dominio del proyecto).
3. No reescribe specs de proyectos; no exige MEMORY exhaustivo.
4. Diagramas `HU-*-negocio.md` que aún sean `sequenceDiagram`: al tocar esa HU con `/architect` o `/sdd`, conviértelos a `flowchart` según la plantilla nueva (el técnico permanece secuencia).

---

## 4.0.9 — 2026-11-08

### Cambiado
- **Pi:** `.pi/extensions/sdd-commands.ts` inyecta el contenido de `commands/*.md` al invocar el slash (evita alucinaciones del tool `read` en modelos locales).

### Migración
Reinstalar opción **4** o regenerar la extensión Pi; reinicia Pi.

---

## 4.0.8 — 2026-11-08

### Cambiado
- Docs: ***delegate session*** Local vs Copilot; con modelos locales preferir Local.

### Migración
Solo docs.

---

## 4.0.7 — 2026-11-08

### Cambiado
- **GitHub Copilot (VS Code):** slash = skills en `.github/skills/` (delegate Copilot) y prompts en `.github/prompts/` (delegate Local).

### Migración
Reinstalar opción 2 o `/sdd-update`. Con modelos locales: delegate **Local**.

---

## 4.0.6 — 2026-11-08

### Cambiado
- Intento inicial de prompts `.github/prompts/` para Copilot (insuficiente: solo harness Local). Superseded by 4.0.7.

### Migración
Usa 4.0.7 (skills).

---

## 4.0.5 — 2026-11-05

### Cambiado
- **Nomenclatura de módulos**: `NNN` en plantillas es placeholder. Carpetas reales = `001-<id-kebab>/`, `002-...`. Prohibido crear `specs/NNN-...` literal.
- **`/sdd-init`**: no crea módulos de ejemplo bajo `specs/` (solo carpeta vacía opcional). Primer módulo → `/sdd`, `/architect` o `/retrofit`.

### Migración
`/sdd-update`. Si ya existe una carpeta literal `specs/NNN-...`, renómbrala a `001-<id>/` (o el número que corresponda).

---

## 4.0.4 — 2026-11-05

### Cambiado
- **OpenCode slash commands:** el instalador (opción 5) y `/sdd-update` generan `.opencode/commands/<cmd>.md` por cada `commands/*.md` del kit.
- **`/init` → `/sdd-init`:** renombrado en **todos** los hosts para no chocar con el `/init` built-in de OpenCode y alinear con `/sdd-update` / `/sdd-archive`.

### Migración
Reinstalar o `/sdd-update` (regenera `.opencode/commands/` / extensión Pi). Usa **`/sdd-init`** (el `/init` de OpenCode sigue siendo el nativo del host).

---

## 4.0.3 — 2026-11-05

### Cambiado
- GATE incrustado en `AGENTS.md`; OpenCode `opencode.json` → `instructions` a `global-sdd.md`.

### Migración
`/sdd-update` o reinstalar opción 5 + `/sdd-init`.

---

## 4.0.2 — 2026-11-04

### Cambiado
- Triage **aunque el usuario no escriba `/sdd`**; paradas tras spec/plan/tasks; `[CADENCIA TDD]` A|B.

### Migración
`/sdd-update` o reinstalar Full.

---

## 4.0.1 — 2026-11-04

### Cambiado
- Comandos Full (`architect`, `implement`, `sdd`, `sdd-archive`, `review`, `retrofit`, `validation-*`): **PASO 0 de lectura obligatoria** del subagente y de las plantillas con la herramienta de archivos (agnóstico a hosts que no expanden `@archivo`).
- Plan y tasks obligatorios (luego separados en 4.0.2 con paradas).
- Cierre: solo `history/index.md` + `history/<dominio>.md`; **prohibido** inventar `tareas_completadas.md`.
- Tras marcar todas las tareas `[x]`, `/implement` y `/review` recuerdan `/sdd-archive`.

### Migración
Actualiza el paquete Full con `/sdd-update` (o reinstala).

---

## 4.0.0 — 2026-11-04

Estándar de producción agnóstico al editor (Cursor, Claude Code, GitHub Copilot, Pi/OpenCode…). **Cambio mayor.**

### Cambiado
- **Un solo origen**: `sdd-full/.cursor/` eliminado; el origen es `sdd-full/.agents/` con **rutas relativas puras** (`rules/global-sdd.md`, `commands/architect.md`), sin prefijos `.cursor/` ni `.agents/`. Al instalar, la carpeta se llama **`.cursor/`** (Cursor) o **`.agents/`** (otros): mismo contenido, solo cambia el nombre. Reglas `.md` en el origen; en Cursor el instalador (y `/sdd-update`) las deja como **`.mdc`**, único formato que Cursor acepta.
- **REGLA ZERO / TRIAGE GATE** (`rules/global-sdd.md` §0): `[TRIAGE SDD]` — Nivel 0 FAST-TRACK (≤1 archivo, sin impacto de arquitectura) o Nivel 1 SDD-REQUIRED (negocio, BD o multi-archivo: prohibido emitir código o diffs hasta aprobación explícita). Sustituye a `[EVALUACION SDD]`.
- **Historial jerárquico**: `history.md` monolítico → `history/index.md` (~20 líneas) + `history/<dominio>.md`. Sin compactación: las decisiones se conservan íntegras, segmentadas por dominio. Plantillas `history-index-template.md` y `domain-history-template.md`; se elimina `history-template.md`.
- `spec-template.md` y `plan-template.md` en formato tabular.
- `/review` (MODO 2): **auditoría a ciegas** — `git diff` vs `spec.md` aprobado + ejecución obligatoria de la suite en terminal (Exit Code 0); sin aprobación por inspección visual.
- `/sdd-update`: gestor de paquetes seguro. Detecta la carpeta raíz en uso (`.cursor/` o `.agents/`) y actualiza **en el sitio**, sin renombrarla. Solo sobrescribe archivos base del paquete; **prohibido** tocar skills creadas por el usuario en `skills/`. Corrige en `AGENTS.md` las rutas al framework según el host. Pregunta antes de migrar `history.md`.
- **Convenciones de framework opcionales** (`global-sdd.md` §5.1 + skill `stack-conventions`): si `skills/stack-conventions/references/` está vacía, falta el archivo o la carpeta fue eliminada, el agente usa buenas prácticas estándar del lenguaje sin error. `/sdd-update` no restaura guías que el usuario eliminó.
- Opción Pi/OpenCode/Cline de los instaladores: genera `.pi/extensions/sdd-commands.ts` que registra como slash commands todos los `.md` de `commands/` (la lógica no se duplica en TypeScript).
- Scripts opcionales de instalación: `setup_sdd_full.sh` / `setup_sdd_full.ps1` (instalan en `.cursor/` o `.agents/` según tu herramienta; con paso opcional para conservar solo la guía de tu framework).

### Migración desde 3.x
1. Ejecuta `/sdd-update` (conserva tu carpeta `.cursor/` o `.agents/`; confirma el plan).
2. Proyectos con `specs/NNN/history.md`: `/sdd-update` **pregunta** y, si aceptas, `@1-planner.md` lo separa en `history/index.md` + `history/<dominio>.md` sin resumir. Si no aceptas, sigue siendo legible por ID.
3. Extensión de reglas según host (`.mdc` en Cursor, `.md` en los demás): lo ajusta el paso 0 de `/sdd-update`, sin cambiar el nombre de la carpeta.

---
## 3.5.1 — 2026-11-02

El paquete Full vive en **`sdd-full/`** del repo (junto a `sdd-lite/`), no en la raíz.

### Cambiado
- `/sdd-update` compara **`sdd-full/.agents/`** (o `sdd-full/.agents/`) del origen.
- README raíz: solo índice; paquetes en carpetas hermanas.

### Migración desde 3.5.0
1. Copia una vez desde `sdd-full/.agents/` (o actualiza `source`/ruta hacia `…/stay-on-rails/sdd-full`).
2. Siguientes `/sdd-update` usan `package_path: sdd-full/.cursor`.

---

## 3.5.0 — 2026-11-02

Optimización de tokens (Single Source of Truth), GATE, Boost sin guidelines, UI/MCP bajo demanda y hermano Lite.

### Agregado
- **GATE** al inicio de `global-sdd.md` (§0).
- Comandos **`/ui-check`** y **`/mcp-mode`**.
- Compactación de `history.md` (>~300 líneas).
- Edición hermana **`sdd-lite/`** (modelos locales 16K–32K).

### Cambiado
- Subagentes/comandos delegan a `global-sdd` (sin duplicar plantillas).
- `/sdd-init` y `/retrofit`: `guidelines: false`, `mcp: true`.
- `/sdd-update`: proyección AGENTS corta + limpieza Boost.

### Migración desde 3.4.0
1. Instalar/actualizar desde `sdd-full/.agents/` (ver 3.5.1 si el repo ya está reorganizado).
2. Confirma limpieza Boost + puntero de gobernanza en `AGENTS.md`.
3. Opcional: `/mcp-mode code` y `/ui-check`.

---

## 3.4.0 — 2026-10-28

Dos regímenes (integridad de tests obligatoria vs revisión de diseño sugerida), `global-sdd` always-on y proyección en AGENTS/constitution.

### Agregado
- **`global-sdd` sección 2.3**: revisión de diseño como sugerencia (`CONSULTA DE DISEÑO`) al crear código propio; sin checklist SOLID; sin refactor automático; lo idiomático del framework no es deuda.
- **Proyección en `/sdd-init`**: constitution con integridad de tests + revisión de diseño; `AGENTS.md` con bloques operativos `## Integridad de tests` y `## Revisión de diseño`.
- **`/sdd-update`**: tras sincronizar el paquete, verifica proyección AGENTS/constitution y propone bloques faltantes sin borrar dominio.
- **Subagentes**: planner y QA pueden emitir `CONSULTA DE DISEÑO` (no bloqueante); implementer exige cierre post-reporte (fix | tarea escrita | SDD).

### Cambiado
- **`global-sdd.md` → `global-sdd.md`** (Cursor) con `alwaysApply: true`.
- **§2.1 Integridad de tests**: cierre obligatorio tras Reporte de Fallo; prohibido ignorar el rojo.
- **`stack-conventions`**: principio Preferir de revisión de diseño al crear código propio (principios 1–2 no son checklist SOLID global).

### Migración desde 3.3.1
1. Ejecuta `/sdd-update` (renombra/reemplaza `global-sdd.md` por `global-sdd.md` en proyectos Cursor).
2. Completa en `docs/constitution.md` y `AGENTS.md` los bloques de integridad de tests y revisión de diseño si faltan (el update los propone; no borra dominio del proyecto).

---

## 3.3.1 — 2026-10-27

Origen público del paquete y `/sdd-update` desde URL de Git.

### Cambiado
- **`source` por defecto**: `https://github.com/pcastrov/stay-on-rails` (repositorio público del kit).
- **`/sdd-update`**: resuelve `source` como ruta local o como URL de Git (`git clone --depth 1` a una carpeta temporal); actualiza también el `source` en `sdd-kit.md` al terminar.

### Migración desde 3.3.0
En cada proyecto, edita `.agents/sdd-kit.md` (o `.agents/sdd-kit.md`) y pon `source: https://github.com/pcastrov/stay-on-rails`, o ejecuta `/sdd-update` indicando esa URL.

---

## 3.3.0 — 2026-10-26

Revisión de simplicidad DRY / KISS / YAGNI en planificación, implementación y QA.

### Agregado
- **`global-sdd.md` sección 2.2**: define DRY, KISS y YAGNI, y además:
  - **Todo es sugerencia**: ningún agente une, extrae, reutiliza ni modifica código por iniciativa propia; todo hallazgo se consulta.
  - **Formato `CONSULTA DE SIMPLICIDAD`**: principio, dónde, qué se detectó, opción de mejora con impacto y opción "dejarlo igual".
  - **Alcance de búsqueda**: solo `## Código Compartido` de `AGENTS.md` y el módulo activo, nunca otros módulos. Solo código propio: versionado, dentro de `structure`, sin generados ni exclusiones del stack. Si algo genérico no está en el catálogo, se pregunta.
  - **Qué cuenta como duplicación**: conocimiento duplicado sí; el código declarativo del framework que se parece entre módulos no. Regla de tres para extraer bloques propios.
- **`## Código Compartido` en `AGENTS.md`**: catálogo de código propio reutilizable entre módulos. Lo crea `/sdd-init` (PASO 7) y lo propone `/retrofit` (mapeo de módulos). `1-planner` MODO 6 y el QA proponen agregar lo genérico nuevo.
- **`1-planner` MODO 2**: revisión de simplicidad una vez por iteración, antes de diseñar.
- **`plan-template.md`**: sección "1.1 Reutilización y Simplicidad" con la zona de origen de cada elemento y las consultas resueltas.
- **`2-implementer` PASO 4 y MODO C**: sin búsqueda nueva; parte del plan y consulta antes de reutilizar algo no previsto. El reporte final incluye lo reutilizado y las consultas.
- **`3-qa-reviewer` MODO 2 y 3**: revisión DRY / KISS / YAGNI acotada a las dos zonas, con una nueva sección "Consultas de Simplicidad" en el veredicto. No bloquea: decide el usuario.
- **`stack-conventions`**: principio general 8 y sección **DRY en este stack** en cada guía, con la duplicación aceptable del framework, los hallazgos típicos y las carpetas excluidas.
- **`/retrofit`**: las reglas de negocio duplicadas se registran como deuda técnica, sin corregirlas.

### Migración desde 3.2.0
Sin cambios en la estructura de `specs/`.
1. Agrega `## Código Compartido` a `AGENTS.md`. Puede hacerlo `/sdd-init`, que detecta candidatos y te los pide confirmar.
2. Los `plan.md` existentes reciben la sección "1.1 Reutilización y Simplicidad" la próxima vez que `1-planner` los actualice.
3. `/sdd-update` refresca las reglas `stack-*.md` con la nueva sección "DRY en este stack".

---

## 3.2.0 — 2026-10-26

Diagramas de secuencia en Mermaid en lugar de PlantUML.

### Cambiado
- **Diagramas de secuencia en Mermaid**: `diagramas/HU-x-negocio.md` y `diagramas/HU-x-tecnico.md` son archivos Markdown con un bloque ` ```mermaid ` (`sequenceDiagram`). Se visualizan con la vista previa de Markdown de Cursor o VS Code, sin la extensión PlantUML ni Java, y GitHub/GitLab los dibujan directamente. Se actualizaron la skill `sdd-docs-generator`, las plantillas de spec, plan e historia, `global-sdd.md`, `1-planner`, `3-qa-reviewer`, `/retrofit` y el README.
- **`/sdd-update`**: borra los archivos que salieron del paquete si el proyecto no los personalizó.

### Eliminado
- `references/sequence-business-template.puml` y `references/sequence-technical-template.puml`, reemplazados por `sequence-business-template.md` y `sequence-technical-template.md`.

### Migración desde 3.1.0
Por cada `diagramas/HU-x-*.puml` existente en `specs/` (se puede pedir a `@1-planner.md`):
1. Crear `HU-x-*.md` con el mismo flujo según la plantilla Mermaid correspondiente: `A -> B : msg` pasa a `A->>B: msg`, `A --> B : msg` a `A-->>B: msg`; `alt`/`else`/`end` y `autonumber` se mantienen; `title` pasa a encabezado `#` del Markdown; `boundary`, `control` y `database` pasan a `participant ID as Etiqueta` (el rol va en la etiqueta); `\n` en etiquetas pasa a `<br/>`.
2. Borrar el `.puml` y actualizar las referencias en `spec.md`, `plan.md` y `history.md` del módulo (las entradas ya archivadas de `history.md` no se reescriben).

---

## 3.1.0 — 2026-10-24

Calidad de requisitos y diagramas de secuencia PlantUML.

### Agregado
- **5 atributos de calidad** (claro, útil, comprobable, trazable, actualizado) en la skill `sdd-docs-generator`. `3-qa-reviewer` MODO 1 los evalúa RF por RF en una tabla.
- **Historias de usuario con ID** (`HU-x`), prioridad MoSCoW y criterios de aceptación `CA-x.y` en formato DADO / CUANDO / ENTONCES. Cada RF indica qué historia cubre.
- **MoSCoW** en `HU`, `RF` y `RNF`. `Won't` es la sección "Fuera de Alcance". Regla nueva: un RF `Must` debe estar cubierto por al menos una tarea `blocker` o `required` (planner MODO 2 y QA MODO 4).
- **Reglas de negocio** `RN-x` (opcional) con origen y RF donde aplican, solo si la usan 2 o más RF, vienen de fuera del equipo o son datos que cambian seguido.
- **Secciones nuevas en `spec.md`**: Restricciones (técnicas, legales, otras) y Datos e Integraciones Externas.
- **Diagramas de secuencia PlantUML** en `specs/NNN-modulo/diagramas/`: `HU-x-negocio.puml` (con la spec, para cualquier persona) y `HU-x-tecnico.puml` (con el plan, por capas). Plantillas `sequence-business-template.puml` y `sequence-technical-template.puml`. Son documentos vigentes: se actualizan en su lugar y `history.md` solo registra qué cambió.
- **QA**: coherencia del diagrama de negocio (MODO 1) y del técnico (MODO 3); cobertura de criterios `CA` en MODO 2.
- **`history-template.md`**: subsecciones "Historias cerradas", "Reglas de negocio" y "Diagramas actualizados".
- **Integridad de los tests** (`global-sdd.md` 2.1 y `2-implementer`): prohibido modificar, borrar, saltar o debilitar un test existente para que pase, salvo cambio de spec aprobado o aprobación explícita del usuario. Todo bug se corrige primero con un test que lo reproduce.
- **Protocolo ante Tests Fallidos** en `2-implementer`: Reporte de Fallo (test, qué falló, dónde, tipo, causa probable con evidencia, propuesta) y criterios para decidir entre corregir ahora, nueva tarea con test de regresión o pasar por SDD.
- **`2-implementer` MODO C (Cambio Directo)**: ejecuta los cambios que no merecen spec; se detiene y propone SDD si el cambio crece.
- **Skill `stack-conventions`**: Principios Generales agnósticos y guías idiomáticas por framework (`laravel`, `filament` para Filament 5.x, `nativephp`, `django`, `fastapi`, `flutter`), con reglas de nivel **Debe** (bloqueante en QA) o **Preferir** (sugerencia) y una sección de Verificación Automática (Pint, Larastan, tests de arquitectura de Pest, ruff, mypy, import-linter, `flutter analyze`). Se cargan de forma perezosa según la nueva clave `conventions` del Perfil técnico.
- **Reglas del stack**: `/sdd-init` (PASO 5.1) copia las guías elegidas a `.agents/rules/stack-[nombre].mdc` (frontmatter con `globs`) para que Cursor las adjunte automáticamente al editar archivos del stack, también fuera de `/sdd`. `/sdd-update` las refresca si no se personalizaron.
- **Integración**: `1-planner` MODO 2 ubica capas y archivos según las guías; `2-implementer` las aplica y reporta desviaciones; `3-qa-reviewer` revisa idiomaticidad del diff (MODO 2) y del plan (MODO 3); `/retrofit` registra desviaciones como deuda técnica.
- **`/sdd-init` y `/retrofit` + Laravel Boost**: si el stack es Laravel, proponen e instalan por defecto `laravel/boost` (`composer require` + `boost:install` con `boost.json` para Cursor/MCP/guidelines). Incluye MCP **Search Docs**. En `/retrofit`, si Boost no está, se detiene a pedirlo antes de mapear; si está, usa Application Info, Database Schema, Search Docs y logs para la ingeniería inversa (solo lectura). Coexiste con SDD: Boost solo escribe el bloque `<laravel-boost-guidelines>` en `AGENTS.md`. Otros stacks siguen en modo "sugerir".
- **QA MODO 2**: detecta en el diff tests modificados o debilitados sin justificación (hallazgo bloqueante); los hallazgos incluyen test que falla, causa probable y tipo.

### Cambiado
- **Trazabilidad** extendida a HU ↔ RF ↔ archivo ↔ test ↔ propiedad (`1-planner` MODO 4, `/validation-trace`, `global-sdd.md`).
- **`spec-template.md`** renumerado: Reglas de Negocio (4), RNF (5), Restricciones (6), Datos e Integraciones (7), Casos Límite (8), Fuera de Alcance (Won't) (9), Propiedades (10), Decisiones (11), Trazabilidad (12), DoD (13).
- **`plan-template.md`**: nueva sección 5 "Diagramas de Secuencia Técnicos"; las siguientes se renumeran. La estrategia de tests incluye cobertura por criterio `CA`.
- **`/retrofit`**: deduce HU, estima MoSCoW, detecta RN y genera los diagramas de los flujos principales; los RF sin HU y las prioridades por confirmar van a la sección de dudas.
- IDs estables ahora incluyen `HU` y `RN`.
- **Evaluación de Alcance** de `/sdd` con criterios explícitos (cambio directo vs SDD), justificación obligatoria ante el usuario y ejecución por `2-implementer` MODO C (antes el orquestador, que no escribe código, debía hacer el cambio). `global-sdd.md` la incorpora como paso 2 del flujo y `/implement` la aplica a peticiones fuera de `tasks.md`.
- **`2-implementer`**: el PASO 5 ya no dice "corrige inmediatamente" ante un fallo, y el MODO B ya no permite ajustar tests existentes; ambos remiten al Protocolo ante Tests Fallidos.
- **Documentación del paquete movida a `.agents/sdd-kit/`**: `README.md` y `CHANGELOG.md` ya no están en la raíz del paquete, para no confundirse con los del proyecto donde se instala. Todo el paquete vive en `.agents/`. `/sdd-update` los busca en la nueva ruta (y en la raíz si el paquete es 3.0.0); `/sdd-init` y `.agents/sdd-kit.md` apuntan a la nueva ruta.

### Migración desde 3.0.0
`/sdd-update` copia `.agents/sdd-kit/README.md` y `.agents/sdd-kit/CHANGELOG.md` al proyecto. No toca el `README.md` ni el `CHANGELOG.md` de la raíz del proyecto: si alguna vez se copiaron ahí los del paquete, bórralos a mano.

Ejecuta `/sdd-init` para agregar la clave `conventions` al Perfil técnico y generar las reglas `stack-*.md`. Sin la clave, solo aplican los Principios Generales de `stack-conventions`.

La adopción de los nuevos requisitos no es obligatoria. Los módulos existentes siguen funcionando; al tocar un módulo con `1-planner` MODO 3, se agregan `HU-x`, MoSCoW y diagramas a los RF pendientes afectados. Para adoptarlo de una vez en un módulo, pide a `@1-planner.md`:
1. Agrupar los RF pendientes en `HU-x` con criterios `CA-x.y` y asignarles MoSCoW.
2. Agregar las secciones Restricciones y Datos e Integraciones Externas (o marcarlas "no aplica").
3. Crear `diagramas/HU-x-negocio.puml` y `diagramas/HU-x-tecnico.puml` de los flujos principales.

---

## 3.0.0 — 2026-10-24

Primera versión publicada como paquete independiente (`sdd-kit`), extraída del proyecto Ordéname Hub (Laravel 12 + Filament 5), donde el flujo se construyó y probó.

### Agregado
- **`history.md` por módulo**: histórico append-only de iteraciones cerradas. Los documentos activos (`spec.md`, `plan.md`, `tasks.md`) quedan solo con lo pendiente.
- **Índice `0. Ya implementado`** en `spec.md`: una línea por RF archivado.
- **Regla de lectura**: `history.md` solo bajo pedido o si la tarea se parece a algo hecho, buscando por ID o palabra clave.
- **`1-planner` MODO 6 (Cierre de iteración)** y FASE 8 de `/sdd` que lo invoca.
- **Comandos** `/sdd-archive` (cierre manual) y `/sdd-update` (actualización real desde el paquete; antes solo estaba mencionado).
- **Perfil técnico** en `AGENTS.md` (claves `language`, `framework`, `database`, `test`, `test_single`, `lint`, `run`, `migrate`, `structure`, `ui_check`, `security_audit_skill`). Los subagentes lo leen y se detienen si falta una clave.
- **`/sdd-init` con dos caminos**: detección automática (proyecto existente) o entrevista (proyecto nuevo).
- **`history-template.md`** en `sdd-docs-generator`.
- **`.agents/sdd-kit.md`**: versión instalada y origen del paquete.

### Cambiado
- **Agnóstico de stack**: se quitaron referencias a Laravel, PHP, Filament, Eloquent, Pest y `php artisan test` de comandos, subagentes, regla y plantillas. Las plantillas de plan y tareas usan capas genéricas (Persistencia, Dominio/Servicios, Interfaz/API, Autorización, Tests).
- **Ejemplos de propiedades** del dominio de pedidos reemplazados por ejemplos neutrales.
- **`/security`** genérico: usa `security_audit_skill` del Perfil técnico o una checklist OWASP Top 10.
- **`/retrofit`**: lo ya construido va directo a `history.md`; un RF implementado sin tests se archiva como `sin tests → Tx` con la tarea pendiente.
- **"No borrar tareas `[x]`"** reemplazado por **"mover a `history.md`, nunca borrar"**.
- Se eliminaron los marcadores `**NUEVO**` / `(NUEVO)` que anotaban cambios dentro de las instrucciones.

### Eliminado
- **`.agents/templates/sdd-flow.md`**: copia monolítica de todos los archivos del flujo que `/sdd-init` usaba para recrearlos. Duplicaba el contenido y ya estaba desincronizada (referenciaba `/sdd-init`, inexistente). Su parte explicativa pasó a `README.md`; el paquete en carpeta es ahora la única fuente.

### Migración desde 2.x
Para cada módulo en `specs/` (se puede pedir a `@1-planner.md`):
1. Crear `history.md` con `## Iteración 1 — AAAA-MM-DD — Retrofit` que contenga los RF implementados (texto completo), decisiones, arquitectura y tareas `[x]`.
2. En `spec.md`, agregar `## 0. Ya implementado` y quitar el detalle de esos RF.
3. En `plan.md`, dejar una tabla de estructura vigente y solo la arquitectura de lo pendiente.
4. En `tasks.md`, dejar solo las tareas `[ ]`.
5. Agregar el bloque `## Perfil técnico` a `AGENTS.md` (ejecutar `/sdd-init`).

---

## 2.0.0 — 2025-01-22

Integración de mejoras inspiradas en el flujo de specs de distintas metodologías sobre el SDD existente.

### Agregado
- **`spec-template.md`**: secciones de Propiedades de Corrección (Property-Based Testing), Decisiones de Diseño (justificación y alternativas descartadas), Trazabilidad RF ↔ Tests y Criterios de Finalización ampliados.
- **`plan-template.md`**: Trazabilidad Arquitectónica (archivo ↔ RF) y Mapeo de Propiedades ↔ Tests.
- **`tasks-template.md`**: campos Prioridad (`blocker` / `required` / `optional` / `nice-to-have`), Propiedades validadas y Tests asociados.
- **`1-planner`**: MODO 4 (Validación de Trazabilidad) y MODO 5 (Generación de Propiedades); MODO 1-3 incorporan propiedades y trazabilidad.
- **`3-qa-reviewer`**: MODO 3 (Validación de Arquitectura) y MODO 4 (Validación de Tareas); MODO 1-2 verifican propiedades y trazabilidad.
- **`/sdd`**: FASE 4 (Validación de Arquitectura) y FASE 5 (Validación de Tareas); el flujo pasa a 8 fases.
- **Comandos** `/validation-trace` y `/validation-properties`.
- **`2-implementer`**: verificación de propiedades en el ciclo TDD.
- **`AGENTS.md`**: secciones de Especificación (EARS + Propiedades), Validación y Verificación, y checklists de spec/plan/tasks/implementación.
- **`/sdd-init`**: detección y copia del flujo SDD si no existe (vía `templates/sdd-flow.md`, reemplazado en 3.0.0).

### Beneficios buscados
Validación formal con propiedades, trazabilidad completa RF ↔ arquitectura ↔ tests ↔ propiedades, validaciones tempranas por QA antes de implementar, priorización explícita y documentación de decisiones.

---

## 1.0.0

Flujo SDD base: Trinidad de contexto (`AGENTS.md`, `MEMORY.md`, `docs/constitution.md`), subagentes `1-planner`, `2-implementer` (TDD) y `3-qa-reviewer`, comandos `/sdd`, `/retrofit`, `/architect`, `/implement`, `/review`, regla `global-sdd.md` y skill `sdd-docs-generator` con plantillas de spec, plan y tasks.
