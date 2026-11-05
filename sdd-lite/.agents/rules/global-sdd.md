---
description: SDD Lite — reglas cortas para modelos locales 8B-14B (16K-32K)
alwaysApply: true
---

# SDD Lite

## 0. REGLA ZERO — TRIAGE GATE (Turno 1, obligatorio)
1. Solo pregunta/análisis → **no** toques archivos.
2. Antes de cualquier edición, emite este bloque y clasifica:
   ```
   [TRIAGE SDD]
   - Nivel: 0 FAST-TRACK | 1 SDD-REQUIRED
   - Motivo: [1 línea]
   ```
3. **FAST-TRACK (Nivel 0)**: ≤ 1 archivo, < 15 líneas, sin impacto en BD (migraciones, esquema, seeds). Puedes editar directo; explica el motivo en 1 línea.
4. **SDD-REQUIRED (Nivel 1)**: cualquier otra tarea. **TERMINANTEMENTE PROHIBIDO generar código en este turno.** Solo emite el Spec atómico tabular (`spec-template.md`) y **espera aprobación**.
5. Duda entre 0 y 1 → Nivel 1.
6. Fallo de `test` / Playwright / `ui_check` → **STOP** + `REPORTE DE FALLO`. No acomodes tests ni auto-loops.

## 1. Flujo (3 pasos)
1. **Planear** (`/sdd`): lee `spec.md`; máx 3 preguntas; emite Spec tabular; pide OK.
2. **Implementar** (`/implement`): una tarea `- [ ]`; TDD rojo→verde; `test_single`.
3. **Cerrar** (`/sdd-archive`): tests OK → ficha atómica en `history/<dominio>.md` → 1 fila en `history/index.md`.

## 2. Specs (presupuesto tokens)
```text
specs/NNN-modulo/
├── spec.md              # activo, tabular, máx ~150 líneas
└── history/
    ├── index.md         # tabla dominio → shard, máx 30 líneas
    └── <dominio>.md     # ficha atómica por dominio, máx 100 líneas
```
- Lee solo `spec.md` por defecto.
- Historial: consulta `history/index.md` y abre **un solo** shard de dominio si hace falta.
- Shard lleno (100 líneas) → condensa entradas viejas del mismo dominio; no crees archivos extra.

## 3. Tests e integridad
No ignores el rojo. No debilites tests/E2E/Playwright. Cierre: corregir código | tarea nueva | reabrir plan. Detalle de reporte: subagente implementer.

## 4. Simplicidad
DRY/KISS/YAGNI solo como pregunta corta al usuario. No refactorices solo.

## 5. UI / MCP
Navegador apagado al programar. UI → `/ui-check` o skill `on-demand-tools` (CLI). Veredicto ≤5 líneas.

### 5.1 Convenciones de framework (opcionales)
Si existe una guía en `skills/stack-conventions/references/`, léela antes de implementar. Si la carpeta está vacía, falta el archivo o la skill fue eliminada, asume que no hay convenciones forzadas y usa buenas prácticas estándar del lenguaje. Sin error ni preguntas.

## 6. Idioma
Usuario y `specs/`: español. Código: según constitution.

## 7. Trinidad
`AGENTS.md` (Perfil técnico + dominio; sin textos largos), `docs/constitution.md`, `MEMORY.md` (corto).
