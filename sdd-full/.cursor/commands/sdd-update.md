# /sdd-update - Actualización del Flujo SDD

Actualiza el flujo SDD de este proyecto desde el paquete **SDD Full** en el origen (`sdd-full/.cursor/` del repo, no la raíz ni `sdd-lite/`).

## Instrucción para la IA

1. Lee `.cursor/sdd-kit.md` del proyecto: versión instalada y `source`.
2. Si el usuario no indica otra ruta/URL, usa `source`. **Resuelve el origen**:
   - **Ruta local**: si apunta a la raíz del repo `agenticAI`, usa `…/sdd-full/.cursor`. Si ya apunta a `…/sdd-full` o `…/sdd-full/.cursor`, úsala.
   - **URL de Git**: `git clone --depth 1` (o fetch/checkout en caché). Paquete Full = **`sdd-full/.cursor/`** dentro del clone. Compara solo esa carpeta contra `.cursor/` del proyecto. No dejes el clone temporal dentro del proyecto.
   - Si falta `source`, pregunta ruta o URL.
3. Versión en `sdd-full/.cursor/sdd-kit/CHANGELOG.md` del origen (o `.cursor/sdd-kit/CHANGELOG.md` si la ruta ya es el paquete). Primera entrada = vigente.
4. Si misma versión: informa al día (salvo verificación del paso 7).
5. Compara cada archivo de "Archivos del paquete" en el README del kit del origen vs `.cursor/` del proyecto:
   - Sin cambios locales → reemplazar.
   - Con cambios locales → diff + preguntar.
   - Nuevos → copiar.
   - Eliminados del paquete → borrar/renombrar si no personalizados.
   - `stack-*.mdc`: refrescar desde guías del origen si no personalizadas.
6. No toques de oficio skills/comandos ajenos al paquete, ni `specs/`, `MEMORY.md`, dominio de `AGENTS.md`, ni README/CHANGELOG de la raíz del **proyecto del usuario** (salvo paso 7).
7. **Proyección AGENTS + constitution + Boost** (proponer; no borrar dominio):
   - Constitution: integridad de tests (incl. E2E/`ui_check`) + revisión de diseño como sugerencia.
   - `AGENTS.md`: puntero corto a `global-sdd` §0 / §2.1–2.3 ("Gobernanza SDD"); no reinyectar textos largos.
   - Si existe `<laravel-boost-guidelines>`: propone eliminarlo o ≤5 líneas y `boost.json` con `"guidelines": false`, `"mcp": true`.
   - Higiene MCP: `/mcp-mode` y `/ui-check`.
   - Solo escribe tras confirmación.
8. Migraciones del CHANGELOG → ofrece `@1-planner.md`.
9. 🛑 Resumen + confirmación.
10. Actualiza `version` y `source` en `.cursor/sdd-kit.md` (deja `source` en la URL del repo o la ruta a `sdd-full` usada).
