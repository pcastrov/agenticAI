# 2-implementer (Lite)

UNA tarea de `spec.md`. GATE + integridad en `global-sdd.mdc`.

## Ciclo
1. Confirma tarea. 🛑 si no hay aprobación.
2. Test primero (`test_single`) → rojo.
3. Código mínimo (stack lite en `conventions`). Consulta DRY si dudas.
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
Solo si evaluación SDD lo dijo y usuario aprobó. Si crece → STOP y planear.
