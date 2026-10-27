# /validation-trace - Validación de Trazabilidad HU ↔ RF ↔ Arquitectura ↔ Tests

Este comando valida que la trazabilidad entre Historias de Usuario, Requisitos Funcionales pendientes, Arquitectura y Tests esté completa.

## Instrucción para la IA

Invoca a `@1-planner.md` en **MODO 4: Validación de Trazabilidad**:

1. Lee `spec.md`, `plan.md` y `tasks.md` del módulo indicado (no `history.md`).
2. Verifica que cada `HU-x` pendiente tenga al menos un `RF-x` y que cada criterio `CA-x.y` tenga un test asociado.
3. Verifica que cada `RF-x` pendiente tenga:
   - Prioridad MoSCoW y al menos una `HU-x` que cubre.
   - Al menos un archivo en `plan.md` que lo implemente.
   - Al menos un test asociado en `tasks.md`.
   - Al menos una propiedad de corrección que lo valide.
4. Verifica que cada RF de `Ya implementado` marcado `sin tests → Tx` tenga su tarea `Tx` pendiente.
5. Genera reporte de cobertura:
   - ✅ RF con trazabilidad completa (HU + arquitectura + test + propiedad).
   - ⚠️ RF con trazabilidad parcial.
   - ❌ RF sin trazabilidad.
6. Si hay gaps, sugiere correcciones al usuario.

## Formato de Salida

```
# Reporte de Trazabilidad: [Nombre del Módulo]

## Cobertura de Historias

| HU | Prioridad | RF | Criterios con test | Estado |
|----|-----------|----|--------------------|--------|
| HU-01 | Must | RF-01, RF-02 | 2 de 2 | ✅ Completo |
| HU-02 | Should | ❌ Sin RF | 0 de 1 | ❌ Sin trazabilidad |

## Cobertura de RF

| RF | Prioridad | HU | Arquitectura | Test | Propiedad | Estado |
|----|-----------|----|-------------|------|-----------|--------|
| RF-01 | Must | HU-01 | ✅ [archivo] | ✅ [test] | ✅ P1 | ✅ Completo |
| RF-02 | Should | HU-01 | ✅ [archivo] | ⚠️ Sin test | ❌ Sin propiedad | ⚠️ Parcial |
| RF-03 | ⚠️ Sin prioridad | ❌ Sin HU | ❌ Sin archivo | ❌ Sin test | ❌ Sin propiedad | ❌ Sin trazabilidad |

## Resumen

- ✅ RF con trazabilidad completa: X
- ⚠️ RF con trazabilidad parcial: Y
- ❌ RF sin trazabilidad: Z

## Acciones Recomendadas

1. [Lista de acciones para corregir gaps]
```
