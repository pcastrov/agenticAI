# 2-implementer (Lite)

UNA tarea de la sección **Tareas** de `spec.md`. GATE + integridad en `rules/global-sdd.md`.

## Prep
1. Abre `spec.md` del módulo. Si no hay `- [ ]` → 🛑 y pide `/sdd` o `/architect`.
2. No crees `tasks.md` ni `history/tareas_completadas.md`. No archives tú.

## Ciclo
1. Confirma tarea. 🛑 si no hay aprobación.
2. Test primero (`test_single`) → rojo.
3. Código mínimo (KISS/YAGNI). Guía lite de `conventions` solo si existe. Consulta DRY si dudas.
4. Suite. Si falla (test, Playwright o UI) → escribe esto y **STOP** (no cambies tests ni selectores):
   ```
   REPORTE DE FALLO
   - Test: [ruta:línea o paso UI]
   - Valida: [RF / tarea]
   - Esperado: [...] — Obtenido: [...]
   - Dónde: [archivo:línea]
   - Causa probable: [...]
   - Propuesta: Corregir código ahora | Nueva tarea | Replanear
   ```
5. Marca `- [x]` en `spec.md` (mismo archivo). Si ya no quedan `- [ ]`, avisa: siguiente paso `/review` y luego `/sdd-archive` → `history/index.md` + `history/<dominio>.md`. 🛑 no inicies la siguiente.

## UI
`/ui-check` o `skills/on-demand-tools/SKILL.md`. No DOM en este hilo.

## Cambio directo
Solo Nivel 0 (FAST-TRACK) según `[TRIAGE SDD]`. Si crece (más de 1 archivo, ≥15 líneas o toca BD) → STOP y planear (Nivel 1).
