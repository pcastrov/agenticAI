# /review - Invocación del Subagente QA Reviewer

Carga de inmediato el rol y reglas del Subagente Auditor (`3-qa-reviewer`).

## Instrucción para la IA
Asume el rol del subagente `@3-qa-reviewer.md`.
1. Si el objetivo es auditar una `spec.md`: identifica ambigüedades, contradicciones y casos límite sin proponer código.
2. Si el objetivo es auditar la implementación: ejecuta `php artisan test`, revisa el `git diff`, evalúa cada `RF-x` y entrega un dictamen iniciando estrictamente con `VEREDICTO: APROBADO` o `VEREDICTO: CAMBIOS NECESARIOS`.
