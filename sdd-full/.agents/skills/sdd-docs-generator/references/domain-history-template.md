# Histórico de dominio: [Dominio] — [Nombre del Módulo]

**Archivo**: `specs/NNN-[id-nombre-modulo]/history/[dominio].md` · Índice: `history/index.md`

> Append-only. Nunca se edita ni se borra una iteración anterior; solo se agregan nuevas al final.
> **No se resume**: las decisiones arquitectónicas se conservan íntegras. La segmentación por dominio es lo que mantiene el contexto pequeño.
> Los agentes buscan por ID (`HU-02`, `RF-04`, `RN-01`, `T7`, `P2`, `VULN-03`) o keyword y leen solo la entrada encontrada.

---

## Iteración N — AAAA-MM-DD — [Título breve]

**Veredicto QA**: APROBADO | Retrofit (sin QA)

### Cerrado
| ID | Tipo | Texto completo | Prioridad | Test / Estado |
|----|------|----------------|-----------|---------------|
| HU-01 | HU | Como [rol], quiero [objetivo] para [beneficio]. | Must | — |
| CA-01.1 | CA | DADO [contexto], CUANDO [acción], ENTONCES [resultado]. | — | `[ruta]` |
| RF-01 | RF | CUANDO [disparador], EL SISTEMA DEBE [comportamiento]. (Cubre: HU-01) | Must | `[ruta]` / sin tests → `T5` |
| RN-01 | RN | [Regla] (Origen: [área]; aplicó en RF-01). Solo si dejó de aplicar a pendientes. | — | — |
| P1 | P | [Propiedad] | — | `[ruta]` |

### Decisiones de diseño y técnicas (íntegras)
| Decisión | Justificación | Alternativa descartada | RF |
|----------|---------------|------------------------|----|
| [qué se decidió] | [por qué] | [opción y motivo] | RF-01 |

### Arquitectura archivada
- Archivos: `[ruta]` — RF-01
- Contratos / pseudocódigo relevantes: [bloque]

### Diagramas actualizados
- `diagramas/HU-01-negocio.md`: [qué cambió]
- `diagramas/HU-01-tecnico.md`: [qué cambió]

### Tareas completadas
- [x] **T1** — RF-01 — Hecho cuando: [criterio].
