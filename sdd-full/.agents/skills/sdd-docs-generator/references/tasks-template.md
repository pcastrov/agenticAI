# Lista de Tareas Ejecutables: [Nombre del Módulo]

**Módulo**: `NNN-[id-nombre-modulo]`
**Ruta**: `specs/NNN-[id-nombre-modulo]/`

> Solo tareas pendientes. Al cerrar la iteración, las tareas `- [x]` se mueven a `history.md` (nunca se borran). La numeración continúa desde el máximo histórico.

---

- [ ] **Tarea T1: Escribir tests del modelo de datos y crear persistencia**
  - **Cubre**: `RF-01`
  - **Archivos**: `[migración / esquema]`, `[modelo / entidad]`, `[test]`
  - **Prioridad**: `required`
  - **Propiedades validadas**: `P1`
  - **Tests asociados**: `[ruta del test]`
  - **Hecho cuando**: La persistencia se crea limpiamente (clave `migrate` del Perfil técnico, si aplica) y el test pasa en verde.

- [ ] **Tarea T2: Implementar caso de uso / endpoint principal**
  - **Cubre**: `RF-01`, `RF-02`
  - **Archivos**: `[servicio]`, `[controlador / pantalla]`, `[test]`
  - **Prioridad**: `blocker`
  - **Propiedades validadas**: `P1`, `P2`
  - **Tests asociados**: `[ruta del test]`
  - **Hecho cuando**: Los tests de integración del flujo principal pasan en verde con la clave `test`.

- [ ] **Tarea T3: Implementar autorización y casos límite**
  - **Cubre**: `RF-03`, Casos Límite de `spec.md`
  - **Archivos**: `[política / middleware]`, `[test de seguridad]`
  - **Prioridad**: `blocker`
  - **Propiedades validadas**: `P3`
  - **Tests asociados**: `[ruta del test de seguridad]`
  - **Hecho cuando**: Los accesos no autorizados se deniegan y los tests de casos límite están en verde.
