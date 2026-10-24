# /validation-properties - Validación de Propiedades de Corrección

Este comando valida que las propiedades de corrección (Property-Based Testing) estén definidas y sean verificables.

## Instrucción para la IA

Invoca a `@1-planner.md` en **MODO 5: Generación de Propiedades**:

1. Lee `spec.md` del módulo indicado.
2. Si no tiene sección de **Propiedades de Corrección**:
   - Analiza los `RF-x` pendientes de la spec.
   - Genera propiedades formales que el código debe cumplir.
   - Formato: "Si [condición], entonces [resultado esperado]" o "Para todo [X], se cumple [Y]".
3. Si ya tiene propiedades, verifica que cada una sea:
   - **Verificable**: Se puede escribir un test que la valide.
   - **No ambigua**: No tiene múltiples interpretaciones.
   - **Independiente**: No depende de otras propiedades.
   - Y que cada RF crítico tenga al menos una propiedad asociada.
4. Genera reporte de validación.

## Formato de Propiedades

```
## Propiedades de Corrección

- **P1**: Si una entidad cambia de estado, los timestamps de estados anteriores NO se modifican.
- **P2**: Para toda consulta de un usuario, solo se devuelven registros dentro de su alcance autorizado.
- **P3**: Para toda operación de creación, la entidad resultante cumple las reglas mínimas del negocio (ej. cantidad mínima).
- **P4**: Si un usuario no tiene permiso, entonces la acción es denegada y no hay efectos secundarios.
```

## Formato de Salida

```
# Reporte de Propiedades: [Nombre del Módulo]

## Propiedades Existentes

- **P1**: ✅ Verificable, ✅ No ambigua, ✅ Independiente
- **P2**: ⚠️ Ambigua (definir "alcance autorizado")

## Propiedades Faltantes para RF Críticos

- RF-04 (cambio de estado): Sin propiedad asociada
  - **Sugerencia**: P5: "Si el estado cambia a 'finalizado', entonces su timestamp se establece una única vez."

## Cobertura RF ↔ Propiedades

| RF | Propiedad | Test |
|----|-----------|------|
| RF-01 | P1 | ✅ [test] |
| RF-02 | P2 | ⚠️ Sin test |

## Acciones Recomendadas

1. Clarificar P2.
2. Añadir propiedad para RF-04.
3. Crear test para P2.
```
