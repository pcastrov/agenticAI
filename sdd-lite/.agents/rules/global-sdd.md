---
description: SDD Lite — reglas cortas para modelos locales 16K-32K
alwaysApply: true
---

# SDD Lite

## 0. GATE (antes de editar)
1. Solo pregunta/análisis → **no** toques archivos.
2. Antes de editar código/tests, escribe:
   ```
   [EVALUACION SDD]
   - Clasificación: Cambio Directo | Requiere Spec/Task
   - Motivo: [1 línea]
   - Aprobación: pendiente | ok
   ```
   Si `pendiente` → **STOP**.
3. Fallo de `test` / Playwright / `ui_check` → **STOP** + `REPORTE DE FALLO`. No acomodes tests ni auto-loops.

## 1. Flujo (3 pasos)
1. **Planear** (`/sdd`): lee `summary.md` + `spec.md`; máx 3 preguntas; actualiza RF + archivos + tareas en `spec.md`; pide OK.
2. **Implementar** (`/implement`): una tarea `- [ ]`; TDD rojo→verde; `test_single`.
3. **Cerrar** (`/sdd-archive`): tests OK → actualiza `summary.md` → mueve a `history/h-NN.md` → 1 línea en índice de `spec.md`.

## 2. Specs (presupuesto tokens)
```text
specs/NNN-modulo/
├── spec.md      # máx ~150 líneas: índice historial + RF + diseño breve + tareas
├── summary.md   # máx ~100 líneas: foto actual + scratchpad
└── history/
    ├── h-01.md … h-NN.md   # máx ~150 líneas c/u; máx 3 shards recientes
    └── h-archive.md        # compactado frío
```
- Lee solo `spec.md` + `summary.md` por defecto.
- Historial: un solo `h-XX.md` si el índice lo pide; anota 3–5 líneas en `summary.md`.
- Al 4º shard: compacta el más viejo → `h-archive.md` (5–8 líneas) y **borra** el shard viejo.

## 3. Tests e integridad
No ignores el rojo. No debilites tests/E2E/Playwright. Cierre: corregir código | tarea nueva | reabrir plan. Detalle de reporte: subagente implementer.

## 4. Simplicidad
DRY/KISS/YAGNI solo como pregunta corta al usuario. No refactorices solo.

## 5. UI / MCP
Navegador apagado al programar. UI → `/ui-check` o skill `on-demand-tools` (CLI). Veredicto ≤5 líneas.

## 6. Idioma
Usuario y `specs/`: español. Código: según constitution.

## 7. Trinidad
`AGENTS.md` (Perfil técnico + dominio; sin textos largos), `docs/constitution.md`, `MEMORY.md` (corto).
