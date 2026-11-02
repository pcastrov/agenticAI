# /init - Inicializador de Gobernanza (AGENTS, MEMORY, Constitución y SDD)

Este comando prepara cualquier proyecto de software (existente o nuevo, en cualquier lenguaje o framework) para trabajar con el flujo SDD. Genera la "Trinidad de Contexto": `AGENTS.md`, `MEMORY.md` y `docs/constitution.md`, incluyendo el bloque `## Perfil técnico` que consumen los subagentes.

## Responsabilidad de cada archivo
- **`AGENTS.md`**: Hechos del proyecto (stack, versiones, estructura, comandos, convenciones, reglas de dominio). Cambia cuando cambia el stack.
- **`docs/constitution.md`**: Principios no negociables. Puede citar el stack ("preferir las convenciones nativas del framework"), pero nunca versiones ni comandos.
- **`MEMORY.md`**: Estado actual, decisiones y aprendizajes.

---

## Instrucción para la IA

### PASO 1: Verificar el Flujo SDD
1. Comprueba que existan `.cursor/rules/global-sdd.mdc`, `.cursor/subagents/1-planner.md` y `.cursor/sdd-kit.md`.
2. Lee la versión instalada en `.cursor/sdd-kit.md`.
   - **Si falta el flujo**: indica al usuario que copie la carpeta `.cursor/` del paquete `sdd-kit` (ver `.cursor/sdd-kit/README.md` del paquete) y vuelve a ejecutar `/init`. No lo recrees de memoria.
   - **Si existe**: informa la versión e indica que se puede actualizar con `/sdd-update`.
3. Si existen `AGENTS.md`, `MEMORY.md` o `docs/constitution.md`, léelos primero para preservar decisiones, contexto e historia.

### PASO 2: Determinar el Camino
- **Proyecto existente** (hay manifiestos o código): ve al PASO 3A.
- **Proyecto nuevo o vacío**: ve al PASO 3B.

### PASO 3A: Detección Automática (proyecto existente)
1. Escanea manifiestos y configuración en la raíz (ej: `composer.json`, `package.json`, `pyproject.toml`, `requirements.txt`, `Pipfile`, `go.mod`, `Cargo.toml`, `pom.xml`, `build.gradle`, `Gemfile`, `*.csproj`) y la estructura de carpetas.
2. Usa herramientas del proyecto para confirmar versiones instaladas cuando existan (ej: `composer show --direct`, `npm ls --depth=0`, `pip list`, `go list -m all`).
3. Identifica: lenguaje y versión, framework(s), base de datos, runner de tests, linter/formatter, UI/frontend, despliegue, carpetas de código y de tests.
4. Deduce las guías de `conventions` (ver `.cursor/skills/stack-conventions/SKILL.md`):
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
   - Guidelines en `AGENTS.md` (bloque `<laravel-boost-guidelines>`) y skills en `.cursor/skills/`.
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

      Así el instalador elige Cursor y registra el MCP **sin** inyectar el bloque gigante `<laravel-boost-guidelines>` en `AGENTS.md` (ahorro de miles de tokens por turno). Las guías de código son `stack-conventions` (`laravel` / `filament`). Si el usuario insiste en guidelines de Boost, puede poner `"guidelines": true` a sabiendas del coste.
   3. Ejecuta `php artisan boost:install`. Preferible **interactivo** (sin `--no-interaction`) para que el usuario confirme agentes y paquetes. Si el entorno no permite prompts, usa `php artisan boost:install --no-interaction` **solo** después de haber escrito el `boost.json` anterior.
   4. Si el proyecto usa Laravel Sail, verifica que `.cursor/mcp.json` use `./vendor/bin/sail` como `command` y `["artisan", "boost:mcp"]` como `args`; si no, ajústalo.
   5. Avisa al usuario que active el servidor MCP en Cursor: Command Palette → `/open MCP Settings` → activar `laravel-boost`.
4. **Coexistencia con SDD**: Con `"guidelines": false`, Boost **no** debe llenar `AGENTS.md` de reglas genéricas. Si aparece `<laravel-boost-guidelines>`, propón **eliminarlo** (deja 3–5 líneas: “usar MCP Search Docs / Database Schema bajo demanda”). Conserva `## Perfil técnico` y dominio SDD. Orden: primero `AGENTS.md` SDD; luego `boost:install`.
5. En **Comandos** o **Stack** de `AGENTS.md`, anota: `boost:install` / MCP Search Docs (bajo demanda). **Higiene MCP**: no registres Playwright/Chrome DevTools como siempre-on; usa `/mcp-mode` y `/ui-check`. `security_audit_skill` si aplica.

#### Otros stacks
- **Flutter / Dart**: si hay skills de Flutter/Dart disponibles en el entorno del usuario, **sugiere** instalarlas o activarlas (no las instales sin aprobación). Complementan `flutter.md`.
- Cualquier otra herramienta de agente del stack: sugiere, no instales sin aprobación.

### PASO 5.1: Reglas del Stack
Por cada guía de `conventions`, copia `.cursor/skills/stack-conventions/references/[nombre].md` a `.cursor/rules/stack-[nombre].mdc` sin modificar su contenido (incluido el frontmatter con `globs`). Así Cursor la adjunta automáticamente al editar archivos del stack, también fuera de `/sdd`.
- No copies guías que no estén en `conventions` (ej. en un proyecto Django no se copia `fastapi`, aunque ambas usen `**/*.py`).
- Si una `stack-*.mdc` ya existe y difiere de su guía, muestra el diff y pregunta antes de reemplazarla.
- Las decisiones propias del proyecto no se escriben en la `.mdc` sino en **Convenciones** de `AGENTS.md`, para que la copia pueda refrescarse con `/sdd-update`.
- Si se quita una guía de `conventions`, borra su `stack-[nombre].mdc`.

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
Crea o actualiza con datos reales del proyecto. **No copies** los textos largos de `global-sdd` (GATE, DRY, formatos de consulta): esa regla ya es `alwaysApply`. En `AGENTS.md` solo hechos del proyecto + punteros cortos:

- **Nombre y Descripción**, **Stack y Estructura**, **Comandos**, **Convenciones**, **Reglas de Dominio**.
- Encabezado operativo corto (obligatorio):

  ```markdown
  ## Gobernanza SDD (puntero)
  - Antes de editar código/tests: GATE y `[EVALUACION SDD]` en `.cursor/rules/global-sdd.mdc` §0.
  - Integridad de tests (incl. Playwright / ui_check): `global-sdd` §2.1 — no acomodar el rojo; Reporte de Fallo + cierre.
  - Simplicidad / diseño: `global-sdd` §2.2–2.3 — solo como consulta.
  - UI/MCP: `/ui-check` y `/mcp-mode`; no DOM en el hilo de código.
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
- **Forma de Trabajar**: flujo SDD con subagentes (`@1-planner.md`, `@2-implementer.md`, `@3-qa-reviewer.md`) y regla de histórico (`history.md`, mover nunca borrar).
- **Límites**: qué hacer siempre, qué preguntar antes y qué no hacer nunca (incluye: no debilitar tests; no refactor de diseño sin consulta).
- **Verificación**: cómo dar una tarea por verificada en este proyecto.

### PASO 8: `MEMORY.md`
Crea o actualiza (máximo ~50 líneas):
- **Estado actual**, **Decisiones (y por qué)**, **Aprendizajes y errores a evitar**.
- **Próximos pasos**: si hay código sin specs, ingeniería inversa con `/retrofit`.

---

## Formato de Salida
1. Resumen del **Stack Detectado** (o de las respuestas de la entrevista) y versión del flujo SDD instalada.
2. Borrador de `## Perfil técnico` y `docs/constitution.md` (principios cortos; sin duplicar `global-sdd`).
3. Borrador de `AGENTS.md`: puntero **Gobernanza SDD** + **Código Compartido** + dominio/stack.
4. Guías `conventions`, `stack-*.mdc` y verificación sugerida.
5. Si Laravel: Boost con **`guidelines: false`**, MCP on; higiene MCP (sin Playwright/DevTools siempre-on).
6. 🛑 **DETENTE Y ESPERA** aprobación antes de escribir/instalar.
7. Tras aprobación: escribe Trinidad + `stack-*.mdc`; Boost si se aprobó.

---

## Comandos SDD Disponibles

| Comando | Propósito |
|---------|-----------|
| `/sdd` | Flujo completo SDD (8 fases) |
| `/retrofit` | Ingeniería inversa de código existente |
| `/architect` | Subagente planner |
| `/implement` | Subagente implementer (TDD) |
| `/review` | Subagente QA reviewer |
| `/security` | Auditoría de seguridad e integración en specs |
| `/validation-trace` | Valida trazabilidad HU ↔ RF ↔ arquitectura ↔ tests |
| `/validation-properties` | Valida propiedades de corrección |
| `/sdd-archive` | Cierra la iteración de un módulo en `history.md` |
| `/sdd-update` | Actualiza el flujo desde el paquete `sdd-kit` |
| `/ui-check` | Verificación visual aislada (veredicto corto) |
| `/mcp-mode` | Encender/apagar MCPs pesados (`code` / `ui`) |
