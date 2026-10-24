# Especificación Funcional: [Nombre del Módulo]

**Estado**: Borrador | Aprobado
**Módulo**: `NNN-[id-nombre-modulo]`
**Histórico**: `specs/NNN-[id-nombre-modulo]/history.md`
**Diagramas**: `specs/NNN-[id-nombre-modulo]/diagramas/`

> Cada requisito debe ser **claro** (una sola interpretación), **útil** (cubre una historia), **comprobable** (criterio de aceptación o propiedad), **trazable** (ID estable y origen) y **actualizado** (no contradice lo ya implementado).

---

## 0. Ya implementado
*(Una línea por RF cerrado. El detalle completo está en `history.md`; buscarlo por ID solo si la tarea actual lo necesita)*

- `RF-01` — [Resumen en una línea] (Iteración 1)
- `RF-02` — [Resumen en una línea] (Iteración 1, sin tests → `T5`)

## 1. Contexto y Objetivo
- **Problema**: [Descripción breve del problema actual o necesidad de negocio]
- **Objetivo**: [Qué resuelve este módulo y cuál es el valor esperado]

## 2. Usuarios e Historias de Usuario
- **Roles Afectados**: [ej. Usuario Final, Administrador, Sistema]

### HU-01: [Título corto]
- **Historia**: Como [rol], quiero [objetivo] para [beneficio].
- **Prioridad**: `Must` | `Should` | `Could`
- **Diagrama**: `diagramas/HU-01-negocio.puml`
- **Criterios de aceptación**:
  - **CA-01.1**: DADO [contexto inicial], CUANDO [acción del usuario], ENTONCES [resultado observable].
  - **CA-01.2**: DADO [contexto de caso límite], CUANDO [acción], ENTONCES [respuesta del sistema].

## 3. Requisitos Funcionales (RF) pendientes
*(Notación EARS: CUANDO [disparador], EL SISTEMA DEBE [acción]. La numeración continúa desde el máximo de `history.md`. Cada RF indica su prioridad MoSCoW y la historia que cubre)*

- **RF-03** `[Must]` (Cubre: `HU-01`): CUANDO [evento/disparador], EL SISTEMA DEBE [comportamiento esperado].
- **RF-04** `[Should]` (Cubre: `HU-01`, aplica: `RN-01`): MIENTRAS [estado], EL SISTEMA DEBE [comportamiento continuo].
- **RF-05** `[Could]` (Cubre: `HU-01`): SI [condición], EL SISTEMA DEBE [comportamiento condicional]; DE LO CONTRARIO, EL SISTEMA DEBE [comportamiento alternativo].

## 4. Reglas de Negocio (RN) — opcional
*(Políticas que serían ciertas aunque no existiera el software. Crear una `RN-x` solo si: la usan 2 o más RF, viene de fuera del equipo (legal, contable, política del cliente) o es un dato que el negocio cambia seguido. Si solo aplica a un RF, se redacta dentro de ese RF)*

- **RN-01**: [Regla, ej. "Un pedido enviado no puede cancelarse"]
  - **Origen**: [Área, documento o persona que la define]
  - **Aplica en**: `RF-04`, `RF-05`

## 5. Requisitos No Funcionales (RNF)
- **RNF-01** `[Must]`: Rendimiento / Tiempo de respuesta esperado.
- **RNF-02** `[Must]`: Seguridad / Autorización.
- **RNF-03** `[Should]`: Usabilidad / Accesibilidad / Compatibilidad.

## 6. Restricciones
- **Técnicas**: [Limitaciones impuestas, ej. debe correr en el stack del Perfil técnico, sin nuevas dependencias de pago]
- **Legales / Normativas**: [ej. protección de datos personales, facturación, retención de registros]
- **Otras**: [Plazos, presupuesto, dependencias de otros equipos]

## 7. Datos e Integraciones Externas
| Sistema / Fuente | Dirección | Datos intercambiados | RF |
|------------------|-----------|----------------------|----|
| [ej. Pasarela de pago] | Salida / Entrada | [qué se envía o recibe] | RF-03 |

## 8. Casos Límite y Manejo de Errores
- **Caso 1**: [Entrada vacía / Recurso no encontrado / Falla de red / Integración caída].
  - **Comportamiento Esperado**: [Cómo responde el sistema de forma segura].

## 9. Fuera de Alcance (Won't)
- [Funcionalidad que NO se incluye en esta versión y motivo]

## 10. Propiedades de Corrección (Property-Based Testing)
*(Formulaciones formales que el código debe cumplir)*

- **P1**: [Ej. "Si una entidad cambia de estado, los timestamps de estados anteriores NO se modifican"]
- **P2**: [Ej. "Para toda consulta de un usuario, solo se devuelven registros dentro de su alcance autorizado"]
- **P3**: [Ej. "Si un usuario no tiene permiso, la acción es denegada y no hay efectos secundarios"]

## 11. Decisiones de Diseño
*(Justificación y alternativas descartadas)*

- **Decisión 1**: [Descripción de la decisión]
  - **Justificación**: [Por qué se tomó esta decisión]
  - **Alternativa descartada**: [Qué otra opción se consideró y por qué se descartó]
  - **Trazabilidad**: [RF-x que cubre]

## 12. Trazabilidad HU ↔ RF ↔ Tests
*(Solo RF pendientes; los cerrados tienen su trazabilidad en `history.md`)*

| HU | RF | Criterio | Test | Estado |
|----|----|----------|------|--------|
| HU-01 | RF-03 | CA-01.1 | [ruta del test según `structure` del Perfil técnico] | ⬜ Pendiente |

## 13. Criterios de Finalización (Definition of Done)
- [ ] Todos los `RF-x` pendientes cuentan con pruebas automatizadas en verde.
- [ ] Cada `RF-x` tiene prioridad MoSCoW y cubre al menos una `HU-x`.
- [ ] Cada criterio de aceptación `CA-x` tiene al menos un test.
- [ ] La especificación está validada sin ambigüedades pendientes.
- [ ] Propiedades de corrección validadas con tests.
- [ ] Trazabilidad HU ↔ RF ↔ Tests completa.
- [ ] Diagramas de negocio de las historias afectadas actualizados.
