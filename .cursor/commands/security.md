# /security - Auditoría de Seguridad y Registro SDD

Analiza el código en busca de vulnerabilidades, genera el reporte de hallazgos e integra las correcciones como tareas pendientes en las specs del proyecto.

## Instrucción para la IA
Actúa como un **Auditor de Seguridad Senior** del stack definido en el bloque `## Perfil técnico` de `AGENTS.md`.

1. Si el Perfil técnico define `security_audit_skill`, activa esa skill y usa su checklist y plantilla de reporte.
2. Si no existe, aplica una revisión genérica basada en OWASP Top 10: control de acceso (IDOR, escalamiento de privilegios), inyección, XSS, subida de archivos, autenticación y sesión, exposición de secretos, rate limiting / DoS y configuración insegura.
3. Analiza los archivos o módulos indicados por el usuario y genera la lista de vulnerabilidades con ID (`VULN-x`, continuando desde el máximo existente en `specs/`), archivo, línea exacta, nivel de riesgo y remediación sugerida.
4. Propón las adiciones exactas a `spec.md`, `plan.md` y `tasks.md` del módulo correspondiente (correcciones como tareas pendientes `- [ ]` tipo `S-x`, con su test de seguridad).
5. 🛑 **DETENTE Y ESPERA**: Solicita la confirmación explícita del usuario antes de guardar los cambios en `specs/`.
