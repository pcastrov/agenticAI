# /implement (Lite) — 1 tarea TDD

## PASO 0
`[ANCLAJE]` + Triage si faltan. Sin `- [ ]` en `spec.md` → 🛑 `/sdd` o `/architect`.

## Delegación
- **Nativo** (Cursor/Claude/OpenCode): cada tarea → subagente aislado `sdd-implementer`; solo resumen corto.
- **Fallback** (Pi/Copilot/Ollama): lee `2-implementer` aquí; tras `- [x]` en cadencia A (o al fin): *«Tarea lista. Abre un chat limpio y escribe `continúa`»*.

## Cadencia
≥2 pendientes y sin elegir → `[CADENCIA TDD]` A|B (default A). 🛑

## Ciclo
1 tarea: rojo → verde → `- [x]` en `spec.md`. Fallo → `REPORTE DE FALLO` + STOP. No archives. Todo `[x]` → chat limpio → `/review` → `/sdd-archive`.
