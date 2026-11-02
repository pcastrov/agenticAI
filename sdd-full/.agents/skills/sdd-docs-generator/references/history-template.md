# Histórico: [Nombre del Módulo]

**Módulo**: `NNN-[id-nombre-modulo]`

> Archivo append-only. Nunca se edita ni se borra una iteración anterior; solo se agregan nuevas al final.
> Los agentes NO lo leen completo: buscan por ID (`HU-02`, `RF-04`, `RN-01`, `T7`, `P2`, `VULN-03`) o palabra clave y leen solo la entrada encontrada.

---

## Iteración 1 — AAAA-MM-DD — [Título breve]

**Veredicto QA**: APROBADO | Retrofit (sin QA)

### Historias cerradas
*(Solo las HU cuyos RF están todos cerrados, con su texto y criterios completos)*
- **HU-01** `[Must]`: Como [rol], quiero [objetivo] para [beneficio].
  - **CA-01.1**: DADO [contexto], CUANDO [acción], ENTONCES [resultado]. — Test: `[ruta]`

### Requisitos cerrados
- **RF-01** `[Must]` (Cubre: `HU-01`): CUANDO [disparador], EL SISTEMA DEBE [comportamiento]. — Tests: `[ruta]` | sin tests → `T5`
- **RF-02**: ...

### Reglas de negocio
*(Solo si una RN dejó de aplicar a RF pendientes o cambió su texto; las RN vigentes siguen en `spec.md`)*
- **RN-01**: [Regla] — Origen: [área / documento]. Aplicó en: `RF-01`.

### Diagramas actualizados
- `diagramas/HU-01-negocio.md`: [qué cambió, ej. agrega RF-02 y el caso límite de pago rechazado].
- `diagramas/HU-01-tecnico.md`: [qué cambió].

### Propiedades
- **P1**: [Propiedad] — Test: `[ruta]`

### Decisiones de diseño y técnicas
- **[Decisión]**: [Justificación]. Alternativa descartada: [opción y motivo].

### Arquitectura archivada
- [Resumen de archivos, contratos o pseudocódigo relevante de los RF cerrados]

### Tareas completadas
- [x] **T1: [Título]** — RF-01. Hecho cuando: [criterio].
- [x] **T2: [Título]** — RF-02. Hecho cuando: [criterio].
