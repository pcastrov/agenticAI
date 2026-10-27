# /sdd-update - Actualización del Flujo SDD

Actualiza los archivos del flujo SDD de este proyecto desde el paquete `sdd-kit`.

## Instrucción para la IA

1. Lee `.cursor/sdd-kit.md` del proyecto: versión instalada y ruta/URL del paquete (`source`).
2. Si el usuario no indica otra ruta, usa `source`. Lee la versión del paquete en `.cursor/sdd-kit/CHANGELOG.md` del paquete (primera entrada) y las entradas posteriores a la versión instalada. Si no existe, búscalo en la raíz del paquete (`CHANGELOG.md`, ubicación hasta la 3.0.0).
3. Si la versión es la misma, informa que el flujo está al día y termina.
4. Compara cada archivo listado en la sección "Archivos del paquete" de `.cursor/sdd-kit/README.md` del paquete (o del `README.md` de su raíz, hasta la 3.0.0) contra su copia en `.cursor/` del proyecto y clasifícalos:
   - **Sin cambios locales**: se puede reemplazar directamente.
   - **Con cambios locales** (el proyecto lo personalizó): muestra el diff y pregunta si se reemplaza, se fusiona o se conserva.
   - **Nuevos en el paquete**: se copian.
   - **Eliminados del paquete**: archivos que estaban en la lista de la versión instalada y ya no están en la nueva (el `CHANGELOG.md` los menciona). Si el proyecto no los personalizó, se borran; si sí, muestra el diff y pregunta.
   - **Reglas del stack** (`.cursor/rules/stack-[nombre].mdc`): no están en la lista del paquete porque las genera `/init`. Compáralas con su guía `.cursor/skills/stack-conventions/references/[nombre].md` del paquete; si el proyecto no las personalizó, propón refrescarlas; si difieren, muestra el diff y pregunta.
5. Nunca toques archivos que no pertenecen al paquete (skills, comandos o reglas del stack del proyecto), ni `specs/`, `AGENTS.md`, `MEMORY.md`, `docs/constitution.md` o el `README.md` / `CHANGELOG.md` de la raíz del proyecto (son del proyecto, no del paquete).
6. Si el `CHANGELOG.md` del paquete indica una migración de specs (ej. introducción de `history.md`), describe los pasos y ofrece ejecutarlos con `@1-planner.md`.
7. 🛑 **DETENTE Y ESPERA**: Muestra el resumen (versión actual → nueva, archivos a reemplazar, conflictos) y pide confirmación antes de escribir.
8. Al terminar, actualiza la versión en `.cursor/sdd-kit.md`.
