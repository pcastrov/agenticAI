# Global Rule: Spec-Driven Development (SDD) & Engineering Standards

## 1. Misión Global
Esta regla establece los principios inmutables que aplican a TODOS los agentes, subagentes, comandos y skills dentro de este repositorio. Es agnóstica de lenguaje y framework.

## 2. Invocación Obligatoria del Flujo SDD
Ante CUALQUIER solicitud de cambio, corrección de errores (bugfix), nueva funcionalidad o refactorización:
- 🚫 **PROHIBIDO modificar código fuente directamente** sin pasar por la evaluación SDD.
- ⚙️ **Ejecución del Flujo SDD**: Todo cambio activa inmediatamente la lógica de `/sdd`, la cual:
  1. Escanea la carpeta `specs/`.
  2. **Evalúa el alcance**: decide si la petición merece especificación o es un cambio directo (criterios en "Evaluación de Alcance" de `/sdd`) y lo justifica ante el usuario.
  3. Si merece especificación: determina si impacta un spec existente o requiere uno nuevo, y mapea o actualiza `HU-x`, `RF-x`, el plan y las tareas pendientes (`- [ ]`).
  4. Si es cambio directo: lo ejecuta `@2-implementer.md` (MODO C) tras la confirmación del usuario.
- 🛑 **Paso de Confirmación**: La IA debe presentar la evaluación (y, si aplica, la propuesta de actualización o creación en `specs/`) y esperar la confirmación del usuario antes de tocar código.

## 2.1 Integridad de los Tests
- Los tests existen para detectar fallos. Un test que falla se **reporta**, no se acomoda.
- 🚫 **PROHIBIDO** modificar, borrar, saltar, comentar o debilitar un test existente para que pase. Solo se cambia si el requisito que valida cambió en una spec aprobada, o si se demostró que el test está mal y el usuario lo aprobó.
- Todo fallo genera un **Reporte de Fallo** (qué falló, dónde, causa probable con evidencia y propuesta) según `@2-implementer.md`. La propuesta es corregir ahora (solo si es pequeño y dentro del alcance de la tarea), crear una tarea con test de regresión, o pasar por SDD; el usuario decide salvo en el primer caso.
- Todo bug de comportamiento se corrige primero con un test que lo reproduce.

## 3. Idioma y Comunicación
- **Comunicación**: Toda la interacción con el usuario (preguntas, resúmenes, reportes) debe ser en **ESPAÑOL**.
- **Documentación**: Todos los archivos dentro de `specs/` deben redactarse en **ESPAÑOL**.
- **Código Fuente**: Nombres de variables, funciones, clases y comentarios siguen el estándar del proyecto (definido en `docs/constitution.md`).

## 4. Fuentes de Contexto (Trinidad)
- **`AGENTS.md`**: Hechos del proyecto (stack, versiones, estructura, comandos, convenciones). Contiene el bloque `## Perfil técnico`.
- **`docs/constitution.md`**: Principios no negociables. Ningún diseño o implementación puede violarlos; ante conflicto, la constitución prevalece.
- **`MEMORY.md`**: Estado actual, decisiones y aprendizajes.

## 5. Perfil Técnico
Los subagentes no asumen ningún lenguaje, framework ni comando. Toman los datos del bloque `## Perfil técnico` de `AGENTS.md`:

| Clave | Uso |
|-------|-----|
| `language` | Lenguaje y versión |
| `framework` | Framework(s) principal(es) y versión |
| `database` | Motor de base de datos |
| `test` | Comando para ejecutar la suite completa |
| `test_single` | Comando para ejecutar un test (`{name}` como marcador) |
| `lint` | Comando de linter/formatter |
| `run` | Comando o URL para levantar la app en local |
| `migrate` | Comando de migraciones (si aplica) |
| `structure` | Carpetas de código y de tests |
| `ui_check` | Cómo verificar cambios visuales (si aplica) |
| `security_audit_skill` | Skill de auditoría de seguridad del stack (opcional) |

- Si una clave necesaria falta o dice `no configurado`, el subagente **se detiene y pregunta**; nunca la inventa.
- El bloque se genera o actualiza con `/init`.

## 6. Estructura Obligatoria de Módulos (Specs)

```text
specs/NNN-[id-nombre-modulo]/
├── spec.md     # Qué y Por qué: índice "Ya implementado" + RF pendientes, casos límite, propiedades, decisiones, trazabilidad
├── plan.md     # Cómo: estructura vigente + arquitectura de RF pendientes, trazabilidad RF ↔ archivo, decisiones técnicas
├── tasks.md    # Paso a paso: solo tareas pendientes con prioridad, propiedades y tests asociados
├── history.md  # Histórico append-only de iteraciones cerradas (HU, RF, decisiones, arquitectura y tareas completadas)
└── diagramas/  # Diagramas de secuencia PlantUML vigentes por historia
    ├── HU-01-negocio.puml   # Para cualquier persona: actores, Sistema y sistemas externos (va con spec.md)
    └── HU-01-tecnico.puml   # Para desarrollo: capas y archivos del plan (va con plan.md)
```

- **Diagramas vigentes**: los `.puml` describen el flujo actual completo; se actualizan en su lugar y no se archivan. `history.md` solo registra qué cambió.

## 7. Documentos Activos vs Histórico
- **Regla de lectura**: Los agentes leen solo `spec.md`, `plan.md` y `tasks.md`. `history.md` se consulta únicamente si:
  1. El usuario lo pide, o
  2. La tarea actual referencia un ID archivado o se parece a algo ya hecho.
  En ambos casos se busca por ID o palabra clave (grep) y se lee solo la entrada encontrada, nunca el archivo completo.
- **Regla de cierre**: Al aprobarse QA (o con `/sdd-archive`), el planner mueve a `history.md` las tareas `- [x]`, los RF cerrados con su trazabilidad y las secciones de plan que ya no aplican, y actualiza el índice `Ya implementado` de `spec.md`.
- **RF cerrado**: implementado y verificado. En ingeniería inversa, un RF implementado sin tests se archiva marcado `sin tests → Tx`, y la tarea `Tx` queda pendiente.
- **Mover, nunca borrar**: lo completado no se elimina; una iteración archivada no se reescribe.
- **IDs estables**: `HU`, `RF`, `RN`, `P`, `T` y `S` continúan desde el máximo histórico; nunca se reutilizan.

## 8. Flujo SDD (Fases 1-8)
1. **Especificar** (`spec.md` y diagramas de negocio): Historias con criterios de aceptación, requisitos con MoSCoW, propiedades de corrección y decisiones de diseño.
2. **Validar spec** (`@3-qa-reviewer.md` MODO 1): Evalúa los 5 atributos de calidad, detecta ambigüedades, revisa los diagramas de negocio y verifica trazabilidad.
3. **Diseñar y planificar tareas** (`plan.md`, `tasks.md` y diagramas técnicos): Arquitectura con trazabilidad RF ↔ archivo, tareas con prioridad, propiedades y tests.
4. **Validar arquitectura** (`@3-qa-reviewer.md` MODO 3): Verifica trazabilidad completa y coherencia de los diagramas técnicos.
5. **Validar tareas** (`@3-qa-reviewer.md` MODO 4): Verifica cubrimiento RF ↔ propiedades ↔ tests.
6. **Implementar** (`@2-implementer.md`): TDD estricto (tests primero, luego código).
7. **Validar final** (`@3-qa-reviewer.md` MODO 2): Dictamen con verificación de propiedades y trazabilidad.
8. **Cerrar iteración** (`@1-planner.md` MODO 6): Mueve lo completado a `history.md`.

## 9. Comandos de Validación y Mantenimiento
- `/validation-trace`: Valida trazabilidad HU ↔ RF ↔ arquitectura ↔ tests.
- `/validation-properties`: Valida propiedades de corrección y genera propiedades faltantes.
- `/sdd-archive`: Cierra manualmente la iteración de un módulo.
- `/sdd-update`: Actualiza el flujo SDD desde el paquete `sdd-kit`.

## 10. Requisitos de Calidad para Specs
- **5 atributos**: Cada RF es claro, útil, comprobable, trazable y actualizado (detalle en "Calidad de los Requisitos" de la skill `sdd-docs-generator`).
- **Tipos de requisito**: funcionales (`RF`), no funcionales (`RNF`), restricciones, negocio/usuario (`HU` y `RN` opcional) y datos e integraciones externas.
- **Historias**: Cada `HU-x` tiene criterios de aceptación DADO / CUANDO / ENTONCES (`CA-x.y`) y su diagrama de secuencia de negocio.
- **Cobertura completa**: Todos los RF pendientes tienen tests, propiedades y arquitectura definida; cada `CA-x.y` tiene un test.
- **Trazabilidad**: HU ↔ RF ↔ arquitectura ↔ tests ↔ propiedades verificables.
- **Priorización**: MoSCoW en `HU`, `RF` y `RNF` (valor de negocio); prioridad de tarea en `tasks.md` (orden técnico). Un RF `Must` se cubre con tareas `blocker` o `required`, y las tareas `blocker` tienen tests asociados.
- **Propiedades**: Cada RF crítico tiene al menos una propiedad de corrección.
