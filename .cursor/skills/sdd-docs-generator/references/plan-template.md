# Plan de Diseño Técnico: [Nombre del Módulo]

**Módulo**: `NNN-[id-nombre-modulo]`
**Basado en**: `specs/NNN-[id-nombre-modulo]/spec.md`
**Stack**: según `## Perfil técnico` de `AGENTS.md`

> Este plan solo describe la arquitectura de los RF pendientes. Las decisiones y secciones de RF ya cerrados viven en `history.md`.

---

## 1. Estructura vigente del módulo
*(Tabla breve de los archivos que hoy forman el módulo, para ubicarse sin leer el histórico)*

| Capa | Archivos clave |
|------|----------------|
| Persistencia | [migraciones / esquemas / modelos] |
| Dominio / Servicios | [servicios, casos de uso, reglas de negocio] |
| Interfaz / API | [controladores, endpoints, pantallas, componentes] |
| Autorización | [políticas, guards, middleware] |
| Tests | [carpetas de tests según `structure`] |

## 1.1 Reutilización y Simplicidad (DRY / KISS / YAGNI)
*(Propuesta de reutilización: se aprueba junto con este plan. Solo se busca en `## Código Compartido` de `AGENTS.md` y en la estructura vigente del módulo; nunca en otros módulos ni en código del framework. Si no hay nada, escribe "Sin código reutilizable identificado".)*

| Existente | Zona | Ubicación | Se reutiliza para |
|-----------|------|-----------|-------------------|
| `[función / clase / componente]` | Código Compartido / Módulo | `[ruta]` | RF-03 |

| Consulta | Principio | Decisión del usuario |
|----------|-----------|----------------------|
| [Qué se detectó] | DRY / KISS / YAGNI | Mejorar (en tarea Tx) / Dejar igual: [motivo] |

## 2. Archivos a crear/modificar (RF pendientes)
- **Nuevos**:
  - `[ruta según convención del proyecto]` -> [Propósito] (`RF-03`)
- **Existentes a modificar**:
  - `[ruta]` -> [Cambio] (`RF-04`)

## 3. Contratos y Modelo de Datos
- **Entidad / Tabla**: `[nombre]`
  - `[campo]`: [tipo, restricciones]
- **Contrato (API / evento / interfaz)**:

```json
{
  "ejemplo": "payload o respuesta"
}
```

## 4. Lógica de Negocio (pseudocódigo)

```
operacion(entrada):
  validar reglas de negocio
  BEGIN TRANSACTION
    persistir cambios
  COMMIT
  emitir efectos (eventos, notificaciones)
```

## 5. Diagramas de Secuencia Técnicos
*(Uno por historia afectada, basado en `references/sequence-technical-template.md`. Desglosa el diagrama de negocio de la misma HU en las capas de este plan. Se actualiza en su lugar; no se archiva)*

| Diagrama | HU | RF que cubre |
|----------|----|--------------|
| `diagramas/HU-01-tecnico.md` | HU-01 | RF-03, RF-04 |

## 6. Decisiones Técnicas Justificadas
- **Decisión 1**: [Descripción]
  - **Justificación**: [Por qué]
  - **Alternativa descartada**: [Qué otra opción y por qué no]

## 7. Trazabilidad Arquitectónica
*(Cada archivo vinculado a sus RF pendientes)*

| Archivo | RF que cubre | Descripción |
|---------|-------------|-------------|
| `[ruta]` | RF-03 | [Rol del archivo] |

## 8. Mapeo de Propiedades ↔ Tests

| Propiedad | Test | Validación |
|-----------|------|------------|
| P1 | `[ruta del test]` | ⬜ Pendiente |

## 9. Estrategia de Tests
- **Runner**: clave `test` del Perfil técnico (`test_single` para ejecutar uno).
- **Cobertura por Requisito**:
  - `RF-03`: [Qué escenario prueba y con qué tipo de test (unitario / integración / e2e)].
- **Cobertura por Criterio de Aceptación**:
  - `CA-01.1`: [Test que reproduce el DADO / CUANDO / ENTONCES].
