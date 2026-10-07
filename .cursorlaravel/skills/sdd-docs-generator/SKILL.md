# SDD Docs Generator Skill

## Descripción
Skill encargada de proveer las plantillas estándar y guías de formato para la documentación de Spec-Driven Development (SDD) adaptadas a Laravel y Filament PHP.

## Cuándo Usar Esta Skill
Actívala cuando necesites estructurar, redactar o formatear cualquier archivo dentro de la carpeta `specs/NNN-[id-nombre-modulo]/` (`spec.md`, `plan.md`, `tasks.md`).

---

## Instrucciones de Referencia (Lazy Loading)

Según el documento que se vaya a generar o editar, lee únicamente el archivo correspondiente dentro de `references/`:

1. **Especificaciones Funcionales (`spec.md`)**:
   - Lee y aplica el formato de `references/spec-template.md`.
   - Asegura la notación EARS en los Requisitos Funcionales (`RF-x`).

2. **Planes de Diseño Técnico (`plan.md`)**:
   - Lee y aplica el formato de `references/plan-template.md`.
   - Asegura la arquitectura de Laravel + Filament PHP (Migraciones, Modelos Eloquent, Resources, Pages, Policies y Tests con Pest/PHPUnit).

3. **Listas de Tareas Ejecutables (`tasks.md`)**:
   - Lee y aplica el formato de `references/tasks-template.md`.
   - Genera dinámicamente las tareas necesarias asociadas a cada `RF-x` con criterios de finalización explícitos ("Hecho cuando:").

---

## Reglas de Formato
- **Idioma**: Todo el contenido generado dentro de `specs/` debe estar redactado en **ESPAÑOL**.
- **Inmutabilidad**: Las tareas marcadas como completadas (`- [x]`) en `tasks.md` no se pueden eliminar ni modificar al agregar nuevas iteraciones.
