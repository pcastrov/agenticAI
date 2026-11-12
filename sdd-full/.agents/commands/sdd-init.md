# /sdd-init - Inicializador de Gobernanza (AGENTS, MEMORY, Constitución y SDD)

Este comando prepara cualquier proyecto de software (existente o nuevo, en cualquier lenguaje o framework) para trabajar con el flujo SDD. Genera la "Trinidad de Contexto": `AGENTS.md`, `MEMORY.md` y `docs/constitution.md`, incluyendo el bloque `## Perfil técnico` que consumen los subagentes.

## Responsabilidad de cada archivo
- **`AGENTS.md`**: Hechos del proyecto (stack, versiones, estructura, comandos, convenciones, reglas de dominio). Cambia cuando cambia el stack.
- **`docs/constitution.md`**: Principios no negociables. Puede citar el stack ("preferir las convenciones nativas del framework"), pero nunca versiones ni comandos.
- **`MEMORY.md`**: Estado actual, decisiones y aprendizajes.

---

## Instrucción para la IA

### PASO 1: Verificar el Flujo SDD
1. Comprueba que existan `rules/global-sdd.md`, `subagents/1-planner.md` y `sdd-kit.md`. **Detecta la carpeta raíz del framework** (`.cursor/` si el host es Cursor, `.agents/` en otro caso; la que contenga `sdd-kit.md`) y úsala como `<raíz>` al escribir cualquier ruta en `AGENTS.md`, constitution o puentes. Nunca escribas la otra. Las reglas llevan la extensión del host: **`.mdc` en Cursor**, `.md` en los demás (`rules/global-sdd.mdc` / `rules/stack-[nombre].mdc` vs `.md`).
2. Lee la versión instalada en `sdd-kit.md`.
   - **Si falta el flujo**: indica al usuario que copie la carpeta `.agents/` del paquete `sdd-kit` (ver `sdd-kit/README.md` del paquete) y vuelve a ejecutar `/sdd-init`. No lo recrees de memoria.
   - **Si existe**: informa la versión e indica que se puede actualizar con `/sdd-update`.
3. Si existen `AGENTS.md`, `MEMORY.md` o `docs/constitution.md`, léelos primero para preservar decisiones, contexto e historia.

### PASO 2: Determinar el Camino
- **Proyecto existente** (hay manifiestos o código): ve al PASO 3A.
- **Proyecto nuevo o vacío**: ve al PASO 3B.

### PASO 3A: Detección Automática (proyecto existente)
1. Escanea manifiestos y configuración en la raíz (ej: `composer.json`, `package.json`, `pyproject.toml`, `requirements.txt`, `Pipfile`, `go.mod`, `Cargo.toml`, `pom.xml`, `build.gradle`, `Gemfile`, `*.csproj`) y la estructura de carpetas.
2. Usa herramientas del proyecto para confirmar versiones instaladas cuando existan (ej: `composer show --direct`, `npm ls --depth=0`, `pip list`, `go list -m all`).
3. Identifica: lenguaje y versión, framework(s), base de datos, runner de tests, linter/formatter, UI/frontend, despliegue, carpetas de código y de tests.
4. Deduce las guías de `conventions` (ver `skills/stack-conventions/SKILL.md`):
   - `laravel/framework` en `composer.json` → `laravel`; `filament/filament` → `filament`; paquetes `nativephp/*` → `nativephp`.
   - La guía `filament` está escrita para **Filament 5.x**. Si la versión instalada es anterior, avisa al usuario: sugiere actualizar (`filament/upgrade`) o anotar en **Convenciones** de `AGENTS.md` qué partes de la guía no aplican.
   - `django` en las dependencias de Python → `django`; `fastapi` → `fastapi`.
   - `pubspec.yaml` con `sdk: flutter` → `flutter`.
   - Revisa si el código existente ya sigue una convención distinta a la guía (ej. `Services/` en lugar de `Actions/`, `handle()` en lugar de `__invoke()`, estilo de lógica en Django, gestor de estado en Flutter) y anótala para la sección **Convenciones** de `AGENTS.md`.
5. Pregunta al usuario **solo** lo que no se pueda deducir o sea ambiguo (ej. dos runners de tests instalados, motor de BD distinto entre `.env` y docs). Máximo 5 preguntas.

### PASO 3B: Entrevista (proyecto nuevo)
Haz una entrevista corta proponiendo un valor por defecto en cada pregunta para que el usuario solo confirme:
1. Lenguaje y versión.
2. Framework(s) principal(es).
3. Base de datos.
4. Runner de tests.
5. Linter / formatter.
6. UI / frontend (si aplica).
7. Despliegue / hosting.
8. Gestor de estado o estilo de arquitectura, si el stack lo requiere (ej. Riverpod o Bloc en Flutter; servicios o modelos en Django).

Con las respuestas, deduce `conventions` igual que en el PASO 3A.

### PASO 4: Bloque `## Perfil técnico` en `AGENTS.md`
Escribe o actualiza este bloque con claves fijas. Si un valor no aplica o aún no está configurado, escribe `no configurado` (los subagentes se detendrán a preguntar en lugar de inventarlo).

```markdown
## Perfil técnico
- **language**: [lenguaje y versión]
- **framework**: [framework(s) y versión]
- **database**: [motor]
- **test**: [comando de la suite completa]
- **test_single**: [comando para un test, con {name}]
- **lint**: [comando de linter/formatter]
- **run**: [comando o URL local]
- **migrate**: [comando de migraciones o "no aplica"]
- **structure**: [carpetas de código y tests]
- **ui_check**: [cómo verificar cambios visuales o "no aplica"]
- **security_audit_skill**: [skill de auditoría del stack o "no configurado"]
- **conventions**: [guías de `stack-conventions` separadas por coma, ej. "laravel, filament", o "no configurado"]
```

Si `lint` no está configurado o no cubre las reglas "Debe" de las guías elegidas, sugiere las herramientas de la sección **Verificación Automática** de cada guía (ej. Pint + Larastan, ruff + mypy, `flutter analyze`) y los tests de arquitectura. No las instales sin aprobación.

### PASO 5: Herramientas de agente del stack
Complementan las guías de `stack-conventions`. No forman parte del paquete SDD y no se copian dentro de él. Inclúyelas en el resumen del DETENTE; solo se ejecutan tras la aprobación.

#### Laravel → Laravel Boost (instalación por defecto)
Si `conventions` incluye `laravel` (o existe `laravel/framework` en `composer.json`):

1. Comprueba si `laravel/boost` ya está en `composer.json` / `composer show laravel/boost`.
2. En el borrador del DETENTE, propone **instalar Laravel Boost** como acción por defecto (el usuario puede rechazarlo). Explica qué aporta:
   - MCP `laravel-boost` (inspección de la app, esquema y consultas de BD, logs, URLs).
   - Herramienta **Search Docs**: documentación oficial indexada de los paquetes instalados (Laravel, Filament, Livewire, etc.).
   - Guidelines en `AGENTS.md` (bloque `<laravel-boost-guidelines>`) y skills en `skills/`.
3. Tras la aprobación, en este orden:
   1. Si no está instalado: `composer require laravel/boost --dev`.
   2. Si no existe `boost.json` en la raíz, créalo con al menos:

      ```json
      {
        "agents": ["cursor"],
        "guidelines": false,
        "mcp": true,
        "packages": [],
        "skills": []
      }
      ```

      Así el instalador registra el MCP **sin** inyectar el bloque gigante `<laravel-boost-guidelines>` en `AGENTS.md` (ahorro de miles de tokens por turno). Las guías de código son `stack-conventions` (`laravel` / `filament`). Si el usuario insiste en guidelines de Boost, puede poner `"guidelines": true` a sabiendas del coste.
   3. Ejecuta `php artisan boost:install`. Preferible **interactivo** (sin `--no-interaction`) para que el usuario confirme agentes y paquetes. Si el entorno no permite prompts, usa `php artisan boost:install --no-interaction` **solo** después de haber escrito el `boost.json` anterior.
   4. Si el proyecto usa Laravel Sail, verifica que el archivo MCP del host (`mcp.json`) use `./vendor/bin/sail` como `command` y `["artisan", "boost:mcp"]` como `args`; si no, ajústalo.
   5. Avisa al usuario que active el servidor MCP `laravel-boost` en los settings MCP de su host (en Cursor: Command Palette → `/open MCP Settings`).
4. **Coexistencia con SDD**: Con `"guidelines": false`, Boost **no** debe llenar `AGENTS.md` de reglas genéricas. Si aparece `<laravel-boost-guidelines>`, propón **eliminarlo** (deja 3–5 líneas: “usar MCP Search Docs / Database Schema bajo demanda”). Conserva `## Perfil técnico` y dominio SDD. Orden: primero `AGENTS.md` SDD; luego `boost:install`.
5. En **Comandos** o **Stack** de `AGENTS.md`, anota: `boost:install` / MCP Search Docs (bajo demanda). **Higiene MCP**: no registres Playwright/Chrome DevTools como siempre-on; usa `/mcp-mode` y `/ui-check`. `security_audit_skill` si aplica.

#### Otros stacks
- **Flutter / Dart**: si hay skills de Flutter/Dart disponibles en el entorno del usuario, **sugiere** instalarlas o activarlas (no las instales sin aprobación). Complementan `flutter.md`.
- Cualquier otra herramienta de agente del stack: sugiere, no instales sin aprobación.

### PASO 5.1: Reglas del Stack
Solo si existe `skills/stack-conventions/references/` con la guía (es opcional; si falta, deja `conventions: no configurado` y sigue sin error). Por cada guía de `conventions`, copia `skills/stack-conventions/references/[nombre].md` a `rules/stack-[nombre].md` (`.mdc` si el host es Cursor) sin modificar su contenido (incluido el frontmatter con `globs`). Así el host (p. ej. Cursor) la adjunta automáticamente al editar archivos del stack, también fuera de `/sdd`.
- No copies guías que no estén en `conventions` (ej. en un proyecto Django no se copia `fastapi`, aunque ambas usen `**/*.py`).
- Si una `stack-*.md` ya existe y difiere de su guía, muestra el diff y pregunta antes de reemplazarla.
- Las decisiones propias del proyecto no se escriben en la regla `stack-*.md` sino en **Convenciones** de `AGENTS.md`, para que la copia pueda refrescarse con `/sdd-update`.
- Si se quita una guía de `conventions`, borra su `stack-[nombre].md`.

### PASO 6: `docs/constitution.md`
Crea o actualiza **7 principios innegociables, cortos y verificables** (máximo ~18 líneas):
1. **Simplicidad del Stack**: Priorizar convenciones nativas del framework antes de instalar librerías de terceros.
2. **Relación Spec-Código**: Ningún código existe ni se modifica sin un Requisito Funcional (`RF-x`) o Tarea previa en `specs/`.
3. **Separación Lógica / UI**: Desacoplar la lógica de negocio de los componentes visuales o vistas.
4. **Integridad de Tests**: Suite + E2E/`ui_check`/Playwright. No acomodar el rojo; Reporte de Fallo y cierre (código | tarea | SDD). Detalle: `global-sdd` §2.1.
5. **Revisión de diseño (sugerencia)**: Consulta al usuario; sin refactor por iniciativa. Detalle: `global-sdd` §2.3.
6. **Protección de Datos**: Respeto estricto a autorizaciones, validaciones de entrada y manejo seguro de datos.
7. **Idioma**: Código, variables y comentarios en **Inglés**; documentación en `specs/`, UI e interfaces al usuario en **Español** (ajustable si el usuario indica otro).

### PASO 7: Resto de `AGENTS.md`
Crea o actualiza con datos reales del proyecto. **No** copies formatos largos de DRY/diseño (siguen en `global-sdd`). **Sí** incrusta el GATE abajo: Cursor tiene `alwaysApply`, pero **OpenCode, Pi y el chat libre solo leen `AGENTS.md` de forma fiable**; un puntero de 3 líneas no basta (el modelo programa sin abrir `rules/`).

- Pon **`## Gobernanza SDD (GATE)` como primera sección** tras el título (antes de Perfil / Stack). Sustituye `<raíz>` por `.cursor` o `.agents` según el host.
- Luego: **Nombre y Descripción**, **Stack y Estructura**, **Comandos**, **Convenciones**, **Reglas de Dominio**.

  ```markdown
  ## Gobernanza SDD (GATE — obligatorio en cada turno)
  Detalle: `<raíz>/rules/global-sdd.md`. Este bloque aplica **aunque el usuario no escriba `/sdd`** (preguntas, bugs y features).

  Orden: MEMORY → AGENTS → ¿título de `specs/` encaja? → módulo → ¿ya estaba? → ¿merece SDD? → TRIAGE → Nivel 0 | 1.

  Antes de diagnosticar a fondo, proponer fixes/migraciones o cualquier Write/Edit/Bash que mute código o tests:
  1. Solo pregunta/análisis → emite ANCLAJE; **no** edites.
  2. **Turno 0 — ANCLAJE** (obligatorio; antes del triage):
     ```
     [ANCLAJE]
     - MEMORY: leído; hallazgo: … | ninguno relevante
     - AGENTS: [hecho relevante en una línea]
     - Spec candidato(s) por título: [ruta(s)] | ninguna
     - Dentro del candidato (sección 0 / tasks / history index → dominio): … | nada
     - ¿Ya estaba hecho o decidido?: sí → [explicar; no reinventar] | no → seguir
     - ¿Merece spec (nuevo o ampliar)?: sí → Nivel 1 | no → Nivel 0 (+ huella MEMORY al cerrar si aporta)
     ```
     Specs: mira solo nombres/índice; **prohibido** abrir todos los módulos. Dentro del candidato: sección 0 → tasks → history/index → un dominio.
  3. **Turno 1 — TRIAGE** (si vas a editar). Emite y **detente** si Nivel 1 o falta aprobación:
     ```
     [TRIAGE SDD]
     - Nivel: 0 FAST-TRACK | 1 SDD-REQUIRED
     - Motivo: [1 línea]
     - Spec/tarea: [ruta o "ninguna aún"]
     - Aprobación: n/a (Nivel 0) | pendiente | ya aprobada (cita al usuario)
     ```
  4. **Nivel 0**: arreglo sencillo sin mérito de spec → puedes editar; al cerrar, línea mínima en MEMORY si hubo decisión/aprendizaje.
  5. **Nivel 1**: **PROHIBIDO** código o diffs en ese turno. Flujo: `spec.md` → 🛑 OK → `plan.md` → 🛑 OK → `tasks.md` → 🛑 OK → cadencia → TDD. Duda 0/1 → Nivel 1.
  6. Antes del TDD (si hay ≥2 tareas):
     ```
     [CADENCIA TDD]
     A) Una por una — me detengo tras cada tarea
     B) Todas seguidas — hasta fin de lote o fallo
     ```
     Sin respuesta clara → **A**.
  7. Test/UI rojo → `REPORTE DE FALLO`; no debilitar tests. UI/MCP: `/ui-check`, `/mcp-mode`.
  8. No contradigas MEMORY/AGENTS/spec candidato sin citar el gap; no inventes camino paralelo si ya está decidido.
  ```

- **`## Código Compartido`**: catálogo de código **propio** reutilizable (DRY; ver `global-sdd` §2.2):

  ```markdown
  ## Código Compartido
  | Qué | Ubicación | Usar cuando |
  |-----|-----------|-------------|
  | [Base de reportes PDF (clase abstracta)] | `[app/Reports/BaseReport.php]` | [Cualquier reporte PDF: se extiende, no se crea otro generador] |
  ```

  - **Proyecto existente**: detecta candidatos solo entre archivos versionados de las carpetas de `structure`: clases abstractas, bases, traits, mixins, helpers o componentes propios que usan dos o más módulos. Nunca incluyas clases del framework ni de `vendor/`/`node_modules/`, ni lo de las exclusiones "DRY en este stack". Muéstralos en el DETENTE para que el usuario confirme cuáles entran.
  - **Proyecto nuevo**: deja la tabla vacía con una fila de ejemplo comentada.
- En **Convenciones**, anota solo lo propio del proyecto y sus desviaciones justificadas respecto a las guías de `conventions` (tienen prioridad sobre ellas); no copies las guías. Incluye la política DRY/KISS/YAGNI como consulta (`CONSULTA DE SIMPLICIDAD`) si aún no está.
- **Forma de Trabajar**: flujo SDD con subagentes (`@1-planner.md`, `@2-implementer.md`, `@3-qa-reviewer.md`) y regla de histórico (`history/`, mover nunca borrar).
- **Límites**:
  - **Siempre**: anclar (`[ANCLAJE]`: MEMORY → AGENTS → spec por título) **antes** de diagnosticar a fondo o editar; emitir Triage antes de mutar código/tests; no debilitar tests; consultar antes de refactor de diseño.
  - Qué preguntar antes y qué no hacer nunca (incluye: no barrer todos los specs; no contradecir MEMORY/spec candidato sin citar gap).
- **Verificación**: cómo dar una tarea por verificada en este proyecto.

### PASO 8: `MEMORY.md`
Crea o actualiza (máximo ~50 líneas). Es **estado / decisiones / aprendizajes**, no bitácora de cada cambio; el detalle vive en `history/` del módulo.
- **Estado actual**, **Decisiones (y por qué)**, **Aprendizajes y errores a evitar**.
- **Próximos pasos**: si hay código sin specs, ingeniería inversa con `/retrofit`.
- Se consulta **siempre** en el Turno 0 (ANCLAJE). Nivel 0 / archive pueden añadir una línea mínima si aportan algo que no deba olvidarse.

### PASO 9: `specs/` (sin módulos de ejemplo)
- 🚫 **PROHIBIDO** crear `specs/NNN-...`, `specs/001-ejemplo` u otros módulos placeholder.
- Opcional: crear solo la carpeta vacía `specs/` si no existe.
- El primer módulo real (`001-<id-kebab>/`) lo crean `/sdd`, `/architect` o `/retrofit` con nomenclatura de `global-sdd` §6.

---

## Formato de Salida
1. Resumen del **Stack Detectado** (o de las respuestas de la entrevista) y versión del flujo SDD instalada.
2. Borrador de `## Perfil técnico` y `docs/constitution.md` (principios cortos; sin duplicar `global-sdd`).
3. Borrador de `AGENTS.md`: bloque **Gobernanza SDD (GATE)** con **ANCLAJE + TRIAGE** al inicio + **Código Compartido** + dominio/stack.
4. Guías `conventions`, `stack-*.md` y verificación sugerida.
5. Si Laravel: Boost con **`guidelines: false`**, MCP on; higiene MCP (sin Playwright/DevTools siempre-on).
6. 🛑 **DETENTE Y ESPERA** aprobación antes de escribir/instalar.
7. Tras aprobación: escribe Trinidad + `stack-*.md`; Boost si se aprobó.

---

## Comandos SDD Disponibles

| Comando | Propósito |
|---------|-----------|
| `/sdd-init` | Trinidad de contexto (`AGENTS.md`, constitution, `MEMORY.md`) |
| `/sdd` | Flujo completo SDD (8 fases) |
| `/retrofit` | Ingeniería inversa de código existente |
| `/architect` | Subagente planner |
| `/implement` | Subagente implementer (TDD) |
| `/review` | Subagente QA reviewer |
| `/security` | Auditoría de seguridad e integración en specs |
| `/validation-trace` | Valida trazabilidad HU ↔ RF ↔ arquitectura ↔ tests |
| `/validation-properties` | Valida propiedades de corrección |
| `/sdd-archive` | Cierra la iteración de un módulo en `history/` |
| `/sdd-update` | Actualiza el flujo desde el paquete `sdd-kit` |
| `/ui-check` | Verificación visual aislada (veredicto corto) |
| `/mcp-mode` | Encender/apagar MCPs pesados (`code` / `ui`) |
