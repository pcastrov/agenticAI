# /init - Inicializador de Gobernanza (AGENTS, MEMORY, Constitución y SDD)

Este comando prepara cualquier proyecto de software (existente o nuevo, en cualquier lenguaje o framework) para trabajar con el flujo SDD. Genera la "Trinidad de Contexto": `AGENTS.md`, `MEMORY.md` y `docs/constitution.md`, incluyendo el bloque `## Perfil técnico` que consumen los subagentes.

## Responsabilidad de cada archivo
- **`AGENTS.md`**: Hechos del proyecto (stack, versiones, estructura, comandos, convenciones, reglas de dominio). Cambia cuando cambia el stack.
- **`docs/constitution.md`**: Principios no negociables. Puede citar el stack ("preferir las convenciones nativas del framework"), pero nunca versiones ni comandos.
- **`MEMORY.md`**: Estado actual, decisiones y aprendizajes.

---

## Instrucción para la IA

### PASO 1: Verificar el Flujo SDD
1. Comprueba que existan `.cursor/rules/global-sdd.md`, `.cursor/subagents/1-planner.md` y `.cursor/sdd-kit.md`.
2. Lee la versión instalada en `.cursor/sdd-kit.md`.
   - **Si falta el flujo**: indica al usuario que copie la carpeta `.cursor/` del paquete `sdd-kit` (ver `.cursor/sdd-kit/README.md` del paquete) y vuelve a ejecutar `/init`. No lo recrees de memoria.
   - **Si existe**: informa la versión e indica que se puede actualizar con `/sdd-update`.
3. Si existen `AGENTS.md`, `MEMORY.md` o `docs/constitution.md`, léelos primero para preservar decisiones, contexto e historia.

### PASO 2: Determinar el Camino
- **Proyecto existente** (hay manifiestos o código): ve al PASO 3A.
- **Proyecto nuevo o vacío**: ve al PASO 3B.

### PASO 3A: Detección Automática (proyecto existente)
1. Escanea manifiestos y configuración en la raíz (ej: `composer.json`, `package.json`, `pyproject.toml`, `requirements.txt`, `Pipfile`, `go.mod`, `Cargo.toml`, `pom.xml`, `build.gradle`, `Gemfile`, `*.csproj`) y la estructura de carpetas.
2. Usa herramientas del proyecto para confirmar versiones instaladas cuando existan (ej: `composer show --direct`, `npm ls --depth=0`, `pip list`, `go list -m all`).
3. Identifica: lenguaje y versión, framework(s), base de datos, runner de tests, linter/formatter, UI/frontend, despliegue, carpetas de código y de tests.
4. Pregunta al usuario **solo** lo que no se pueda deducir o sea ambiguo (ej. dos runners de tests instalados, motor de BD distinto entre `.env` y docs). Máximo 5 preguntas.

### PASO 3B: Entrevista (proyecto nuevo)
Haz una entrevista corta proponiendo un valor por defecto en cada pregunta para que el usuario solo confirme:
1. Lenguaje y versión.
2. Framework(s) principal(es).
3. Base de datos.
4. Runner de tests.
5. Linter / formatter.
6. UI / frontend (si aplica).
7. Despliegue / hosting.

### PASO 4: Bloque `## Perfil técnico` en `AGENTS.md`
Escribe o actualiza este bloque con claves fijas. Si un valor no aplica o aún no está configurado, escribe `no configurado` (los subagentes se detendrán a preguntar en lugar de inventarlo).

```markdown
## Perfil técnico
- **language**: [lenguaje y versión]
- **framework**: [framework(s) y versión]
- **database**: [motor]
- **test**: [comando de la suite completa]
- **test_single**: [comando para un test, con {name}]
- **lint**: [comando de linter/formatter]
- **run**: [comando o URL local]
- **migrate**: [comando de migraciones o "no aplica"]
- **structure**: [carpetas de código y tests]
- **ui_check**: [cómo verificar cambios visuales o "no aplica"]
- **security_audit_skill**: [skill de auditoría del stack o "no configurado"]
```

### PASO 5: Skills del Stack
Si el stack detectado tiene skills o herramientas de agente propias (ej. Laravel Boost en Laravel), sugiere instalarlas. No forman parte del paquete SDD y no deben copiarse dentro de él.

### PASO 6: `docs/constitution.md`
Crea o actualiza **6 principios innegociables, cortos y verificables** (máximo 15 líneas):
1. **Simplicidad del Stack**: Priorizar convenciones nativas del framework antes de instalar librerías de terceros.
2. **Relación Spec-Código**: Ningún código existe ni se modifica sin un Requisito Funcional (`RF-x`) o Tarea previa en `specs/`.
3. **Separación Lógica / UI**: Desacoplar la lógica de negocio de los componentes visuales o vistas.
4. **Política de Tests**: Pruebas automatizadas obligatorias con el runner del Perfil técnico.
5. **Protección de Datos**: Respeto estricto a autorizaciones, validaciones de entrada y manejo seguro de datos.
6. **Idioma**: Código, variables y comentarios en **Inglés**; documentación en `specs/`, UI e interfaces al usuario en **Español** (ajustable si el usuario indica otro).

### PASO 7: Resto de `AGENTS.md`
Crea o actualiza las secciones con datos reales del proyecto:
- **Nombre y Descripción**, **Stack y Estructura**, **Comandos** (copiables), **Convenciones**, **Reglas de Dominio**.
- **Forma de Trabajar**: flujo SDD con subagentes (`@1-planner.md`, `@2-implementer.md`, `@3-qa-reviewer.md`) y regla de histórico (`history.md`, mover nunca borrar).
- **Límites**: qué hacer siempre, qué preguntar antes y qué no hacer nunca.
- **Verificación**: cómo dar una tarea por verificada en este proyecto.

### PASO 8: `MEMORY.md`
Crea o actualiza (máximo ~50 líneas):
- **Estado actual**, **Decisiones (y por qué)**, **Aprendizajes y errores a evitar**.
- **Próximos pasos**: si hay código sin specs, ingeniería inversa con `/retrofit`.

---

## Formato de Salida
1. Resumen del **Stack Detectado** (o de las respuestas de la entrevista) y versión del flujo SDD instalada.
2. Borrador del bloque `## Perfil técnico` y de `docs/constitution.md`.
3. 🛑 **DETENTE Y ESPERA**: Solicita aprobación explícita del usuario antes de escribir los archivos.

---

## Comandos SDD Disponibles

| Comando | Propósito |
|---------|-----------|
| `/sdd` | Flujo completo SDD (8 fases) |
| `/retrofit` | Ingeniería inversa de código existente |
| `/architect` | Subagente planner |
| `/implement` | Subagente implementer (TDD) |
| `/review` | Subagente QA reviewer |
| `/security` | Auditoría de seguridad e integración en specs |
| `/validation-trace` | Valida trazabilidad RF ↔ arquitectura ↔ tests |
| `/validation-properties` | Valida propiedades de corrección |
| `/sdd-archive` | Cierra la iteración de un módulo en `history.md` |
| `/sdd-update` | Actualiza el flujo desde el paquete `sdd-kit` |
