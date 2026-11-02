# /mcp-mode — Encender / apagar MCPs pesados

Cambia el perfil de MCP para no pagar tokens de schemas JSON de navegador mientras programas.

## Modos
| Modo | Uso |
|------|-----|
| `code` (default) | Solo MCPs esenciales del stack (p. ej. `laravel-boost`). Playwright / Chrome DevTools **apagados**. |
| `ui` / `debug` | Enciende Playwright y/o Chrome DevTools para verificación visual o debugging. Al terminar, vuelve a `code`. |

## Instrucción
1. Pregunta el modo si el usuario no lo dijo (`code` | `ui` | `debug`).
2. Indica qué archivos editar según el host:
   - Cursor: `.agents/mcp.json` (o settings MCP del IDE).
   - OpenCode: `opencode.json` / tools del agente.
   - VS Code + Copilot / Pi: configuración MCP / extensiones equivalentes.
3. En `code`: deshabilita o comenta servidores `playwright`, `chrome-devtools` (y similares). Deja Boost u otros MCP ligeros del stack si el proyecto los usa.
4. En `ui`/`debug`: habilita solo el servidor necesario para esa sesión.
5. 🛑 Muestra el diff propuesto y **espera confirmación** antes de escribir.
6. Recuerda: tras `/ui-check`, conviene volver a `code`.
