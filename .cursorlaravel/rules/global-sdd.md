# Global Rule: Spec-Driven Development (SDD) & Engineering Standards

## 1. Misión Global
Esta regla establece los principios inmutables que aplican a TODOS los agentes, subagentes, comandos y skills dentro de este repositorio.

## 2. Invocación Obligatoria del Flujo SDD
Ante CUALQUIER solicitud de cambio, corrección de errores (bugfix), nueva funcionalidad o refactorización:
- 🚫 **PROHIBIDO modificar código fuente directamente** sin pasar por la evaluación SDD.
- ⚙️ **Ejecución del Flujo SDD**: Todo cambio activa inmediatamente la lógica de `/sdd`, la cual:
  1. Escanea la carpeta `specs/`.
  2. Determina si la solicitud impacta un spec existente o si requiere crear uno nuevo.
  3. Mapea o actualiza el Requisito Funcional (`RF-x`), el plan de arquitectura y las tareas pendientes (`- [ ]`) en `tasks.md`.
- 🛑 **Paso de Confirmación**: La IA debe presentar la propuesta de actualización o creación en `specs/` y esperar la confirmación del usuario antes de pasar a la fase de implementación.

## 3. Idioma y Comunicación
- **Comunicación**: Toda la interacción con el usuario (preguntas, resúmenes, reportes) debe ser en **ESPAÑOL**.
- **Documentación**: Todos los archivos dentro de `specs/` (`spec.md`, `plan.md`, `tasks.md`) deben redactarse en **ESPAÑOL**.
- **Código Fuente**: Nombres de variables, funciones, clases y comentarios deben seguir el estándar del proyecto (definido en `docs/constitution.md`).

## 4. Alineación con la Constitución
- Ningún diseño, arquitectura, refactorización o implementación puede violar las leyes definidas en `docs/constitution.md`.
- Ante cualquier conflicto entre una solicitud rápida y la constitución, la constitución prevalece.

## 5. Estructura Obligatoria de Módulos (Specs)
Cualquier funcionalidad o módulo del sistema DEBE estar documentado dentro de la carpeta `specs/` usando el siguiente esquema:

```text
specs/NNN-[id-nombre-modulo]/
├── spec.md   # Qué y Por qué (Requisitos funcionales RF-x, casos límite, criterios de aceptación EARS)
├── plan.md   # Cómo (Arquitectura, contratos API, modelos, decisiones técnicas)
└── tasks.md  # Paso a Paso (Tareas pequeñas ejecutables con checkboxes - [ ])
```

Siempre y cuando el sudagent `@1-planner.md` asi lo determine
