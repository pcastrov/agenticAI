# /sdd-update - Actualización del Flujo SDD

Actualiza los archivos del flujo SDD de este proyecto desde el paquete `sdd-kit` (origen público o ruta local).

## Instrucción para la IA

1. Lee `.cursor/sdd-kit.md` del proyecto: versión instalada y origen del paquete (`source`).
2. Si el usuario no indica otra ruta/URL, usa `source`. **Resuelve el origen** así:
   - **Ruta local** (absoluta o relativa que exista en disco): úsala directamente.
   - **URL de Git** (p. ej. `https://github.com/pcastrov/agenticAI` o `…/agenticAI.git`): clona o actualiza una copia de trabajo temporal con `git clone --depth 1` (o `git fetch` + `git checkout` si ya existe un clone en caché del mismo `source`). La raíz del clone es la raíz del paquete (contiene `.cursor/` y `.agents/`); para este host compara solo la carpeta `.cursor/` del clone. Borra o reutiliza la carpeta temporal al terminar; no la dejes dentro del proyecto del usuario.
   - Si `source` falta o no se puede leer, pregunta al usuario la ruta local o la URL del repo.
3. Lee la versión del paquete en `.cursor/sdd-kit/CHANGELOG.md` **del origen resuelto** (primera entrada) y las entradas posteriores a la versión instalada. Si no existe, búscalo en la raíz del paquete (`CHANGELOG.md`, ubicación hasta la 3.0.0).
4. Si la versión es la misma, informa que el flujo está al día y termina (salvo que el usuario pida solo verificar proyección AGENTS/constitution: entonces haz el paso 7).
5. Compara cada archivo listado en la sección "Archivos del paquete" de `.cursor/sdd-kit/README.md` del origen (o del `README.md` de su raíz, hasta la 3.0.0) contra su copia en `.cursor/` del proyecto y clasifícalos:
   - **Sin cambios locales**: se puede reemplazar directamente.
   - **Con cambios locales** (el proyecto lo personalizó): muestra el diff y pregunta si se reemplaza, se fusiona o se conserva.
   - **Nuevos en el paquete**: se copian.
   - **Eliminados del paquete**: archivos que estaban en la lista de la versión instalada y ya no están en la nueva (el `CHANGELOG.md` los menciona; p. ej. rename `global-sdd.md` → `global-sdd.mdc`). Si el proyecto no los personalizó, se borran/renombran; si sí, muestra el diff y pregunta.
   - **Reglas del stack** (`.cursor/rules/stack-[nombre].mdc`): no están en la lista del paquete porque las genera `/init`. Compáralas con su guía `.cursor/skills/stack-conventions/references/[nombre].md` del origen; si el proyecto no las personalizó, propón refrescarlas; si difieren, muestra el diff y pregunta.
6. Nunca reescribas de oficio archivos que no pertenecen al paquete (skills, comandos o reglas del stack del proyecto), ni `specs/`, `MEMORY.md`, dominio de `AGENTS.md`, ni el `README.md` / `CHANGELOG.md` de la raíz del proyecto. La excepción controlada es el paso 7 (solo **proponer** bloques faltantes de proyección).
7. **Verificar proyección AGENTS + constitution** (después de clasificar el paquete; no borra dominio):
   - Lee `docs/constitution.md` y `AGENTS.md` del proyecto (si existen).
   - Comprueba que consten: (a) **integridad de tests** — no debilitar tests, Reporte de Fallo, cierre post-reporte (fix ahora | tarea | SDD); (b) **revisión de diseño** como sugerencia — `CONSULTA DE DISEÑO` al crear código propio, sin refactor automático.
   - Si faltan: redacta textos mínimos a añadir (bloques sugeridos o diff) inspirados en el PASO 6–7 de `/init`; **no** elimines secciones de dominio, Convenciones ni `## Código Compartido`. Incluye estas propuestas en el resumen del DETENTE y solo escríbelas tras confirmación.
8. Si el `CHANGELOG.md` del origen indica una migración de specs (ej. introducción de `history.md`), describe los pasos y ofrece ejecutarlos con `@1-planner.md`.
9. 🛑 **DETENTE Y ESPERA**: Muestra el resumen (versión actual → nueva, origen usado, archivos a reemplazar/renombrar, conflictos, y estado de proyección AGENTS/constitution) y pide confirmación antes de escribir.
10. Al terminar, actualiza en `.cursor/sdd-kit.md` la `version` y deja `source` apuntando al origen usado (URL del repo público o ruta local, según corresponda).
