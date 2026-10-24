# Changelog

Formato: la primera entrada es la versión vigente del paquete (la que lee `/sdd-update`).

---

## 3.1.0 — 2026-10-24

Calidad de requisitos y diagramas de secuencia PlantUML.

### Agregado
- **5 atributos de calidad** (claro, útil, comprobable, trazable, actualizado) en la skill `sdd-docs-generator`. `3-qa-reviewer` MODO 1 los evalúa RF por RF en una tabla.
- **Historias de usuario con ID** (`HU-x`), prioridad MoSCoW y criterios de aceptación `CA-x.y` en formato DADO / CUANDO / ENTONCES. Cada RF indica qué historia cubre.
- **MoSCoW** en `HU`, `RF` y `RNF`. `Won't` es la sección "Fuera de Alcance". Regla nueva: un RF `Must` debe estar cubierto por al menos una tarea `blocker` o `required` (planner MODO 2 y QA MODO 4).
- **Reglas de negocio** `RN-x` (opcional) con origen y RF donde aplican, solo si la usan 2 o más RF, vienen de fuera del equipo o son datos que cambian seguido.
- **Secciones nuevas en `spec.md`**: Restricciones (técnicas, legales, otras) y Datos e Integraciones Externas.
- **Diagramas de secuencia PlantUML** en `specs/NNN-modulo/diagramas/`: `HU-x-negocio.puml` (con la spec, para cualquier persona) y `HU-x-tecnico.puml` (con el plan, por capas). Plantillas `sequence-business-template.puml` y `sequence-technical-template.puml`. Son documentos vigentes: se actualizan en su lugar y `history.md` solo registra qué cambió.
- **QA**: coherencia del diagrama de negocio (MODO 1) y del técnico (MODO 3); cobertura de criterios `CA` en MODO 2.
- **`history-template.md`**: subsecciones "Historias cerradas", "Reglas de negocio" y "Diagramas actualizados".
- **Integridad de los tests** (`global-sdd.md` 2.1 y `2-implementer`): prohibido modificar, borrar, saltar o debilitar un test existente para que pase, salvo cambio de spec aprobado o aprobación explícita del usuario. Todo bug se corrige primero con un test que lo reproduce.
- **Protocolo ante Tests Fallidos** en `2-implementer`: Reporte de Fallo (test, qué falló, dónde, tipo, causa probable con evidencia, propuesta) y criterios para decidir entre corregir ahora, nueva tarea con test de regresión o pasar por SDD.
- **`2-implementer` MODO C (Cambio Directo)**: ejecuta los cambios que no merecen spec; se detiene y propone SDD si el cambio crece.
- **QA MODO 2**: detecta en el diff tests modificados o debilitados sin justificación (hallazgo bloqueante); los hallazgos incluyen test que falla, causa probable y tipo.

### Cambiado
- **Trazabilidad** extendida a HU ↔ RF ↔ archivo ↔ test ↔ propiedad (`1-planner` MODO 4, `/validation-trace`, `global-sdd.md`).
- **`spec-template.md`** renumerado: Reglas de Negocio (4), RNF (5), Restricciones (6), Datos e Integraciones (7), Casos Límite (8), Fuera de Alcance (Won't) (9), Propiedades (10), Decisiones (11), Trazabilidad (12), DoD (13).
- **`plan-template.md`**: nueva sección 5 "Diagramas de Secuencia Técnicos"; las siguientes se renumeran. La estrategia de tests incluye cobertura por criterio `CA`.
- **`/retrofit`**: deduce HU, estima MoSCoW, detecta RN y genera los diagramas de los flujos principales; los RF sin HU y las prioridades por confirmar van a la sección de dudas.
- IDs estables ahora incluyen `HU` y `RN`.
- **Evaluación de Alcance** de `/sdd` con criterios explícitos (cambio directo vs SDD), justificación obligatoria ante el usuario y ejecución por `2-implementer` MODO C (antes el orquestador, que no escribe código, debía hacer el cambio). `global-sdd.md` la incorpora como paso 2 del flujo y `/implement` la aplica a peticiones fuera de `tasks.md`.
- **`2-implementer`**: el PASO 5 ya no dice "corrige inmediatamente" ante un fallo, y el MODO B ya no permite ajustar tests existentes; ambos remiten al Protocolo ante Tests Fallidos.
- **Documentación del paquete movida a `.cursor/sdd-kit/`**: `README.md` y `CHANGELOG.md` ya no están en la raíz del paquete, para no confundirse con los del proyecto donde se instala. Todo el paquete vive en `.cursor/`. `/sdd-update` los busca en la nueva ruta (y en la raíz si el paquete es 3.0.0); `/init` y `.cursor/sdd-kit.md` apuntan a la nueva ruta.

### Migración desde 3.0.0
`/sdd-update` copia `.cursor/sdd-kit/README.md` y `.cursor/sdd-kit/CHANGELOG.md` al proyecto. No toca el `README.md` ni el `CHANGELOG.md` de la raíz del proyecto: si alguna vez se copiaron ahí los del paquete, bórralos a mano.

La adopción de los nuevos requisitos no es obligatoria. Los módulos existentes siguen funcionando; al tocar un módulo con `1-planner` MODO 3, se agregan `HU-x`, MoSCoW y diagramas a los RF pendientes afectados. Para adoptarlo de una vez en un módulo, pide a `@1-planner.md`:
1. Agrupar los RF pendientes en `HU-x` con criterios `CA-x.y` y asignarles MoSCoW.
2. Agregar las secciones Restricciones y Datos e Integraciones Externas (o marcarlas "no aplica").
3. Crear `diagramas/HU-x-negocio.puml` y `diagramas/HU-x-tecnico.puml` de los flujos principales.

---

## 3.0.0 — 2026-10-24

Primera versión publicada como paquete independiente (`sdd-kit`), extraída del proyecto Ordéname Hub (Laravel 12 + Filament 5), donde el flujo se construyó y probó.

### Agregado
- **`history.md` por módulo**: histórico append-only de iteraciones cerradas. Los documentos activos (`spec.md`, `plan.md`, `tasks.md`) quedan solo con lo pendiente.
- **Índice `0. Ya implementado`** en `spec.md`: una línea por RF archivado.
- **Regla de lectura**: `history.md` solo bajo pedido o si la tarea se parece a algo hecho, buscando por ID o palabra clave.
- **`1-planner` MODO 6 (Cierre de iteración)** y FASE 8 de `/sdd` que lo invoca.
- **Comandos** `/sdd-archive` (cierre manual) y `/sdd-update` (actualización real desde el paquete; antes solo estaba mencionado).
- **Perfil técnico** en `AGENTS.md` (claves `language`, `framework`, `database`, `test`, `test_single`, `lint`, `run`, `migrate`, `structure`, `ui_check`, `security_audit_skill`). Los subagentes lo leen y se detienen si falta una clave.
- **`/init` con dos caminos**: detección automática (proyecto existente) o entrevista (proyecto nuevo).
- **`history-template.md`** en `sdd-docs-generator`.
- **`.cursor/sdd-kit.md`**: versión instalada y origen del paquete.

### Cambiado
- **Agnóstico de stack**: se quitaron referencias a Laravel, PHP, Filament, Eloquent, Pest y `php artisan test` de comandos, subagentes, regla y plantillas. Las plantillas de plan y tareas usan capas genéricas (Persistencia, Dominio/Servicios, Interfaz/API, Autorización, Tests).
- **Ejemplos de propiedades** del dominio de pedidos reemplazados por ejemplos neutrales.
- **`/security`** genérico: usa `security_audit_skill` del Perfil técnico o una checklist OWASP Top 10.
- **`/retrofit`**: lo ya construido va directo a `history.md`; un RF implementado sin tests se archiva como `sin tests → Tx` con la tarea pendiente.
- **"No borrar tareas `[x]`"** reemplazado por **"mover a `history.md`, nunca borrar"**.
- Se eliminaron los marcadores `**NUEVO**` / `(NUEVO)` que anotaban cambios dentro de las instrucciones.

### Eliminado
- **`.cursor/templates/sdd-flow.md`**: copia monolítica de todos los archivos del flujo que `/init` usaba para recrearlos. Duplicaba el contenido y ya estaba desincronizada (referenciaba `/sdd-init`, inexistente). Su parte explicativa pasó a `README.md`; el paquete en carpeta es ahora la única fuente.

### Migración desde 2.x
Para cada módulo en `specs/` (se puede pedir a `@1-planner.md`):
1. Crear `history.md` con `## Iteración 1 — AAAA-MM-DD — Retrofit` que contenga los RF implementados (texto completo), decisiones, arquitectura y tareas `[x]`.
2. En `spec.md`, agregar `## 0. Ya implementado` y quitar el detalle de esos RF.
3. En `plan.md`, dejar una tabla de estructura vigente y solo la arquitectura de lo pendiente.
4. En `tasks.md`, dejar solo las tareas `[ ]`.
5. Agregar el bloque `## Perfil técnico` a `AGENTS.md` (ejecutar `/init`).

---

## 2.0.0 — 2025-01-22

Integración de mejoras inspiradas en el flujo de specs de Kiro sobre el SDD existente.

### Agregado
- **`spec-template.md`**: secciones de Propiedades de Corrección (Property-Based Testing), Decisiones de Diseño (justificación y alternativas descartadas), Trazabilidad RF ↔ Tests y Criterios de Finalización ampliados.
- **`plan-template.md`**: Trazabilidad Arquitectónica (archivo ↔ RF) y Mapeo de Propiedades ↔ Tests.
- **`tasks-template.md`**: campos Prioridad (`blocker` / `required` / `optional` / `nice-to-have`), Propiedades validadas y Tests asociados.
- **`1-planner`**: MODO 4 (Validación de Trazabilidad) y MODO 5 (Generación de Propiedades); MODO 1-3 incorporan propiedades y trazabilidad.
- **`3-qa-reviewer`**: MODO 3 (Validación de Arquitectura) y MODO 4 (Validación de Tareas); MODO 1-2 verifican propiedades y trazabilidad.
- **`/sdd`**: FASE 4 (Validación de Arquitectura) y FASE 5 (Validación de Tareas); el flujo pasa a 8 fases.
- **Comandos** `/validation-trace` y `/validation-properties`.
- **`2-implementer`**: verificación de propiedades en el ciclo TDD.
- **`AGENTS.md`**: secciones de Especificación (EARS + Propiedades), Validación y Verificación, y checklists de spec/plan/tasks/implementación.
- **`/init`**: detección y copia del flujo SDD si no existe (vía `templates/sdd-flow.md`, reemplazado en 3.0.0).

### Beneficios buscados
Validación formal con propiedades, trazabilidad completa RF ↔ arquitectura ↔ tests ↔ propiedades, validaciones tempranas por QA antes de implementar, priorización explícita y documentación de decisiones.

---

## 1.0.0

Flujo SDD base: Trinidad de contexto (`AGENTS.md`, `MEMORY.md`, `docs/constitution.md`), subagentes `1-planner`, `2-implementer` (TDD) y `3-qa-reviewer`, comandos `/sdd`, `/retrofit`, `/architect`, `/implement`, `/review`, regla `global-sdd.md` y skill `sdd-docs-generator` con plantillas de spec, plan y tasks.
