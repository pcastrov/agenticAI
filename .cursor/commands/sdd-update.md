# /sdd-update - Actualización del Flujo SDD

Actualiza los archivos del flujo SDD de este proyecto desde el paquete `sdd-kit` (origen público o ruta local). **Edición Full** = carpeta `.cursor/` en la **raíz** del repo origen (no `sdd-lite/`).

## Instrucción para la IA

1. Lee `.cursor/sdd-kit.md` del proyecto: versión instalada y `source`.
2. Si el usuario no indica otra ruta/URL, usa `source`. **Resuelve el origen**:
   - **Ruta local** existente: úsala.
   - **URL de Git**: `git clone --depth 1` (o fetch/checkout en caché). Raíz del clone = raíz del repo (contiene `.cursor/` Full y `sdd-lite/`). Compara solo `.cursor/` del clone (Full). No dejes la carpeta temporal dentro del proyecto.
   - Si falta `source`, pregunta ruta o URL.
3. Versión en `.cursor/sdd-kit/CHANGELOG.md` del origen (primera entrada). Compara con la instalada.
4. Si misma versión: informa al día (salvo verificación del paso 7).
5. Compara cada archivo de "Archivos del paquete" en `.cursor/sdd-kit/README.md` del origen vs `.cursor/` del proyecto:
   - Sin cambios locales → reemplazar.
   - Con cambios locales → diff + preguntar.
   - Nuevos (p. ej. `ui-check.md`, `mcp-mode.md`) → copiar.
   - Eliminados del paquete → borrar/renombrar si no personalizados.
   - `stack-*.mdc`: refrescar desde guías del origen si no personalizadas.
6. No toques de oficio skills/comandos ajenos al paquete, ni `specs/`, `MEMORY.md`, dominio de `AGENTS.md`, ni README/CHANGELOG de la raíz del proyecto (salvo paso 7).
7. **Proyección AGENTS + constitution + Boost** (proponer; no borrar dominio):
   - Constitution: integridad de tests (incl. E2E/`ui_check`) + revisión de diseño como sugerencia.
   - `AGENTS.md`: puntero corto a `global-sdd` §0 / §2.1–2.3 (bloque "Gobernanza SDD"); **no** reinyectar textos largos de DRY/consultas.
   - Si existe `<laravel-boost-guidelines>`: propone **eliminarlo o reducirlo a ≤5 líneas** y `boost.json` con `"guidelines": false`, `"mcp": true`.
   - Higiene MCP: recuerda `/mcp-mode` y `/ui-check` (navegador no siempre-on).
   - Solo escribe tras confirmación.
8. Migraciones de specs del CHANGELOG → ofrece `@1-planner.md`.
9. 🛑 Resumen (versión, origen, archivos, proyección/Boost) + confirmación.
10. Actualiza `version` y `source` en `.cursor/sdd-kit.md`.
