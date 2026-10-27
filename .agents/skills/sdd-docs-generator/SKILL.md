---
name: sdd-docs-generator
description: Plantillas y reglas de formato para la documentación SDD en specs/ (spec.md, plan.md, tasks.md, history.md y diagramas de secuencia PlantUML). Usar al crear o editar cualquier archivo dentro de specs/NNN-modulo/.
---

# SDD Docs Generator Skill

## Descripción
Skill encargada de proveer las plantillas estándar y guías de formato para la documentación de Spec-Driven Development (SDD). Es agnóstica de lenguaje y framework: los detalles del stack se toman del bloque `## Perfil técnico` de `AGENTS.md`.

## Cuándo Usar Esta Skill
Actívala cuando necesites estructurar, redactar o formatear cualquier archivo dentro de `specs/NNN-[id-nombre-modulo]/` (`spec.md`, `plan.md`, `tasks.md`, `history.md` y `diagramas/*.md`).

---

## Instrucciones de Referencia (Lazy Loading)

Según el documento que se vaya a generar o editar, lee únicamente el archivo correspondiente dentro de `references/`:

1. **Especificaciones Funcionales (`spec.md`)**: `references/spec-template.md`.
   - Historias `HU-x` con prioridad MoSCoW y criterios de aceptación `CA-x.y` en formato DADO / CUANDO / ENTONCES.
   - Notación EARS en los Requisitos Funcionales (`RF-x`), cada uno con MoSCoW y la `HU-x` que cubre.
   - Sección `0. Ya implementado` con una línea por RF cerrado.
2. **Planes de Diseño Técnico (`plan.md`)**: `references/plan-template.md`.
   - Capas y rutas según el `structure` del Perfil técnico; nunca asumas un framework.
3. **Listas de Tareas (`tasks.md`)**: `references/tasks-template.md`.
   - Solo tareas pendientes, cada una con `RF-x`, prioridad, propiedades, tests y "Hecho cuando".
4. **Histórico (`history.md`)**: `references/history-template.md`.
   - Una entrada por iteración cerrada.
5. **Diagrama de secuencia de negocio (`diagramas/HU-x-negocio.md`)**: `references/sequence-business-template.md`.
   - Se genera junto con `spec.md`, uno por historia. Actores, "Sistema" como caja negra y sistemas externos; sin detalles técnicos.
6. **Diagrama de secuencia técnico (`diagramas/HU-x-tecnico.md`)**: `references/sequence-technical-template.md`.
   - Se genera junto con `plan.md`, uno por historia. Desglosa el diagrama de negocio en las capas del plan.

Los diagramas son archivos Markdown con un bloque ` ```mermaid ` (`sequenceDiagram`). Se visualizan con la vista previa de Markdown de Cursor o VS Code, sin extensiones.

---

## Reglas de Formato
- **Idioma**: Todo el contenido dentro de `specs/` se redacta en **ESPAÑOL**.
- **Documentos activos livianos**: `spec.md`, `plan.md` y `tasks.md` solo contienen lo pendiente (más el índice `Ya implementado` de `spec.md`).
- **Mover, nunca borrar**: Lo completado se mueve a `history.md` al cerrar la iteración; no se elimina ni se reescribe una iteración ya archivada.
- **IDs estables**: Numeración de `HU`, `RF`, `RN`, `P`, `T` y `S` continúa desde el máximo histórico; nunca se reutiliza un ID. Los criterios `CA-x.y` se numeran dentro de su historia.
- **Diagramas vigentes**: Los diagramas de `diagramas/` describen el flujo actual completo (incluyendo lo ya implementado). Se actualizan en su lugar y no se archivan; `history.md` solo registra qué cambió en cada iteración.

## Calidad de los Requisitos
Todo `RF-x` debe ser:
- **Claro**: una sola interpretación posible.
- **Útil**: cubre al menos una `HU-x` (aporta un beneficio).
- **Comprobable**: tiene un criterio `CA-x.y` o una propiedad `Px` que se puede convertir en test.
- **Trazable**: ID estable, historia de origen y, si aplica, la `RN-x` que implementa.
- **Actualizado**: no contradice `Ya implementado` ni una `RN-x` vigente.

### Tipos de requisito y dónde van en `spec.md`
| Tipo | Sección |
|------|---------|
| Funcional (qué hace el sistema) | `RF-x` |
| No funcional (calidad, seguridad, usabilidad, compatibilidad) | `RNF-x` |
| Restricciones (técnicas, legales, plazos) | Restricciones |
| Negocio / Usuario (políticas que determinan funcionalidades) | Historias `HU-x` y, si aplica, `RN-x` |
| Datos e integraciones (sistemas externos) | Datos e Integraciones Externas |

### Prioridad
- **MoSCoW** (`Must` / `Should` / `Could`) en `HU-x`, `RF-x` y `RNF-x`: valor para el negocio. `Won't` es la sección "Fuera de Alcance".
- **Prioridad de tarea** (`blocker` / `required` / `optional` / `nice-to-have`) en `tasks.md`: orden técnico de ejecución. Un `RF` `Must` no puede quedar cubierto solo por tareas `optional` o `nice-to-have`.

### Reglas de negocio (`RN-x`)
Sección opcional. Crea una `RN-x` solo si la regla la usan 2 o más RF, viene de fuera del equipo (legal, contable, política del cliente) o es un dato que el negocio cambia seguido. Si solo aplica a un RF, redáctala dentro de ese RF.
