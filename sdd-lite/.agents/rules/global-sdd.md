---
description: SDD Lite Compacto — ANCLAJE + Micro-Spec para ventanas 8K–32K
alwaysApply: true
---

# SDD Lite

## 0. GATE (antes de editar)
> Cursor/OpenCode/Claude/Copilot: `AGENTS.md` lleva **puntero** a esta regla. Pi/chat libre: GATE completo en `AGENTS.md`. Si falta, no edites hasta `/sdd-init` o `/sdd-update`.

Aplica con o **sin** `/sdd`. Antes de diagnosticar a fondo, proponer o editar:

1. Solo pregunta → **no** toques archivos (tras ANCLAJE si aplica).
2. **Turno 0 — ANCLAJE** (máx. 3 líneas de bloque; obligatorio):
   ```
   [ANCLAJE]
   - MEMORY: [hallazgo o "nada"] | Spec candidato: [ruta o "ninguna"]
   - ¿Ya existe?: sí (explicar) | no → Nivel 0 / Nivel 1
   ```
3. **Turno 1 — TRIAGE** (si vas a editar):
   ```
   [TRIAGE SDD]
   - Nivel: 0 FAST-TRACK | 1 SDD-REQUIRED
   - Motivo: [1 línea]
   ```
4. **Nivel 0**: ≤1 archivo, <15 líneas, sin impacto en BD. Edición directa. Al cerrar: 1 línea en MEMORY si hubo aprendizaje útil.
5. **Nivel 1**: **PROHIBIDO** código/diffs en ese turno. Micro-Spec con **2 paradas** (Qué → 🛑 OK → Cómo+Tareas → 🛑 OK).
6. Duda 0/1 → Nivel 1.
7. Antes de la 1.ª tarea: `[CADENCIA TDD]` A|B (default **A**). En A, 🛑 tras cada `- [x]`.
8. Test/UI rojo → **STOP** + `REPORTE DE FALLO`. No acomodes tests.

### Topes de contexto (8K–16K)
| Archivo | Máx. líneas | Notas |
|---------|-------------|--------|
| `AGENTS.md` | 45 | Perfil + estructura + reglas críticas (+ GATE puntero o completo) |
| `MEMORY.md` | 30 | Estado, decisiones, trampas; 1 línea al cerrar Nivel 0/archive si aporta |
| `spec.md` | ~85 | **Micro-Spec**: máx. **1 HU** y **5 tareas** por iteración |

Pedido más grande → divide; propone solo la **primera entrega**.

## 1. Flujo
1. ANCLAJE → Triage → Nivel 0 o Nivel 1.
2. Nivel 1: Parada Qué → 🛑 → Parada Cómo+Tareas → 🛑 → cadencia → TDD → `/review` → `/sdd-archive`.
3. Un solo `spec.md` (sin `plan.md`/`tasks.md`/diagramas). History: `index.md` ≤30 + `<dominio>.md` ≤100.

## 2. Specs
```text
specs/001-api-tasks/     # real — nunca "NNN-..." literal
├── spec.md              # Parte 1 Qué | Parte 2 Cómo+Tareas (~85 líneas)
└── history/
    ├── index.md         # ≤30
    └── <dominio>.md     # ≤100; condensa si llena
```
Lee solo `spec.md` por defecto. Historial: `index` + un shard. `/sdd-init` no crea módulos.

## 3. Tests
No ignores el rojo. No debilites tests. Cierre: código | tarea nueva | replanear. Runners en `/review`: flags compactos (`-q`, `--compact`, `--reporter=dot` si existen).

## 4–7
Simplicidad: pregunta corta; no refactor solo. UI: `/ui-check` o `on-demand-tools`. Convenciones opcionales. Idioma: specs ES; código según constitution. Trinidad: AGENTS + constitution + MEMORY (topes §0).
