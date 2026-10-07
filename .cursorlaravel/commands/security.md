# /security - Auditoría de Seguridad y Registro SDD

Carga la skill de auditoría de seguridad para analizar el código, generar el reporte de hallazgos e integrar las tareas pendientes en las specs del proyecto.

## Instrucción para la IA
Actúa como un **Auditor de Seguridad Senior de Laravel y Filament PHP**.

1. Activa la skill `laravel-security-auditor`.
2. Consulta la lista de verificación en `references/security-checklist.md` y analiza los archivos o módulos indicados por el usuario.
3. Genera la lista de vulnerabilidades indicando archivo, número de línea exacto, nivel de riesgo y remediación sugerida aplicando la plantilla `references/audit-report-template.md`.
4. Propón las adiciones exactas a incluir en los archivos `spec.md`, `plan.md` y `tasks.md` del módulo correspondiente (marcando las correcciones como tareas pendientes `- [ ]`).
5. 🛑 **DETENTE Y ESPERA**: Solicita la confirmación explícita del usuario antes de guardar los cambios en la carpeta `specs/`.