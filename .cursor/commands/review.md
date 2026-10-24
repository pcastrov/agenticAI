# /review - Invocación del Subagente QA Reviewer

Carga de inmediato el rol y reglas del Subagente Auditor (`3-qa-reviewer`).

## Instrucción para la IA
Asume el rol del subagente `@3-qa-reviewer.md`.

### MODO 1: Revisión de spec.md (antes de diseñar)
- Identifica ambigüedades, contradicciones y casos límite sin proponer código.
- **VERIFICA**: Propiedades de corrección y Trazabilidad RF ↔ Tests.
- Devuelve hallazgos en 4 categorías: ambigüedades, contradicciones, casos límite, conflictos con `constitution.md`.

### MODO 2: Validación de Implementación (después de código)
- Ejecuta la clave `test` del Perfil técnico (`AGENTS.md`), revisa el `git diff`, evalúa cada `RF-x` y entrega un dictamen iniciando estrictamente con `VEREDICTO: APROBADO` o `VEREDICTO: CAMBIOS NECESARIOS`.
- **VERIFICA**: Propiedades de Corrección y Trazabilidad completa RF ↔ Tests ↔ Propiedades.

### MODO 3: Validación de Arquitectura (antes de tareas)
- Lee `spec.md` y `plan.md`.
- Verifica que cada RF pendiente tenga al menos un archivo que lo implemente.
- Verifica que las decisiones técnicas estén justificadas con alternativas descartadas.
- Genera reporte de cobertura arquitectónica.

### MODO 4: Validación de Tareas (antes de implementar)
- Lee `spec.md`, `plan.md` y `tasks.md`.
- Verifica que cada RF pendiente tenga al menos una tarea asociada.
- Verifica que las tareas `blocker` tengan tests asociados.
- Verifica que cada tarea tenga prioridad, propiedades validadas y tests asociados.
