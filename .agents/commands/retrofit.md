# /retrofit - Ingeniería Inversa y Migración a SDD

Este comando analiza una base de código existente para generar masivamente la documentación inicial en `specs/` sin interrumpir el código que ya funciona.

## Instrucción para la IA

Invocando las reglas de `@1-planner.md`, primero lee el bloque `## Perfil técnico` de `AGENTS.md` (si no existe, ejecuta `/init` antes). Luego analiza la aplicación recorriendo las carpetas de `structure` (persistencia, modelos/entidades, servicios, controladores/endpoints, interfaz, autorización, rutas) y ejecuta la ingeniería inversa siguiendo estos pasos:

### 0. Herramientas del stack (antes de mapear)
Si `conventions` incluye `laravel` (o el framework es Laravel) y `laravel/boost` **no** está instalado:
1. Propón instalar Laravel Boost (mismo flujo que el PASO 5 de `/init`: `composer require laravel/boost --dev`, `boost.json` con el agente host + MCP/guidelines, `php artisan boost:install`).
2. 🛑 **DETENTE Y ESPERA** la aprobación del usuario.
3. Tras aprobar e instalar, pide activar el MCP `laravel-boost` en el agente host si aún no está activo.

Si Boost **ya** está instalado (o acaba de instalarse), úsalo durante el retrofit:
- **Application Info** / **Database Schema**: modelos, paquetes y esquema reales, para no inventar tablas ni relaciones.
- **Database Query** (solo lectura): confirmar datos o conteos cuando haga falta para entender un flujo.
- **Search Docs**: firmar APIs de Laravel/Filament/Livewire/Pest con la documentación de la versión instalada.
- **Last Error** / **Read Log Entries**: si el proyecto no arranca limpio, anotar la falla en la deuda técnica.

No ejecutes mutaciones de BD ni cambies código de la aplicación durante el retrofit: solo lees e instalas herramientas de agente si el usuario lo aprobó.

### 1. Mapeo e Identificación de Módulos
- Agrupa la lógica del proyecto en módulos de negocio.
- Asigna a cada módulo una carpeta en `specs/NNN-[id-nombre-modulo]/` (empezando por `001-`).
- Identifica el **código propio compartido** entre módulos (clases abstractas, bases, traits, helpers o componentes que usan dos o más módulos; nada del framework ni de las exclusiones "DRY en este stack") y propón agregarlo a `## Código Compartido` de `AGENTS.md`. No lo escribas sin aprobación.
- Registra en la deuda técnica de cada módulo las reglas de negocio duplicadas que detectes (sin corregirlas), según "Qué cuenta como duplicación" de `global-sdd.md`, sección 2.2.

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
- Sección final `## Dudas, Ambigüedades y Deuda Técnica Detectada` con inconsistencias o fallas encontradas, las desviaciones de las reglas "Debe" de las guías de `conventions` (ej. lógica en controladores, N+1, validación inline; sin corregirlas), incluyendo los RF a los que no se les pudo asociar una `HU-x` y las prioridades MoSCoW que el usuario debe confirmar.

### 4. `plan.md` de cada módulo
- Tabla breve de la **estructura vigente** del módulo (capas y archivos clave).
- Arquitectura y mitigaciones de lo pendiente, con **Trazabilidad Arquitectónica** (archivo ↔ RF) y **Mapeo de Propiedades ↔ Tests**.

### 5. Diagramas de cada módulo
- En `specs/NNN-[id-nombre-modulo]/diagramas/`, un diagrama de negocio (`HU-x-negocio.md`) y uno técnico (`HU-x-tecnico.md`) por cada flujo principal, según las plantillas `sequence-*-template.md` de la skill. Describen el comportamiento real del código, incluidos los casos límite que maneja.

### 6. `tasks.md` de cada módulo
- Solo tareas `- [ ]`: lo que falta construir o probar (tests faltantes, validaciones, políticas de acceso no creadas, deuda).
- Cada tarea con **Prioridad** (blocker/required/optional/nice-to-have), **Propiedades validadas**, **Tests asociados** y **Hecho cuando**.
- La numeración continúa después de las tareas archivadas en `history.md`.
