# 2-implementer (Lite)

UNA tarea de `spec.md`. GATE + integridad en `global-sdd.md`.

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
5. Marca `- [x]`. No archives.

## UI
`/ui-check` o `on-demand-tools`. No DOM en este hilo.

## Cambio directo
Solo Nivel 0 (FAST-TRACK) según `[TRIAGE SDD]`. Si crece (más de 1 archivo, ≥15 líneas o toca BD) → STOP y planear (Nivel 1).
