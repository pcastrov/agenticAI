# /sdd-update - Actualización del Flujo SDD

Actualiza los archivos del flujo SDD de este proyecto desde el paquete `sdd-kit` (origen público o ruta local).

## Instrucción para la IA

1. Lee `.agents/sdd-kit.md` del proyecto: versión instalada y origen del paquete (`source`).
2. Si el usuario no indica otra ruta/URL, usa `source`. **Resuelve el origen** así:
   - **Ruta local** (absoluta o relativa que exista en disco): úsala directamente.
   - **URL de Git** (p. ej. `https://github.com/pcastrov/agenticAI` o `…/agenticAI.git`): clona o actualiza una copia de trabajo temporal con `git clone --depth 1` (o `git fetch` + `git checkout` si ya existe un clone en caché del mismo `source`). La raíz del clone es la raíz del paquete (contiene `.cursor/` y `.agents/`); para este host compara solo la carpeta `.agents/` del clone. Borra o reutiliza la carpeta temporal al terminar; no la dejes dentro del proyecto del usuario.
   - Si `source` falta o no se puede leer, pregunta al usuario la ruta local o la URL del repo.
3. Lee la versión del paquete en `.agents/sdd-kit/CHANGELOG.md` **del origen resuelto** (primera entrada) y las entradas posteriores a la versión instalada. Si no existe, búscalo en la raíz del paquete (`CHANGELOG.md`, ubicación hasta la 3.0.0).
4. Si la versión es la misma, informa que el flujo está al día y termina.
5. Compara cada archivo listado en la sección "Archivos del paquete" de `.agents/sdd-kit/README.md` del origen (o del `README.md` de su raíz, hasta la 3.0.0) contra su copia en `.agents/` del proyecto y clasifícalos:
   - **Sin cambios locales**: se puede reemplazar directamente.
   - **Con cambios locales** (el proyecto lo personalizó): muestra el diff y pregunta si se reemplaza, se fusiona o se conserva.
   - **Nuevos en el paquete**: se copian.
   - **Eliminados del paquete**: archivos que estaban en la lista de la versión instalada y ya no están en la nueva (el `CHANGELOG.md` los menciona). Si el proyecto no los personalizó, se borran; si sí, muestra el diff y pregunta.
   - **Reglas del stack** (`.agents/rules/stack-[nombre].md`): no están en la lista del paquete porque las genera `/init`. Compáralas con su guía `.agents/skills/stack-conventions/references/[nombre].md` del origen; si el proyecto no las personalizó, propón refrescarlas; si difieren, muestra el diff y pregunta.
6. Nunca toques archivos que no pertenecen al paquete (skills, comandos o reglas del stack del proyecto), ni `specs/`, `AGENTS.md`, `MEMORY.md`, `docs/constitution.md` o el `README.md` / `CHANGELOG.md` de la raíz del proyecto (son del proyecto, no del paquete).
7. Si el `CHANGELOG.md` del origen indica una migración de specs (ej. introducción de `history.md`), describe los pasos y ofrece ejecutarlos con `@1-planner.md`.
8. 🛑 **DETENTE Y ESPERA**: Muestra el resumen (versión actual → nueva, origen usado, archivos a reemplazar, conflictos) y pide confirmación antes de escribir.
9. Al terminar, actualiza en `.agents/sdd-kit.md` la `version` y deja `source` apuntando al origen usado (URL del repo público o ruta local, según corresponda).
