# /init - Inicializador de Gobernanza Dinámico (AGENTS, MEMORY y Constitución)

Este comando analiza cualquier proyecto de software (existente o nuevo) para inspeccionar sus tecnologías y generar la "Trinidad de Contexto": `AGENTS.md`, `MEMORY.md` y `docs/constitution.md`.

## Instrucción para la IA

### PASO 1: Inspección de Archivos y Manifiestos
1. Revisa si existen previamente los archivos `AGENTS.md`, `MEMORY.md` y `docs/constitution.md`.
   - **Si existen**: Léelos primero para preservar decisiones previas, contexto o historia.
2. Escanea los archivos de configuración y manifiestos de dependencias presentes en la raíz del proyecto (ej: `composer.json`, `package.json`, `Pipfile`, `go.mod`, etc.) junto con la estructura de carpetas (`app/`, `src/`, `tests/`, etc.).
3. Identifica de forma autónoma:
   - Framework principal y versión exactos.
   - Herramientas de UI / Panel / Frontend.
   - Framework de Testing detectado (ej: PHPUnit, Pest, Jest, Vitest, PyTest).
   - Estándar de código / Linters configurados.

---

### PASO 2: Generación Adaptativa de `docs/constitution.md`
Crea `docs/constitution.md` redactando **6 principios innegociables, cortos y verificables** (máximo 15 líneas en total) **adaptados al stack real detectado**:
1. **Simplicidad del Stack**: Priorizar convenciones nativas del framework detectado antes de instalar librerías de terceros.
2. **Relación Spec-Código**: Ningún código existe ni se modifica sin un Requisito Funcional (`RF-x`) o Tarea previa en `specs/`.
3. **Separación Lógica / UI**: Desacoplar la lógica de negocio pesada de los componentes visuales o vistas.
4. **Política de Tests**: Pruebas automatizadas obligatorias ejecutadas con el runner nativo detectado (sin instalar dependencias extra innecesarias).
5. **Protección de Datos**: Respeto estricto a las políticas de acceso, autorizaciones, validaciones de entrada y manejo seguro de datos del usuario.
6. **Idioma**: Código, variables y comentarios en **Inglés**; documentación en `specs/`, UI e interfaces dirigidas al usuario en **Español**.

---

### PASO 3: Generación Dinámica de `AGENTS.md` (En la raíz)
Crea o actualiza `AGENTS.md` estructurado en sus 8 secciones clave con los datos reales del proyecto:
- **Nombre y Descripción**: Qué hace el proyecto según la inspección.
- **Stack y Estructura**: Lenguaje, framework, motor de BD y descripción de directorios clave.
- **Comandos**: Comandos copiables para iniciar servidor, ejecutar la suite de pruebas detectada y migraciones/scripts.
- **Convenciones**: Estándar de código detectado, reglas de nombrado e idiomas.
- **Reglas de Dominio**: Trampas conocidas o particularidades del negocio deducidas del código.
- **Forma de Trabajar**: Flujo SDD con subagentes (`@1-planner.md`, `@2-implementer.md`, `@3-qa-reviewer.md`).
- **Límites**: Qué hacer siempre (tests), qué preguntar antes (dependencias/migraciones) y qué no hacer nunca.
- **Verificación**: Métodos exactos para dar una tarea por verificada en este proyecto.

---

### PASO 4: Generación de `MEMORY.md` (En la raíz)
Crea `MEMORY.md` (máximo ~50 líneas) estructurado en:
- **Estado actual**: Módulos y estado actual detectado en el código.
- **Decisiones (y por qué)**: Elecciones técnicas fundamentales identificadas en el stack.
- **Aprendizajes y errores a evitar**: (vacío por ahora).
- **Próximos pasos**: Inicialización del flujo SDD e ingeniería inversa con `/retrofit`.

---

## Formato de Salida
1. Muestra un resumen del **Stack Tecnológico Detectado**.
2. Presenta el borrador de `docs/constitution.md` (los 6 principios adaptados en máx. 15 líneas).
3. 🛑 **DETENTE Y ESPERA**: Solicita la aprobación explícita del usuario antes de confirmar la escritura final.
