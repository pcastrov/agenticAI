---
name: stack-conventions
description: Convenciones idiomáticas por framework (Laravel, Filament, NativePHP, Django, FastAPI, Flutter) según la clave `conventions` del Perfil técnico de AGENTS.md. Usar al planificar, escribir o revisar código.
---

# Stack Conventions Skill

## Descripción
Guías de código idiomático por framework. El núcleo del flujo SDD es agnóstico; esta skill aporta las convenciones concretas del stack que indica la clave `conventions` del `## Perfil técnico` de `AGENTS.md` (ej. `laravel, filament`).

## Cuándo Usar Esta Skill
- `1-planner` MODO 2: para ubicar archivos y capas en `plan.md`.
- `2-implementer`: antes de escribir o modificar código.
- `3-qa-reviewer` MODO 2 y 3: para revisar la idiomaticidad del plan y del diff.
- `/retrofit`: para detectar desviaciones como deuda técnica.

---

## Referencias (Lazy Loading)
Lee **solo** las referencias listadas en `conventions`. Si la clave falta o dice `no configurado`, aplica únicamente los Principios Generales de abajo.

| Valor en `conventions` | Archivo |
|------------------------|---------|
| `laravel` | `references/laravel.md` |
| `filament` | `references/filament.md` (Filament 5.x; se usa junto con `laravel`) |
| `nativephp` | `references/nativephp.md` (se usa junto con `laravel`) |
| `django` | `references/django.md` |
| `fastapi` | `references/fastapi.md` |
| `flutter` | `references/flutter.md` |

Cada referencia lleva un frontmatter de regla de Cursor (`description`, `globs`, `alwaysApply: false`). Mientras vive en esta skill está inactiva; `/init` copia las del stack a `.cursor/rules/stack-[nombre].mdc` para que Cursor las adjunte automáticamente al editar archivos que coincidan con `globs`.

---

## Orden de Prioridad
1. `docs/constitution.md`.
2. Sección **Convenciones** de `AGENTS.md` (decisiones propias del proyecto, ej. "usamos `handle()` en las Actions" o "lógica en modelos, no en `services/`").
3. Referencia del stack de esta skill.
4. Principios Generales.

Si el proyecto ya tiene una convención establecida y consistente distinta a la referencia, se sigue la del proyecto y se anota en `AGENTS.md`.

## Alcance
- Las reglas aplican al **código nuevo o modificado**.
- No refactorices código existente solo para alinearlo con la guía: propón la refactorización como tarea (`1-planner`) o regístrala como deuda técnica.

## Niveles de las Reglas
- **Debe**: obligatoria. Su violación en código nuevo o modificado es un hallazgo bloqueante del QA, salvo desviación justificada y aprobada.
- **Preferir**: recomendada. Su violación es una sugerencia no bloqueante.

---

## Principios Generales (todos los stacks)
1. **Puntos de entrada delgados** (Debe): controladores, rutas, recursos de UI y widgets solo orquestan: reciben, validan, delegan y responden. Sin lógica de negocio, cálculos ni múltiples consultas.
2. **Lógica en unidades de propósito único** (Debe): extrae a una acción, servicio o controlador de estado cuando hay transacción, varios modelos, una regla de negocio o reutilización. Un CRUD simple no necesita extracción (Preferir no sobre-abstraer).
3. **Validar en la frontera** (Debe): la entrada se valida en la capa de transporte y hacia adentro solo viajan datos limpios y tipados, nunca el objeto `Request` del framework.
4. **Consultas eficientes** (Debe): sin consultas N+1; las consultas repetidas o con reglas de negocio viven en un lugar con nombre (scope, queryset, repositorio real).
5. **Sin capas vacías** (Debe): no crees repositorios, interfaces o servicios que solo reenvían llamadas al ORM o a otra clase.
6. **Efectos secundarios separados** (Preferir): notificaciones, llamadas a APIs externas y trabajo lento van a colas o tareas en segundo plano, disparadas después de confirmar la transacción. Nunca se llama a una API externa dentro de una transacción de base de datos.
7. **Autorización explícita** (Debe): con el mecanismo nativo del framework, no con condicionales sueltos.
8. **Simplicidad DRY / KISS / YAGNI** (Preferir; siempre como consulta): reutilizar lo que ya existe, elegir la solución más simple y no agregar nada que ningún `RF-x` pida. Todo hallazgo se consulta y nunca se aplica por iniciativa propia. La búsqueda solo cubre `## Código Compartido` de `AGENTS.md` y el módulo activo, solo código propio. Alcance, criterios y formato en `global-sdd.md`, sección 2.2. Cada referencia tiene una sección **DRY en este stack** con la duplicación aceptable del framework y las carpetas excluidas.
9. **Verificación automática** (Preferir): las reglas "Debe" se respaldan con linters y tests de arquitectura (sección final de cada referencia) configurados en la clave `lint` o en la suite de tests.
