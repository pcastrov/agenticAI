# Plan de Diseño Técnico: [Nombre del Módulo]

> Plantilla: usa carpeta real (`001-...`). 🚫 No uses `NNN-...` literal.

**Módulo**: `001-[id-nombre-modulo]` · **Basado en**: `specs/001-[id-nombre-modulo]/spec.md` · **Stack**: `## Perfil técnico` de `AGENTS.md`

> Solo arquitectura de los RF pendientes. Lo cerrado vive en `history/<dominio>.md`.

## 1. Estructura vigente del módulo
| Capa | Archivos clave |
|------|----------------|
| Persistencia | [migraciones / esquemas / modelos] |
| Dominio / Servicios | [servicios, casos de uso, reglas] |
| Interfaz / API | [controladores, endpoints, pantallas] |
| Autorización | [políticas, guards, middleware] |
| Tests | [carpetas según `structure`] |

## 1.1 Reutilización y Simplicidad (DRY / KISS / YAGNI)
*(Solo `## Código Compartido` de `AGENTS.md` + estructura vigente del módulo. Si no hay: "Sin código reutilizable identificado")*

| Existente | Zona | Ubicación | Se reutiliza para |
|-----------|------|-----------|-------------------|
| `[función/clase]` | Código Compartido / Módulo | `[ruta]` | RF-03 |

| Consulta | Principio | Decisión del usuario |
|----------|-----------|----------------------|
| [qué se detectó] | DRY / KISS / YAGNI | Mejorar (tarea Tx) / Dejar igual: [motivo] |

## 2. Archivos a crear/modificar
| Acción | Ruta | Propósito / Cambio | RF |
|--------|------|--------------------|----|
| Nuevo | `[ruta según convención]` | [propósito] | RF-03 |
| Modificar | `[ruta]` | [cambio] | RF-04 |

## 3. Contratos y Modelo de Datos
| Entidad / Tabla | Campo | Tipo / Restricciones |
|-----------------|-------|----------------------|
| `[nombre]` | `[campo]` | [tipo, restricciones] |

```json
{ "ejemplo": "payload o respuesta del contrato (API / evento / interfaz)" }
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
*(Uno por HU afectada, según `references/sequence-technical-template.md`; se actualizan in-place)*

| Diagrama | HU | RF |
|----------|----|----|
| `diagramas/HU-01-tecnico.md` | HU-01 | RF-03, RF-04 |

## 6. Decisiones Técnicas
| Decisión | Justificación | Alternativa descartada |
|----------|---------------|------------------------|
| [decisión] | [por qué] | [opción y motivo] |

## 7. Trazabilidad Arquitectónica
| Archivo | RF | Rol |
|---------|----|-----|
| `[ruta]` | RF-03 | [rol del archivo] |

## 8. Propiedades ↔ Tests
| P | Test | Estado |
|---|------|--------|
| P1 | `[ruta]` | ⬜ Pendiente |

## 9. Estrategia de Tests
- **Runner**: clave `test` del Perfil técnico (`test_single` para uno). Validación por **Exit Code 0**.

| Requisito / CA | Escenario | Tipo (unit / integración / e2e) |
|----------------|-----------|---------------------------------|
| RF-03 / CA-01.1 | [DADO / CUANDO / ENTONCES a probar] | [tipo] |
