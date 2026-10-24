# /retrofit - Ingeniería Inversa y Migración a SDD

Este comando analiza una base de código existente para generar masivamente la documentación inicial en `specs/` sin interrumpir el código que ya funciona.

## Instrucción para la IA

Invocando las reglas de `@1-planner.md`, primero lee el bloque `## Perfil técnico` de `AGENTS.md` (si no existe, ejecuta `/init` antes). Luego analiza la aplicación recorriendo las carpetas de `structure` (persistencia, modelos/entidades, servicios, controladores/endpoints, interfaz, autorización, rutas) y ejecuta la ingeniería inversa siguiendo estos pasos:

### 1. Mapeo e Identificación de Módulos
- Agrupa la lógica del proyecto en módulos de negocio.
- Asigna a cada módulo una carpeta en `specs/NNN-[id-nombre-modulo]/` (empezando por `001-`).

### 2. `history.md` de cada módulo (lo que ya existe)
- Crea `history.md` con la entrada `## Iteración 1 — AAAA-MM-DD — Retrofit` según `history-template.md`.
- Deduce las Historias de Usuario (`HU-x`) a partir de los flujos reales (rutas, pantallas, roles) e inclúyelas en "Historias cerradas" con sus criterios `CA-x.y` cuando el comportamiento esté probado.
- Incluye los Requisitos Funcionales (`RF-x`) en notación EARS extraídos del código real, cada uno con su prioridad MoSCoW estimada y la `HU-x` que cubre, sus decisiones de diseño y técnicas, la arquitectura implementada y las tareas ya construidas como `- [x]`.
- Marca cada RF sin tests como `sin tests → Tx`.
- Registra como `RN-x` las reglas de negocio detectadas que cumplan la regla de uso de la skill (usadas por 2 o más RF, origen externo o dato cambiante).

### 3. `spec.md` de cada módulo (lo pendiente)
- Sección `0. Ya implementado` con una línea por RF archivado.
- Contexto, usuarios, historias vigentes, reglas de negocio vigentes, RNF, restricciones, datos e integraciones externas, casos límite y fuera de alcance (Won't) vigentes del módulo.
- Sección de **Propiedades de Corrección** (Property-Based Testing) para los RF críticos.
- Sección de **Trazabilidad RF ↔ Tests** para lo pendiente.
- Sección final `## Dudas, Ambigüedades y Deuda Técnica Detectada` con inconsistencias o fallas encontradas, incluyendo los RF a los que no se les pudo asociar una `HU-x` y las prioridades MoSCoW que el usuario debe confirmar.

### 4. `plan.md` de cada módulo
- Tabla breve de la **estructura vigente** del módulo (capas y archivos clave).
- Arquitectura y mitigaciones de lo pendiente, con **Trazabilidad Arquitectónica** (archivo ↔ RF) y **Mapeo de Propiedades ↔ Tests**.

### 5. Diagramas de cada módulo
- En `specs/NNN-[id-nombre-modulo]/diagramas/`, un diagrama de negocio (`HU-x-negocio.puml`) y uno técnico (`HU-x-tecnico.puml`) por cada flujo principal, según las plantillas `.puml` de la skill. Describen el comportamiento real del código, incluidos los casos límite que maneja.

### 6. `tasks.md` de cada módulo
- Solo tareas `- [ ]`: lo que falta construir o probar (tests faltantes, validaciones, políticas de acceso no creadas, deuda).
- Cada tarea con **Prioridad** (blocker/required/optional/nice-to-have), **Propiedades validadas**, **Tests asociados** y **Hecho cuando**.
- La numeración continúa después de las tareas archivadas en `history.md`.
