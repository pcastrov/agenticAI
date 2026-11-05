# /retrofit (Lite) — Ingeniería inversa compacta

## PASO 0 — Lectura obligatoria
Abre:
1. `subagents/1-planner.md`
2. `skills/sdd-docs-generator/references/spec-template.md`
3. `skills/sdd-docs-generator/references/history-index-template.md`
4. `skills/sdd-docs-generator/references/domain-shard-template.md`
5. `## Perfil técnico` de `AGENTS.md` (Si falta → `/sdd-init`)

## Entregables por módulo (`specs/<NNN>-<id-kebab>/`, ej. `001-api-tasks`)
1. Carpeta con **nombre real** (siguiente `001`, `002`… + id kebab). 🚫 no uses `NNN-...` literal.
2. **`history/index.md`** (≤30 líneas) + **`history/<dominio>.md`** por dominio cerrado (ficha ≤100 líneas; Iteración 1 — Retrofit).
3. **`spec.md`**: solo lo pendiente / deuda / sin tests, con sección **Tareas** `- [ ]`.
4. Sin diagramas obligatorios. Boost Laravel opcional con `guidelines: false`.

## Prohibido
- Carpetas `NNN-...` / placeholders de plantilla como ruta.
- `history/tareas_completadas.md` u otros nombres inventados.
- Crear `plan.md` / `tasks.md` (Lite no los usa).
- Escribir código de aplicación durante el retrofit.
