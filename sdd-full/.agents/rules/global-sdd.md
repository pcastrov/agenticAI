---
description: Principios SDD e ingeniería inmutables para todo el repo
alwaysApply: true
---

# Global Rule: Spec-Driven Development (SDD) & Engineering Standards

## 0. GATE OBLIGATORIO ANTES DE EDITAR O EJECUTAR
Aplica a **toda** petición, antes de `Write` / `StrReplace` / `Edit` / mutaciones por `Bash` sobre código o tests:

1. **Pregunta vs acción**: si el usuario solo pregunta, consulta o pide analizar → **PROHIBIDO** tocar archivos. Solo responde.
2. **Compuerta SDD**: antes de modificar código fuente o tests, escribe en el chat:
   ```
   [EVALUACION SDD]
   - Clasificación: Cambio Directo | Requiere Spec/Task
   - Motivo: [1 línea]
   - Spec/tarea: [ruta o "ninguna aún"]
   - Aprobación: pendiente | ya aprobada (cita la frase del usuario)
   ```
   Si la aprobación es `pendiente` → **DETENTE**. No invoques herramientas de escritura en ese turno.
3. **Compuerta de fallo** (suite `test` / `test_single`, E2E, **Playwright**, **Chrome DevTools**, `ui_check`): si falla → **PROHIBIDO** auto-arreglar en bucle, cambiar selectores/aserciones para ocultar el error o crear tests alternativos "para que pase". Emite `REPORTE DE FALLO` (plantilla en `2-implementer`) y espera orden del usuario.

Criterios de **Cambio Directo** vs **SDD completo**: ver `/sdd` (Evaluación de Alcance). Detalle de integridad de tests, DRY/KISS/YAGNI y diseño: secciones 2.1–2.3 abajo.

---

## 1. Misión Global
Principios inmutables para todos los agentes, subagentes, comandos y skills. Agnóstica de lenguaje y framework.

## 2. Invocación Obligatoria del Flujo SDD
Ante cambio, bugfix, funcionalidad o refactor:
- 🚫 **PROHIBIDO** modificar código sin pasar por la evaluación SDD (sección 0).
- ⚙️ Ejecuta `/sdd`: escanea `specs/` → evalúa alcance → spec/plan/tasks o cambio directo (MODO C de `2-implementer`) tras confirmación.
- 🛑 Presenta la evaluación y espera confirmación antes de tocar código.

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

## 6. Estructura de Módulos (`specs/`)

```text
specs/NNN-[id-nombre-modulo]/
├── spec.md | plan.md | tasks.md | history.md | diagramas/
```

Diagramas vigentes se actualizan in-place. Lectura: activos primero; `history.md` solo por ID/keyword. Cierre: mover a `history.md`, nunca borrar. IDs `HU`/`RF`/`RN`/`P`/`T`/`S` estables.

**Compactación**: si `history.md` > ~300 líneas, al cerrar (`1-planner` MODO 6 / `/sdd-archive`) compactar iteraciones anteriores a las 3 más recientes (IDs + decisiones clave + tests; sin tareas detalladas viejas).

## 7. Flujo SDD (Fases 1-8)
1 Spec → 2 QA spec → 3 Plan/tareas → 4 QA arquitectura → 5 QA tareas → 6 TDD → 7 QA final → 8 Cierre `history.md`. Detalle y orquestación: `/sdd`.

## 8. Comandos
`/validation-trace`, `/validation-properties`, `/sdd-archive`, `/sdd-update`, `/ui-check`, `/mcp-mode`.

## 9. Calidad de Specs
5 atributos, tipos RF/RNF/HU/RN, MoSCoW, trazabilidad HU↔RF↔archivos↔tests↔propiedades: skill `sdd-docs-generator`.
