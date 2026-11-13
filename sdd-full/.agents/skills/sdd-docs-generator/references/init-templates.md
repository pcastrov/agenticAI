# Plantillas Trinidad (`/sdd-init`)

Leer **bajo demanda** antes de escribir `AGENTS.md`, `MEMORY.md` o `docs/constitution.md`. Sustituye `<raíz>` por `.cursor` o `.agents` según el host.

---

## 1. `AGENTS.md` — GATE compacto

Usar si el host **carga reglas automáticamente**:
- Cursor (`.cursor/rules/global-sdd.mdc` con `alwaysApply`)
- OpenCode (`opencode.json` → `instructions` incluye `rules/global-sdd.md`)
- Claude Code / Copilot (archivo puente que apunta a la raíz del kit)

```markdown
## Gobernanza SDD (GATE)
Antes de diagnosticar a fondo o editar código/tests: ejecuta `<raíz>/rules/global-sdd.md` §0 (`[ANCLAJE]` → `[TRIAGE SDD]`).
Aplica con o sin `/sdd`. Detalle y plantillas de bloques: solo en esa regla (no duplicar aquí).
```

---

## 2. `AGENTS.md` — GATE completo

Usar **solo** si el host **no** carga reglas solo (Pi sin extensión fiable, chat libre sin `instructions` / puente). Sustituye `<raíz>` al materializar.

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

---

## 3. `AGENTS.md` — Perfil técnico

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

---

## 4. `AGENTS.md` — Código Compartido

```markdown
## Código Compartido
| Qué | Ubicación | Usar cuando |
|-----|-----------|-------------|
| [Base de reportes PDF (clase abstracta)] | `[app/Reports/BaseReport.php]` | [Cualquier reporte PDF: se extiende, no se crea otro generador] |
```

---

## 5. `docs/constitution.md`

Máximo ~18 líneas. Siete principios innegociables:

```markdown
# Constitución del proyecto

1. **Simplicidad del Stack**: Priorizar convenciones nativas del framework antes de instalar librerías de terceros.
2. **Relación Spec-Código**: Ningún código existe ni se modifica sin un Requisito Funcional (`RF-x`) o Tarea previa en `specs/`.
3. **Separación Lógica / UI**: Desacoplar la lógica de negocio de los componentes visuales o vistas.
4. **Integridad de Tests**: Suite + E2E/`ui_check`/Playwright. No acomodar el rojo; Reporte de Fallo y cierre (código | tarea | SDD). Detalle: `global-sdd` §2.1.
5. **Revisión de diseño (sugerencia)**: Consulta al usuario; sin refactor por iniciativa. Detalle: `global-sdd` §2.3.
6. **Protección de Datos**: Respeto estricto a autorizaciones, validaciones de entrada y manejo seguro de datos.
7. **Idioma**: Código, variables y comentarios en **Inglés**; documentación en `specs/`, UI e interfaces al usuario en **Español** (ajustable si el usuario indica otro).
```

---

## 6. `MEMORY.md`

**Ventana deslizante**: solo los **últimos 2–3** cambios, decisiones o trampas activas (máx. **~20 líneas** en total). No bitácora; el histórico íntegro vive en `specs/<modulo>/history/`. Al cerrar una iteración (`/sdd-archive` o Nivel 0 relevante), si ya hay 3 entradas → **reemplaza/desplaza** la más antigua.

```markdown
# MEMORY

> Máx. 2–3 entradas recientes (~20 líneas). Lo antiguo → `history/`.

## Reciente (desliza al añadir)
- [YYYY-MM-DD] Decisión/trampa/estado: …
- [YYYY-MM-DD] …
- [YYYY-MM-DD] …

## Próximo (opcional, 1 línea)
- [si hay código sin specs → `/retrofit`]
```
