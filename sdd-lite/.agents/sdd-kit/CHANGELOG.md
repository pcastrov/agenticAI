# Changelog — SDD Lite

## 2.0.1 — 2026-11-04

### Cambiado
- Comandos Lite (`architect`, `implement`, `sdd`, `sdd-archive`, `review`, `retrofit`, `sdd-update`): **PASO 0 de lectura obligatoria** del subagente y de las plantillas con la herramienta de archivos (agnóstico a hosts que no expanden `@archivo`).
- Spec: la sección **Tareas** (`- [ ]`) dentro de `spec.md` es obligatoria; Lite no usa `plan.md`/`tasks.md` sueltos.
- Cierre: solo `history/index.md` + `history/<dominio>.md` (shards ≤100 líneas); **prohibido** inventar `tareas_completadas.md`.
- Tras marcar todas las tareas `[x]`, `/implement` y `/review` recuerdan `/sdd-archive`.

### Migración
`/sdd-update` o reinstalar Lite. No cambia specs existentes; corrige el comportamiento del agente en las siguientes corridas.

---

## 2.0.0 — 2026-11-04

Refactor integral: estándar ligero agnóstico al editor (modelos locales 8B–14B).

### Cambios (breaking)
- Se elimina `sdd-lite/.cursor/`; el origen es `sdd-lite/.agents/` con rutas relativas (sin prefijos). Al instalar se llama `.cursor/` (Cursor) o `.agents/` (otros): mismo contenido; en Cursor las reglas se instalan como `.mdc`.
- Regla Zero / Triage Gate: FAST-TRACK (Nivel 0) vs SDD-REQUIRED (Nivel 1, sin código hasta aprobar Spec).
- Se eliminan `summary.md`, `history-shard-template`, `history-archive-template` y `summary-template`.
- Nuevas plantillas: `history-index-template.md` (≤30 líneas), `domain-shard-template.md` (≤100 líneas, Few-Shot). `spec-template.md` pasa a formato tabular con Few-Shot.
- Convenciones de framework opcionales (`global-sdd.md` §5.1): sin guía o sin carpeta → buenas prácticas estándar, sin error.
- Opción Pi/OpenCode/Cline: genera `.pi/extensions/sdd-commands.ts` con los comandos de `commands/` como slash commands.
- Instaladores `setup_sdd_lite.sh` / `.ps1` (puente por agente + guía de framework opcional).
- `/review`: tabla de auditoría determinista contra el Git Diff.

### Migración
Proyectos con `history/h-NN.md`, `h-archive.md` o `summary.md`: `/sdd-update` pregunta y, si aceptas, `1-planner` los reorganiza a `history/index.md` + `history/<dominio>.md`.

## 1.0.0 — 2026-11-02

Primera edición lite para modelos locales 8B–14B (16K–32K).
