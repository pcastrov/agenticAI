---
description: Principios SDD e ingeniería inmutables para todo el repo
alwaysApply: true
---

# Global Rule: Spec-Driven Development (SDD) & Engineering Standards

## 0. GATE OBLIGATORIO ANTES DE EDITAR O EJECUTAR
> **OpenCode / Pi / chat libre:** este archivo solo se aplica si el host lo carga. Por eso `/sdd-init` **copia el GATE a `AGENTS.md`** (primera sección) y, en OpenCode, `opencode.json` → `instructions` apunta aquí. Si `AGENTS.md` no tiene el bloque GATE, **no edites código** hasta corregirlo con `/sdd-init` o `/sdd-update`.

Aplica a **toda** petición (con o **sin** slash `/sdd`, `/implement`, etc.), antes de `Write` / `StrReplace` / `Edit` / mutaciones por `Bash` sobre código o tests:

1. **Pregunta vs acción**: si el usuario solo pregunta, consulta o pide analizar → **PROHIBIDO** tocar archivos. Solo responde.
2. **Sin `/sdd` también aplica**: si la instrucción implica crear/cambiar funcionalidad, bugfix, API, BD, multi-archivo o refactor → **igual** emites `[TRIAGE SDD]` en el Turno 1. No hace falta que el usuario escriba `/sdd`.
3. **REGLA ZERO — TRIAGE GATE (Turno 1, obligatorio)**: antes de modificar código fuente o tests **detente y clasifica** en el chat:
   ```
   [TRIAGE SDD]
   - Nivel: 0 FAST-TRACK | 1 SDD-REQUIRED
   - Motivo: [1 línea]
   - Spec/tarea: [ruta o "ninguna aún"]
   - Aprobación: n/a (Nivel 0) | pendiente | ya aprobada (cita la frase del usuario)
   ```
   - **FAST-TRACK (Nivel 0)**: ≤ 1 archivo, arreglo menor, sin impacto de arquitectura (sin cambios de contrato, modelo de datos, seguridad ni dependencias). Permite edición inmediata explicando el motivo brevemente.
   - **SDD-REQUIRED (Nivel 1)**: lógica de negocio, base de datos o multi-archivo. **TERMINANTEMENTE PROHIBIDO emitir bloques de código o diffs** en este turno: entra al flujo SDD (spec → plan → tasks → TDD) y pide **aprobación explícita** en cada parada. Aprobación `pendiente` → **DETENTE**, sin herramientas de escritura sobre código.
   - Duda entre Nivel 0 y 1 → Nivel 1.
4. **Paradas de fase (Nivel 1)**: 🛑 tras crear/actualizar `spec.md`; 🛑 tras `plan.md`; 🛑 tras `tasks.md`. No encadenes la siguiente fase sin OK del usuario.
5. **Cadencia TDD**: antes de la primera tarea pendiente, pregunta:
   ```
   [CADENCIA TDD]
   A) Una por una — me detengo tras cada tarea para que revises
   B) Todas seguidas — continuo hasta terminar el lote o hasta un fallo
   ```
   Sin respuesta clara → **A**. En modo A, tras cada `- [x]` 🛑 y pregunta si sigue la siguiente.
6. **Compuerta de fallo** (suite `test` / `test_single`, E2E, **Playwright**, **Chrome DevTools**, `ui_check`): si falla → **PROHIBIDO** auto-arreglar en bucle, cambiar selectores/aserciones para ocultar el error o crear tests alternativos "para que pase". Emite `REPORTE DE FALLO` (plantilla en `2-implementer`) y espera orden del usuario.

Criterios de **Nivel 0** vs **Nivel 1**: ver `/sdd` (Evaluación de Alcance). Detalle de integridad de tests, DRY/KISS/YAGNI y diseño: secciones 2.1–2.3 abajo.

---

## 1. Misión Global
Principios inmutables para todos los agentes, subagentes, comandos y skills. Agnóstica de lenguaje y framework.

## 2. Invocación Obligatoria del Flujo SDD
Ante cambio, bugfix, funcionalidad o refactor (**aunque el usuario no escriba `/sdd`**):
- 🚫 **PROHIBIDO** modificar código sin pasar por la evaluación SDD (sección 0).
- ⚙️ Aplica el mismo flujo que `/sdd`: escanea `specs/` → Triage → spec / plan / tasks (con paradas) o cambio directo Nivel 0 (MODO C) tras confirmación.
- 🛑 Presenta el Triage y espera; en Nivel 1 no toques código hasta tener spec (y luego plan/tasks) aprobados.

### 2.1 Integridad de los Tests (obligatorio)
- Un test/verificación que falla se **reporta**, no se acomoda. 🚫 **PROHIBIDO ignorar el rojo**.
- 🚫 **PROHIBIDO** modificar, borrar, saltar, comentar o debilitar un test **o** aserción E2E/Playwright/`ui_check` existente para que pase (salvo spec aprobada o aprobación explícita tras reporte).
- Aplica igual a unitarios, integración, E2E, Playwright, Chrome DevTools y `ui_check`.
- Todo fallo → `REPORTE DE FALLO` (`2-implementer`). Cierre obligatorio: (1) corregir código ahora si es pequeño y en alcance; (2) tarea `- [ ]` en `tasks.md`; (3) abrir/ajustar SDD. Nunca se ignora el rojo.
- Tests **nuevos** (TDD) sí. Bug de comportamiento: primero test que lo reproduce.

### 2.2 Simplicidad: DRY, KISS y YAGNI
Revisan planner, implementer y QA. **Todo es sugerencia**: 🚫 prohibido unir/extraer/reutilizar/modificar por iniciativa propia. Cada hallazgo → `CONSULTA DE SIMPLICIDAD` y espera "sí".

**Alcance**: solo `## Código Compartido` de `AGENTS.md` + módulo activo (estructura de `plan.md` / archivos de la tarea). Código propio versionado; sin vendor/generados. Regla de tres para extracción.

```
CONSULTA DE SIMPLICIDAD — [DRY | KISS | YAGNI]
- Dónde: [ruta:línea] (y existente si aplica)
- Qué detecté: [...]
- Según [principio], podría ser:
  A) [mejora] — Impacto: [...]
  B) Dejarlo igual — [posible razón]
- ¿Lo mejoramos o lo dejamos igual?
```

### 2.3 Revisión de diseño (sugerencia)
Al crear código **propio** nuevo: si ves mejora de responsabilidades/acoplamiento → `CONSULTA DE DISEÑO`; no refactorices solo. Lo idiomático del framework no es deuda. No bloquea QA.

```
CONSULTA DE DISEÑO
- Dónde: [ruta o unidad]
- Qué vi: [responsabilidad / acoplamiento / extensibilidad / dependencia]
- Sugerencia: [...] — Impacto: [...]
- Alternativa: dejarlo igual — [...]
- ¿Aplicamos la sugerencia o lo dejamos igual?
```

### 2.4 UI / MCP bajo demanda
- No metas DOM completo ni snapshots largos en el hilo de programación.
- `ui_check` (Playwright / Chrome DevTools): preferir subagente/comando aislado o CLI; el hilo principal solo recibe un veredicto ≤5 líneas.
- MCPs de navegador: apagados por defecto al programar; encender solo en sesión UI (`/mcp-mode` / `/ui-check`).

## 3. Idioma y Comunicación
- Interacción con el usuario: **ESPAÑOL**.
- `specs/`: **ESPAÑOL**.
- Código: según `docs/constitution.md`.

## 4. Fuentes de Contexto (Trinidad)
- **`AGENTS.md`**: hechos del proyecto + `## Perfil técnico` + `## Código Compartido`. **No** duplicar aquí las secciones 0–2.3 de esta regla.
- **`docs/constitution.md`**: principios no negociables (prevalecen).
- **`MEMORY.md`**: estado, decisiones, aprendizajes.

## 5. Perfil Técnico
Claves en `AGENTS.md`: `language`, `framework`, `database`, `test`, `test_single`, `lint`, `run`, `migrate`, `structure`, `ui_check`, `security_audit_skill`, `conventions`. Si falta una necesaria → detente y pregunta. Prioridad convenciones: constitution > Convenciones de `AGENTS.md` > guías `conventions` > Principios Generales de `stack-conventions`.

### 5.1 Convenciones de framework (opcionales)
Antes de implementar código, **verifica si existe** un archivo de convención de framework dentro de `skills/stack-conventions/references/`. Si existe, lee sus directrices antes de implementar código. Si la carpeta está vacía o el archivo no existe (o la carpeta `skills/stack-conventions/` fue eliminada para ahorrar tokens), **asume que no hay convenciones forzadas de framework** y utiliza las mejores prácticas estándar del lenguaje. Nunca falles ni te detengas por esta ausencia, y no recrees las guías por tu cuenta.

## 6. Estructura de Módulos (`specs/`)

```text
specs/001-api-tasks/          # ejemplo REAL (nunca uses "NNN" literal)
├── spec.md | plan.md | tasks.md | diagramas/
└── history/
    ├── index.md          # mapa maestro (~20 líneas): dominio → archivo
    └── <dominio>.md      # un archivo por dominio (auth, billing…)
```

### Nomenclatura de carpeta (obligatoria)
- Formato: `specs/<NNN>-<id-kebab>/` donde `<NNN>` es **tres dígitos** (`001`, `002`, …) e `<id-kebab>` es un id corto en minúsculas con guiones (ej. `api-tasks`, `auth-login`).
- En plantillas, `NNN-[id-nombre-modulo]` es **solo un placeholder de documentación**. 🚫 **PROHIBIDO** crear carpetas o rutas literales llamadas `NNN-...`, `NNN-modulo`, `[id-nombre-modulo]`, etc.
- Al crear un módulo nuevo: lista `specs/`, toma el máximo número existente + 1 (si no hay ninguno → `001`), y elige el id según el dominio real (retrofit / `/sdd` / planner). Ejemplo: `specs/001-gestor-tareas/`.
- `/sdd-init` **no** crea módulos bajo `specs/`; como mucho puede dejar `specs/` vacío. El primer módulo lo crean `/sdd`, `/architect` o `/retrofit` con nombre real.

Diagramas vigentes se actualizan in-place. Lectura: activos primero; del historial lee `history/index.md` y **solo** el dominio relevante, buscando por ID/keyword. Cierre: mover al `history/<dominio>.md` correspondiente; **nunca borrar ni resumir** decisiones arquitectónicas (se segmentan por dominio, no se compactan). IDs `HU`/`RF`/`RN`/`P`/`T`/`S` estables.

## 7. Flujo SDD (Fases 1-8)
1 Spec → 2 QA spec → 3 Plan/tareas → 4 QA arquitectura → 5 QA tareas → 6 TDD → 7 QA final → 8 Cierre `history/`. Detalle y orquestación: `/sdd`.

## 8. Comandos
`/validation-trace`, `/validation-properties`, `/sdd-archive`, `/sdd-update`, `/ui-check`, `/mcp-mode`.

## 9. Calidad de Specs
5 atributos, tipos RF/RNF/HU/RN, MoSCoW, trazabilidad HU↔RF↔archivos↔tests↔propiedades: skill `sdd-docs-generator`.
