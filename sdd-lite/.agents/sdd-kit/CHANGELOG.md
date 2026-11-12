# Changelog — SDD Lite

## 3.0.0 — 2026-11-12

SDD Lite Compacto (Full Compacto para 8K–32K). **Cambio mayor.**

### Agregado
- **`[ANCLAJE]`** corto (Turno 0) antes del Triage; MEMORY activa (≤30 líneas).
- **Micro-Spec**: 1 HU · ≤5 tareas · `spec.md` ~85 líneas; 2 paradas (Qué → 🛑 → Cómo+Tareas → 🛑) en un solo archivo.
- **Subagentes nativos** `sdd-planner` / `sdd-implementer` / `sdd-qa-reviewer` → `.cursor/agents/`, `.claude/agents/`, `.opencode/agents/` (`mode: subagent`).
- Aislamiento: nativo por Task; fallback Pi/Ollama → chat limpio + `continúa` tras cada tarea (cadencia A).
- QA: runners silenciosos (`-q` / `--compact` / `--reporter=dot`).
- GATE compacto en `AGENTS.md` si el host auto-carga `global-sdd` (Pi: GATE completo).

### Cambiado
- Topes: `AGENTS.md` ≤45; `MEMORY.md` ≤30; history sin cambios (index ≤30, dominio ≤100).
- Instaladores: rutas de ayuda `sdd-lite/` (no `sdd-full/`); proyección de agents.
- Comandos/subagentes ultra-concisos (≤50 líneas).

### Migración
1. `/sdd-update` o reinstalar Lite.
2. Specs viejas: al iterar, divide en Micro-Specs (1 HU / ≤5 tareas) con 2 paradas.
3. Cursor/Claude/OpenCode: confirma carpeta `agents/` nativa.

---

## 2.0.5 — 2026-11-05

### Cambiado
- **Nomenclatura**: carpetas reales `001-<id>/` (nunca `NNN-...` literal). `/sdd-init` no crea módulos de ejemplo.

### Migración
`/sdd-update`. Renombra `specs/NNN-...` si ya se materializó el placeholder.

---

## 2.0.4 — 2026-11-05

### Cambiado
- OpenCode: genera `.opencode/commands/*.md` (slash commands).
- **`/init` → `/sdd-init`** en todos los hosts (evita choque con `/init` de OpenCode).

### Migración
Reinstalar o `/sdd-update`. Usa **`/sdd-init`**.

---

## 2.0.3 — 2026-11-05

### Cambiado
- GATE en `AGENTS.md`; OpenCode `opencode.json` → `instructions`.

### Migración
`/sdd-update` o reinstalar Lite + `/sdd-init`.

---

## 2.0.2 — 2026-11-04

### Cambiado
- Triage sin `/sdd`; 🛑 tras Spec; `[CADENCIA TDD]` A|B.

### Migración
`/sdd-update` o reinstalar Lite.

---

## 2.0.1 — 2026-11-04

### Cambiado
- Comandos Lite: **PASO 0 de lectura obligatoria** (subagente + plantillas).
- Spec con sección **Tareas** obligatoria; cierre solo `history/index.md` + `history/<dominio>.md`.
- Tras todo `[x]`: `/review` → `/sdd-archive`.

### Migración
`/sdd-update` o reinstalar Lite.

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
