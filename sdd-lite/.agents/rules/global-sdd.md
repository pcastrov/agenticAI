---
description: SDD Lite — reglas cortas para modelos locales 8B-14B (16K-32K)
alwaysApply: true
---

# SDD Lite

## 0. REGLA ZERO — TRIAGE GATE (Turno 1, obligatorio)
Aplica aunque el usuario **no** escriba `/sdd` ni `/implement`.
1. Solo pregunta/análisis → **no** toques archivos.
2. Si la instrucción implica cambiar código/funcionalidad → emite este bloque **antes** de editar:
   ```
   [TRIAGE SDD]
   - Nivel: 0 FAST-TRACK | 1 SDD-REQUIRED
   - Motivo: [1 línea]
   ```
3. **FAST-TRACK (Nivel 0)**: ≤ 1 archivo, < 15 líneas, sin impacto en BD. Edición directa; motivo en 1 línea.
4. **SDD-REQUIRED (Nivel 1)**: cualquier otra tarea. **PROHIBIDO generar código en este turno.** Escribe Spec tabular y **espera aprobación**.
5. Duda 0 vs 1 → Nivel 1.
6. 🛑 Tras escribir `spec.md` (con sección Tareas) → espera OK. No implementes en el mismo turno.
7. Antes de la 1.ª tarea: pregunta `[CADENCIA TDD]` A una-a-una | B lote. Sin respuesta → **A**. En A, 🛑 tras cada `- [x]`.
8. Fallo de `test` / Playwright / `ui_check` → **STOP** + `REPORTE DE FALLO`. No acomodes tests.

## 1. Flujo (3 pasos)
1. **Planear** (`/sdd` o pedido Nivel 1 sin slash): Triage → Spec tabular → 🛑 OK.
2. **Implementar**: cadencia A/B → TDD; en A una tarea y STOP.
3. **Cerrar** (`/sdd-archive`): tests OK → `history/<dominio>.md` + fila en `history/index.md`.

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
