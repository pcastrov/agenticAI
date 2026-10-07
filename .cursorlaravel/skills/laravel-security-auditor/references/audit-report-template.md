# Plantilla de Reporte de Auditoría de Seguridad

## Resumen Ejecutivo
- **Módulo Afectado**: `specs/NNN-[id-nombre-modulo]/`
- **Total de Vulnerabilidades Detectadas**: [Cantidad]
- **Nivel de Riesgo General**: [🔴 CRÍTICA / 🟠 ALTA / 🟡 MEDIA / 🟢 BAJA]

---

## Detalles de Vulnerabilidades Detectadas

### [VULN-01] Nombre Corto de la Brecha
- **Severidad**: 🔴 CRÍTICA / 🟠 ALTA / 🟡 MEDIA / 🟢 BAJA
- **Ubicación**: `app/Filament/Resources/[Archivo].php` (Línea XX)
- **Categoría**: [Ej. Autorización / SQLi / XSS / Mass Assignment]
- **Descripción del Riesgo**: Explicación clara de la falla detectada.
- **Remediación Propuesta**: Estrategia técnica para solucionarla.

---

## Integración Propuesta para la Documentación SDD

### Tareas a incorporar en `specs/NNN-[id-nombre-modulo]/tasks.md`:
- [ ] **Tarea S-01: [Nombre de la corrección]**
  - **Cubre**: Deuda Técnica `VULN-01`
  - **Archivos**: `app/Filament/Resources/[Archivo].php`, `tests/Feature/Security/[Test]Test.php`
  - **Hecho cuando**: El test de seguridad pase en verde (`php artisan test`) y la vulnerabilidad esté corregida.