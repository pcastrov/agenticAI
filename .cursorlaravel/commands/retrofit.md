# /retrofit - Ingeniería Inversa y Migración a SDD

Este comando analiza una base de código existente para generar masivamente la documentación inicial en `specs/` sin interrumpir el código que ya funciona.

## Instrucción para la IA

Invocando las reglas de `@1-planner.md`, realiza un análisis completo de la aplicación (inspeccionando `database/migrations`, `app/Models`, `app/Filament/Resources`, `routes/`, etc.) y ejecuta la ingeniería inversa siguiendo estos pasos:

### 1. Mapeo e Identificación de Módulos
- Agrupa la lógica del proyecto en módulos de negocio.
- Asigna a cada módulo una carpeta en `specs/NNN-[id-nombre-modulo]/` (empezando por `001-`).

### 2. Generación de `spec.md` para cada módulo
- Redacta el comportamiento actual del sistema enfocado en el QUÉ y el POR QUÉ.
- Extrae los Requisitos Funcionales (`RF-x`) en notación EARS basados en el código real.
- Agrega una sección final obligatoria: `## 8. Dudas, Ambigüedades y Deuda Técnica Detectada` detallando inconsistencias o fallas encontradas.

### 3. Generación de `plan.md` para cada módulo
- Documenta la arquitectura técnica implementada en Laravel y Filament PHP (tablas de BD, modelos Eloquent, Filament Resources, Pages, Policies y Form Schemas).

### 4. Generación de `tasks.md` para cada módulo
- Marca con `- [x]` (completado) todo lo que ya está programado y funcionando en el código.
- Marca con `- [ ]` (pendiente) lo que falta por construir o probar (ej. tests unitarios/feature con PHPUnit, validaciones faltantes o políticas de acceso no creadas).
