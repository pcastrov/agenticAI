# SDD Kit — Spec-Driven Development para agentes de IA

Flujo de trabajo portátil para que agentes de IA (Claude Code, Codex, Gemini, Copilot, Junie u otros) desarrollen software guiados por especificaciones: primero el **qué** y el **por qué** (`spec.md`), luego el **cómo** (`plan.md`), después el **paso a paso** (`tasks.md`), implementación con **TDD estricto** y validación QA en cada etapa.

Es **agnóstico de lenguaje y framework**: funciona igual en Laravel, Python, Node, Go o cualquier otro stack. Lo único que cambia entre proyectos es el bloque `## Perfil técnico` de `AGENTS.md`, que genera `/init`.

Inspirado en el flujo de specs de distintas metodologías (requisitos EARS, diseño, tareas y propiedades de corrección), adaptado a subagentes.

Versión actual: ver la primera entrada de [CHANGELOG.md](CHANGELOG.md).

Todo el paquete vive dentro de `.agents/`; su documentación está en `.agents/sdd-kit/` (este `README.md` y `CHANGELOG.md`) para no mezclarse con el `README.md` y el `CHANGELOG.md` propios de cada proyecto.

---

## Instalación en un proyecto

Origen público del paquete: [github.com/pcastrov/agenticAI](https://github.com/pcastrov/agenticAI).

1. Obtén el paquete (clona el repo o descarga el ZIP) y copia la carpeta `.agents/` a la raíz del proyecto (si el proyecto ya tiene `.agents/`, combina las carpetas; el paquete no pisa archivos propios del stack). Es lo único que se copia al proyecto: el flujo vive dentro de `.agents/`.
2. Comprueba que `.agents/sdd-kit.md` tenga `source: https://github.com/pcastrov/agenticAI` (o una ruta local si trabajas contra un clone en disco).
3. Indica a tu agente que lea `.agents/rules/global-sdd.md` y que los comandos están en `.agents/commands/`.
4. Ejecuta `/init` (o pide seguir `.agents/commands/init.md`):
   - **Proyecto existente**: detecta el stack desde los manifiestos y pregunta solo lo ambiguo.
   - **Proyecto nuevo**: hace una entrevista corta (lenguaje, framework, BD, tests, linter, UI, despliegue) con valores por defecto.
   - Genera `AGENTS.md` (con `## Perfil técnico`), `docs/constitution.md` y `MEMORY.md`.
5. Si el proyecto ya tiene código, ejecuta `/retrofit` para documentarlo en `specs/`.
6. Para cualquier cambio, usa `/sdd`.

Para actualizar un proyecto a una versión nueva del paquete: `/sdd-update` (lee `source`; si es la URL del repo, clona temporalmente y compara).

---

## Trinidad de contexto

| Archivo | Contiene | Cambia |
|---------|----------|--------|
| `AGENTS.md` | Hechos del proyecto: stack, versiones, estructura, comandos, convenciones, reglas de dominio y `## Perfil técnico` | Cuando cambia el stack |
| `docs/constitution.md` | 6 principios no negociables (puede citar el stack, nunca versiones ni comandos) | Casi nunca |
| `MEMORY.md` | Estado actual, decisiones y aprendizajes | Por iteración |

### Perfil técnico

Los subagentes nunca asumen un comando o framework: leen estas claves de `AGENTS.md`. Si una falta o dice `no configurado`, se detienen y preguntan.

```markdown
## Perfil técnico
- **language**: Python 3.12
- **framework**: FastAPI 0.115
- **database**: PostgreSQL 16
- **test**: pytest
- **test_single**: pytest -k {name}
- **lint**: ruff check . && ruff format --check .
- **run**: uvicorn app.main:app --reload
- **migrate**: alembic upgrade head
- **structure**: código en `app/`; tests en `tests/`
- **ui_check**: no aplica
- **security_audit_skill**: no configurado
- **conventions**: fastapi
```

### Convenciones por stack

La skill `stack-conventions` contiene una guía de código idiomático por framework: `laravel`, `filament`, `nativephp`, `django`, `fastapi` y `flutter`. Cada regla es **Debe** (si se incumple, el QA bloquea) o **Preferir** (solo sugerencia), y cada guía termina con su **Verificación Automática** (linters y tests de arquitectura).

Las guías se usan de dos formas:
- **En el flujo SDD**: el planner, el implementador y el QA leen solo las guías de la clave `conventions`.
- **Como regla del proyecto**: `/init` copia esas guías a `.agents/rules/stack-[nombre].md` para que el agente las use al trabajar el stack, también fuera de `/sdd`. `/sdd-update` las refresca.

Orden de prioridad: `docs/constitution.md`, luego **Convenciones** de `AGENTS.md` (lo propio del proyecto), luego las guías y por último los Principios Generales. Las guías aplican al código nuevo o modificado; alinear código viejo se propone como tarea.

### Simplicidad: DRY, KISS y YAGNI

Para evitar duplicación y sobreingeniería, los tres subagentes revisan:
- **DRY**: si ya existe una función, clase, consulta, validación o componente que haga lo mismo.
- **KISS**: si hay capas o abstracciones que el requisito no necesita.
- **YAGNI**: si hay algo que ningún `RF-x` pide hoy.

Quién lo revisa y cuándo:
- **`1-planner`**: busca una sola vez por iteración, al diseñar `plan.md`. Lo que propone reutilizar queda en la sección "1.1 Reutilización y Simplicidad" y lo apruebas junto con el plan.
- **`2-implementer`**: no vuelve a buscar. Usa lo aprobado en el plan y consulta si encuentra algo más.
- **`3-qa-reviewer`**: lo revisa en la validación de arquitectura (MODO 3) y de código (MODO 2).

**Todo es sugerencia.** Ningún agente une, extrae, reutiliza ni modifica código por su cuenta, porque el código puede ser así a propósito. Cada hallazgo es una `CONSULTA DE SIMPLICIDAD` con el principio, las opciones ("mejorarlo así" o "dejarlo igual") y su impacto, y el agente espera tu decisión. En QA estas consultas no bloquean el veredicto. Si decides dejarlo igual, el motivo se anota en `AGENTS.md` o `MEMORY.md` para no volver a preguntarlo.

**Alcance acotado.** Nunca se recorre todo el proyecto. Solo se busca en dos zonas:
- el catálogo `## Código Compartido` de `AGENTS.md`, con bases y helpers propios que usan varios módulos (lo crean `/init` y `/retrofit`);
- los archivos del módulo activo.

Solo cuenta el código propio: archivos versionados en las carpetas de `structure`, sin `vendor/`, código generado ni las exclusiones de cada stack. Si algo genérico no está en el catálogo, el agente pregunta en vez de buscarlo.

**Qué no es duplicación.** El código declarativo del framework que se parece entre módulos (por ejemplo, la tabla de Clientes y la de Vendedores en Filament) es normal. Lo que se consulta es la misma regla de negocio o el mismo método en dos lugares. Un bloque propio repetido solo se propone extraer a partir de su tercera aparición. Cada guía de `stack-conventions` tiene su sección "DRY en este stack". Detalle completo en `global-sdd.md`, sección 2.2.

---

## Estructura de specs

```text
specs/NNN-[id-nombre-modulo]/
├── spec.md     # Índice "Ya implementado" + HU con criterios DADO/CUANDO/ENTONCES, RF (EARS + MoSCoW), RN, RNF, restricciones, integraciones, casos límite, propiedades, trazabilidad
├── plan.md     # Estructura vigente + arquitectura de lo pendiente, trazabilidad RF ↔ archivo, decisiones técnicas
├── tasks.md    # Solo tareas pendientes: prioridad, propiedades validadas, tests asociados, "Hecho cuando"
├── history.md  # Histórico append-only de iteraciones cerradas
└── diagramas/
    ├── HU-01-negocio.md   # Secuencia para cualquier persona (va con spec.md)
    └── HU-01-tecnico.md   # Secuencia por capas y archivos (va con plan.md)
```

### Diagramas de secuencia (Mermaid)

Cada historia tiene dos diagramas del mismo flujo:

- **Negocio**: actores, el "Sistema" como caja negra y los sistemas externos, con mensajes en lenguaje natural. Cada caso límite es un bloque `alt` y cada mensaje cita el `RF` o `RN` que lo exige. Lo entiende cualquier persona.
- **Técnico**: el mismo flujo desglosado en las capas del plan (interfaz, servicio, autorización, persistencia, integraciones), con transacciones y errores.

Los diagramas describen el **flujo vigente**: se actualizan en su lugar y no se archivan; `history.md` solo registra qué cambió.

Cada diagrama es un archivo Markdown con un bloque ` ```mermaid ` (`sequenceDiagram`).

**Para visualizarlos** en Cursor o VS Code, abre el `.md` y usa la vista previa de Markdown (`Ctrl+Shift+V`, o `Ctrl+K` `V` para abrirla al lado). No requiere extensiones ni Java. GitHub y GitLab también los dibujan al abrir el archivo.

### Documentos activos vs histórico

Para que los agentes no relean todo lo ya hecho en cada interacción:

- `spec.md`, `plan.md` y `tasks.md` contienen **solo lo pendiente**. `spec.md` mantiene un índice `0. Ya implementado` con una línea por RF cerrado.
- Al cerrar una iteración (QA aprobado o `/sdd-archive`), lo completado se **mueve** a `history.md`: HU y RF con su texto completo, propiedades, decisiones, arquitectura y tareas `[x]`. Nunca se borra.
- Los agentes consultan `history.md` solo si el usuario lo pide o si la tarea se parece a algo ya hecho, y siempre buscando por ID o palabra clave, nunca leyéndolo completo.
- Los IDs (`HU`, `RF`, `RN`, `P`, `T`, `S`, `VULN`) continúan desde el máximo histórico y nunca se reutilizan.

---

## Flujo `/sdd` (8 fases)

```mermaid
flowchart LR
  F1["1 Spec"] --> F2["2 QA spec"] --> F3["3 Plan y tareas"] --> F4["4 QA arquitectura"] --> F5["5 QA tareas"] --> F6["6 TDD"] --> F7["7 QA final"] --> F8["8 Cierre: history.md"]
  F7 -->|"CAMBIOS NECESARIOS (max 2)"| F6
```

Cada fase se detiene a pedir aprobación del usuario antes de avanzar.

**Antes de la fase 1**, `/sdd` evalúa si la petición merece especificación. Si es un cambio pequeño que no toca requisitos, reglas de negocio ni contratos (typo, estilos, un bug que viola un RF ya existente), lo dice con su justificación y propone un **cambio directo** (`2-implementer` MODO C), sin spec. El usuario decide.

**Tests que fallan**: nunca se modifica ni se debilita un test existente para que pase. Cada fallo produce un Reporte de Fallo con qué falló, dónde, causa probable con evidencia y una propuesta:
- Corregir ahora, solo si es pequeño y está dentro de la tarea.
- Nueva tarea con test de regresión.
- Pasar por SDD.

El QA revisa en el diff que no se hayan tocado tests sin justificación.

| Subagente | Rol | Escribe en |
|-----------|-----|------------|
| `1-planner` | Especifica (HU + EARS), genera diagramas de secuencia, diseña, genera tareas, valida trazabilidad, genera propiedades, archiva iteraciones | Solo `specs/` |
| `2-implementer` | Una tarea a la vez con TDD (rojo → verde), usando el Perfil técnico | Código y tests |
| `3-qa-reviewer` | Valida spec, arquitectura, tareas e implementación; emite `VEREDICTO: APROBADO` / `CAMBIOS NECESARIOS` | Nada (solo lectura) |

### Calidad exigida
- **5 atributos por requisito**: claro (una sola interpretación), útil (cubre una historia), comprobable (criterio de aceptación o propiedad), trazable (ID y origen) y actualizado (no contradice lo implementado). El QA los evalúa RF por RF.
- **Tipos de requisito**: funcionales (`RF`), no funcionales (`RNF`), restricciones (técnicas y legales), negocio/usuario (`HU` y, si hace falta, `RN`) y datos e integraciones externas.
- **Historias de usuario** (`HU-x`): "Como [rol], quiero [objetivo] para [beneficio]", con criterios de aceptación `CA-x.y` en formato DADO / CUANDO / ENTONCES, cada uno con su test.
- **RF en notación EARS** (CUANDO / MIENTRAS / SI … EL SISTEMA DEBE …), cada uno con la historia que cubre.
- **Reglas de negocio** (`RN-x`, opcionales): solo cuando la regla la usan 2 o más RF, viene de fuera del equipo o es un dato que cambia seguido.
- **Priorización MoSCoW** (`Must` / `Should` / `Could`; `Won't` = Fuera de alcance) en historias y requisitos. Es independiente de la prioridad de tareas, que mide el orden técnico; un RF `Must` debe tener tareas `blocker` o `required`.
- **Propiedades de corrección** formales ("Si X, entonces Y"; "Para todo X, se cumple Y") para RF críticos.
- **Trazabilidad** HU ↔ RF ↔ archivo ↔ test ↔ propiedad.
- **Tareas** con prioridad (`blocker` / `required` / `optional` / `nice-to-have`), propiedades, tests y "Hecho cuando".

---

## Comandos

| Comando | Propósito |
|---------|-----------|
| `/init` | Detecta stack o entrevista; genera Trinidad y Perfil técnico |
| `/sdd` | Flujo completo (8 fases) |
| `/retrofit` | Ingeniería inversa de código existente a `specs/` |
| `/architect` | Subagente planner (modos 1-6) |
| `/implement` | Subagente implementer (TDD) |
| `/review` | Subagente QA reviewer (modos 1-4) |
| `/security` | Auditoría de seguridad (skill del stack o checklist OWASP) e integración en specs |
| `/validation-trace` | Trazabilidad HU ↔ RF ↔ arquitectura ↔ tests |
| `/validation-properties` | Validación y generación de propiedades de corrección |
| `/sdd-archive` | Cierre manual de iteración hacia `history.md` |
| `/sdd-update` | Actualiza el flujo desde `source` (URL pública o ruta local) |

---

## Archivos del paquete

Lista usada por `/sdd-update` para saber qué archivos le pertenecen (todo lo demás en `.agents/` es del proyecto y no se toca):

```text
.agents/sdd-kit.md
.agents/sdd-kit/README.md
.agents/sdd-kit/CHANGELOG.md
.agents/rules/global-sdd.md
.agents/subagents/1-planner.md
.agents/subagents/2-implementer.md
.agents/subagents/3-qa-reviewer.md
.agents/commands/sdd.md
.agents/commands/init.md
.agents/commands/retrofit.md
.agents/commands/architect.md
.agents/commands/implement.md
.agents/commands/review.md
.agents/commands/security.md
.agents/commands/validation-trace.md
.agents/commands/validation-properties.md
.agents/commands/sdd-archive.md
.agents/commands/sdd-update.md
.agents/skills/sdd-docs-generator/SKILL.md
.agents/skills/sdd-docs-generator/references/spec-template.md
.agents/skills/sdd-docs-generator/references/plan-template.md
.agents/skills/sdd-docs-generator/references/tasks-template.md
.agents/skills/sdd-docs-generator/references/history-template.md
.agents/skills/sdd-docs-generator/references/sequence-business-template.md
.agents/skills/sdd-docs-generator/references/sequence-technical-template.md
.agents/skills/stack-conventions/SKILL.md
.agents/skills/stack-conventions/references/laravel.md
.agents/skills/stack-conventions/references/filament.md
.agents/skills/stack-conventions/references/nativephp.md
.agents/skills/stack-conventions/references/django.md
.agents/skills/stack-conventions/references/fastapi.md
.agents/skills/stack-conventions/references/flutter.md
```

## Qué NO va en este paquete

Herramientas, skills de terceros o configuración propios de un stack (p. ej. Laravel Boost, skills de Flutter/Dart, auditores de seguridad de un framework, linters, comandos de setup de entorno, `.agents/mcp.json`). No van dentro del paquete SDD; se instalan en cada proyecto.

Con Laravel, `/init` y `/retrofit` proponen e instalan **Laravel Boost** por defecto (paquete Composer + MCP con Search Docs + guidelines/skills). En el retrofit, Boost sirve para leer esquema, modelos y docs reales. Otros stacks: solo sugiere. El Perfil técnico referencia lo instalado (p. ej. `security_audit_skill`, `lint`).

Las **guías de convenciones** (`stack-conventions`) sí van en el paquete: son texto, se cargan solo si están en `conventions` y las reglas `stack-*.md` que genera `/init` son del proyecto.

## Cómo evolucionar el paquete

1. Haz el cambio aquí (no en la copia de un proyecto) o tráelo desde el proyecto donde se probó.
2. Agrega una entrada al inicio de `.agents/sdd-kit/CHANGELOG.md` con la nueva versión y, si cambia la estructura de `specs/`, los pasos de migración.
3. Actualiza `version` en `.agents/sdd-kit.md`.
4. En cada proyecto, ejecuta `/sdd-update`.
