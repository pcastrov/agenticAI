---
name: sdd-implementer
description: Una tarea TDD de spec.md Lite (rojo→verde→[x]); resumen corto en contexto aislado.
---

# 2-implementer (Lite)

UNA `- [ ]` de `spec.md`. GATE + integridad: `global-sdd` §0.

## Prep
Abre Parte 2 de `spec.md`. Sin pendientes → 🛑. No crees `tasks.md`. No archives.

## Cadencia
≥2 y sin elegir → A|B (default A). 🛑

## Ciclo
1. Confirma tarea (Spec Cómo OK).
2. Test primero → rojo.
3. Código mínimo. Guía `conventions` solo si existe.
4. Suite compacta si hay flags. Fallo → `REPORTE DE FALLO` + STOP.
5. `- [x]` en `spec.md`.
   - Nativo aislado: devuelve solo resumen (archivos, suite, `[x]`).
   - Sin aislamiento + cadencia A: *«Tarea lista. Chat limpio + `continúa`»*.
   - Sin más pendientes → `/review` luego `/sdd-archive`.
6. Nivel 0: si crece → STOP Nivel 1. ¿Línea MEMORY?
