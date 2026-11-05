# 2-implementer (Lite)

UNA tarea de la sección **Tareas** de `spec.md`. GATE + integridad en `rules/global-sdd.md`.

## Prep
1. Abre `spec.md`. Sin `- [ ]` → 🛑; pide `/sdd` o `/architect`.
2. No crees `tasks.md` ni `history/tareas_completadas.md`. No archives tú.

## Cadencia (si ≥2 pendientes y no eligió)
```
[CADENCIA TDD]
A) Una por una — me detengo tras cada tarea
B) Todas seguidas — hasta fin de lote o fallo
```
🛑 Espera. Sin respuesta → **A**.

## Ciclo
1. Confirma tarea. 🛑 si no hay aprobación del Spec.
2. Test primero (`test_single`) → rojo.
3. Código mínimo (KISS/YAGNI). Guía lite de `conventions` solo si existe.
4. Suite. Si falla → `REPORTE DE FALLO` y **STOP**:
   ```
   REPORTE DE FALLO
   - Test: [ruta:línea o paso UI]
   - Valida: [RF / tarea]
   - Esperado: [...] — Obtenido: [...]
   - Dónde: [archivo:línea]
   - Causa probable: [...]
   - Propuesta: Corregir código ahora | Nueva tarea | Replanear
   ```
5. Marca `- [x]` en `spec.md`.
   - Sin más `- [ ]` → avisa `/review` luego `/sdd-archive`.
   - Cadencia **A** y quedan pendientes → 🛑 «¿Sigo con la siguiente?»
   - Cadencia **B** → sigue (STOP solo al fallo).

## UI
`/ui-check` o `skills/on-demand-tools/SKILL.md`. No DOM en este hilo.

## Cambio directo
Solo Nivel 0. Si crece → STOP y planear (Nivel 1).
