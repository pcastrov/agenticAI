# Especificación Funcional: [Nombre del Módulo]

> Plantilla: sustituye `NNN-[id-nombre-modulo]` por la carpeta real (`001-api-tasks`, …). 🚫 No crees `NNN-...` literal.

**Estado**: Borrador | Aprobado · **Módulo**: `001-[id-nombre-modulo]`
**Histórico**: `specs/001-[id-nombre-modulo]/history/index.md` · **Diagramas**: `specs/001-[id-nombre-modulo]/diagramas/`

> Cada requisito: **claro**, **útil** (cubre una HU), **comprobable** (CA o propiedad), **trazable** (ID estable) y **actualizado** (no contradice lo implementado).

## 0. Ya implementado
*(Una línea por RF cerrado; el detalle está en `history/<dominio>.md`, buscarlo por ID solo si la tarea lo necesita)*

| RF | Resumen | Dominio | Iteración |
|----|---------|---------|-----------|
| RF-01 | [una línea] | [dominio] | 1 |

## 1. Contexto y Objetivo
- **Problema**: [necesidad de negocio]
- **Objetivo**: [qué resuelve y valor esperado]
- **Roles**: [Usuario Final, Administrador, Sistema]

## 2. Historias de Usuario y Criterios de Aceptación
| HU | Historia (Como / quiero / para) | Prioridad | Diagrama |
|----|----------------------------------|-----------|----------|
| HU-01 | Como [rol], quiero [objetivo] para [beneficio] | Must | `diagramas/HU-01-negocio.md` |

| CA | HU | DADO | CUANDO | ENTONCES |
|----|----|------|--------|----------|
| CA-01.1 | HU-01 | [contexto] | [acción] | [resultado observable] |
| CA-01.2 | HU-01 | [caso límite] | [acción] | [respuesta del sistema] |

## 3. Requisitos Funcionales pendientes (EARS)
*(CUANDO [disparador], EL SISTEMA DEBE [acción]. La numeración continúa desde el máximo de `history/`)*

| RF | Prioridad | Cubre | Requisito | RN |
|----|-----------|-------|-----------|----|
| RF-03 | Must | HU-01 | CUANDO [evento], EL SISTEMA DEBE [comportamiento]. | — |
| RF-04 | Should | HU-01 | MIENTRAS [estado], EL SISTEMA DEBE [comportamiento continuo]. | RN-01 |
| RF-05 | Could | HU-01 | SI [condición], EL SISTEMA DEBE [A]; DE LO CONTRARIO, [B]. | — |

## 4. Reglas de Negocio — opcional
*(Solo si: la usan 2+ RF, viene de fuera del equipo, o el negocio la cambia seguido; si no, va dentro del RF)*

| RN | Regla | Origen | Aplica en |
|----|-------|--------|-----------|
| RN-01 | [ej. Un pedido enviado no puede cancelarse] | [área/documento] | RF-04, RF-05 |

## 5. Requisitos No Funcionales
| RNF | Prioridad | Categoría | Requisito |
|-----|-----------|-----------|-----------|
| RNF-01 | Must | Rendimiento | [tiempo de respuesta esperado] |
| RNF-02 | Must | Seguridad | [autorización] |

## 6. Restricciones
| Tipo | Detalle |
|------|---------|
| Técnica | [ej. stack del Perfil técnico, sin dependencias de pago] |
| Legal | [datos personales, facturación, retención] |
| Otra | [plazos, presupuesto, dependencias] |

## 7. Datos e Integraciones Externas
| Sistema | Dirección | Datos | RF |
|---------|-----------|-------|----|
| [ej. Pasarela de pago] | Salida / Entrada | [qué se envía o recibe] | RF-03 |

## 8. Casos Límite y Errores
| Caso | Comportamiento esperado | RF |
|------|--------------------------|----|
| [entrada vacía / no encontrado / red caída] | [respuesta segura] | RF-03 |

## 9. Fuera de Alcance (Won't)
- [funcionalidad excluida y motivo]

## 10. Propiedades de Corrección
| P | Propiedad | RF |
|---|-----------|----|
| P1 | [ej. Un cambio de estado no modifica timestamps de estados anteriores] | RF-03 |

## 11. Decisiones de Diseño
| Decisión | Justificación | Alternativa descartada | RF |
|----------|---------------|------------------------|----|
| [decisión] | [por qué] | [opción y motivo] | RF-03 |

## 12. Trazabilidad HU ↔ RF ↔ Tests
*(Solo pendientes; lo cerrado está en `history/<dominio>.md`)*

| HU | RF | CA | Test | Estado |
|----|----|----|------|--------|
| HU-01 | RF-03 | CA-01.1 | [ruta según `structure`] | ⬜ Pendiente |

## 13. Definition of Done
- [ ] Todo RF pendiente con pruebas automatizadas en verde (Exit Code 0).
- [ ] Cada RF con prioridad MoSCoW y ≥1 HU; cada CA con ≥1 test.
- [ ] Sin ambigüedades; propiedades validadas con tests.
- [ ] Trazabilidad completa; diagramas de negocio actualizados.
