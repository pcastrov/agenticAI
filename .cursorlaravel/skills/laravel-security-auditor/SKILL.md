# Laravel & Filament Security Auditor Skill

## Descripción
Skill encargada de auditar el código fuente en busca de vulnerabilidades, clasificar las brechas detectadas y registrarlas en la documentación SDD del módulo correspondiente (`specs/`) sin modificar directamente el código PHP.

## Cuándo Usar Esta Skill
Actívala cuando necesites ejecutar una auditoría de seguridad sobre un módulo existente, evaluar un Resource de Filament o procesar el comando `/security`.

---

## Secuencia de Ejecución

Al auditar código, sigue estrictamente este procedimiento:

1. **Inspección Técnica**:
   - Analiza el código objetivo consultando los criterios definidos en `references/security-checklist.md`.

2. **Diagnóstico y Mapeo**:
   - Identifica el archivo exacto y el número de línea donde ocurre la vulnerabilidad.
   - Clasifica la severidad: 🔴 CRÍTICA, 🟠 ALTA, 🟡 MEDIA, 🟢 BAJA.
   - Determina a qué módulo de `specs/NNN-[id-nombre-modulo]/` pertenece el archivo afectado.

3. **Formateo del Reporte**:
   - Estructura los hallazgos según la plantilla en `references/audit-report-template.md`.

4. **Integración con SDD (Sin Modificar Código)**:
   - **En `spec.md`**: Agrega la vulnerabilidad bajo la sección `## 8. Dudas, Ambigüedades y Deuda Técnica Detectada`.
   - **En `plan.md`**: Incluye la estrategia de mitigación en la sección de arquitectura correspondiente.
   - **En `tasks.md`**: Agrega la tarea de corrección como pendiente (`- [ ] Tarea S-X: [Descripción]`) vinculada a un test de seguridad.

---

## Reglas Innegociables
- **Cero cambios directos en código**: No edites ni modifiques archivos PHP, Blade o configuraciones durante la auditoría.
- **Trazabilidad estricta**: Todo hallazgo debe indicar la ruta relativa del archivo y la línea exacta.
- **Aprobación requerida**: No actualices los archivos dentro de `specs/` sin la confirmación explícita del usuario.