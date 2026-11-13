# /sdd-update (Lite)

Origen: **`sdd-lite/.agents/`**. Actualiza en el sitio (`.cursor/`|`.agents/`). No toques skills del usuario.

## Pasos
1. Lee `sdd-kit.md` (`edition: lite`, `source`). Compara vs `sdd-lite/.agents/` del origen.
2. Sobrescribe solo archivos del paquete (reglas con extensión del host, comandos, subagentes, plantillas, guías presentes). No restaures guías borradas.
3. **`AGENTS.md` GATE**: auto-carga → **puntero** 3 líneas a `global-sdd` §0; Pi/chat libre → GATE completo Lite. Tope 45 líneas. No borres dominio. OpenCode: `instructions` + `.opencode/commands/`. Borra `commands/init.md` viejo.
4. **Agents nativos**: si existe `.cursor/agents/`, `.claude/agents/` o `.opencode/`/`opencode.json` → proyecta `sdd-planner` / `sdd-implementer` / `sdd-qa-reviewer` desde `subagents/` (OpenCode: `mode: subagent`). Copilot/Pi: solo `subagents/`.
5. History viejo (`h-NN`, monolito): pregunta migrar a `index` + `<dominio>` ≤100.
6. 🛑 Resumen + confirmación. Actualiza `version`.
