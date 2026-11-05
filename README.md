# SDD Kit

Kit de **Spec-Driven Development (SDD)** para programar con agentes de IA de forma ordenada: primero el **qué** (spec), luego el **cómo**, después TDD y validación. Funciona con Cursor, Claude Code, GitHub Copilot, Cline/Roo, Pi y OpenCode.

**Repositorio**: [github.com/pcastrov/agenticAI](https://github.com/pcastrov/agenticAI) · **Licencia**: [MIT](LICENSE)

Este repo **no** es una app: son **dos ediciones** listas para instalar en tu proyecto. Eliges **una**.

---

## Principios (comunes a Full y Lite)

| Principio | Qué significa en el kit |
|-----------|--------------------------|
| **SDD** | Triage en el Turno 1: Nivel 0 *FAST-TRACK* (≤1 archivo, cambio menor) edita directo; Nivel 1 *SDD-REQUIRED* **no emite código** hasta tener spec aprobada. |
| **DRY** | Antes de crear algo, se busca lo existente (`Código Compartido` + módulo activo). Reutilizar se **propone**, nunca se impone. |
| **KISS** | Sin capas, abstracciones ni patrones que el requisito no necesite. |
| **YAGNI** | Nada que ningún requisito (`RF`) pida hoy. |
| **Tests íntegros** | Un test rojo se reporta, nunca se debilita ni se ignora. QA valida con Exit Code 0 en terminal. |
| **Un solo origen** | Mismo contenido para todos, con rutas relativas. Solo cambia el nombre de la carpeta según tu herramienta: `.cursor/` (Cursor) o `.agents/` (las demás). Cero duplicación. |

DRY/KISS/YAGNI son **consultas** (`CONSULTA DE SIMPLICIDAD`): el agente pregunta, tú decides.

---

## Elige tu edición

| | **SDD Full** (v4.0+) | **SDD Lite** (v2.0+) |
|---|---|---|
| **Carpeta** | [`sdd-full/`](sdd-full/) | [`sdd-lite/`](sdd-lite/) |
| **Para quién** | Cursor, Claude Code, GitHub Copilot / modelos frontier | Modelos **locales** 8B–14B en GPU modestas |
| **Ventana típica** | 128K+ | **32K** (a veces 16K) con **Ollama** |
| **Flujo** | Triage + 8 fases, 3 subagentes, diagramas Mermaid, propiedades, QA a ciegas | Triage + 3 pasos: planear → implementar → archivar |
| **Specs** | `spec.md` + `plan.md` + `tasks.md` + `history/index.md` + `history/<dominio>.md` | `spec.md` tabular + `history/index.md` + `history/<dominio>.md` (≤100 líneas) |
| **Historial** | Íntegro, segmentado por dominio (no se resume) | Fichas atómicas por dominio (solo contratos y endpoints) |
| **QA (`/review`)** | Auditoría a ciegas: diff vs spec + suite en terminal | Tabla determinista de 4 criterios con evidencia; crea tests faltantes |
| **Convenciones de framework** | Opcionales (Laravel, Filament, NativePHP, Django, FastAPI, Flutter) | Opcionales (versión condensada) |

**No instales Full y Lite a la vez** en el mismo proyecto.

---

## Instalación (ZIP + script)

1. **Descarga el ZIP** del repo: [Download ZIP](https://github.com/pcastrov/agenticAI/archive/refs/heads/main.zip) (o *Code → Download ZIP* en GitHub) y descomprímelo en cualquier carpeta. Quedará `agenticAI-main/` con `sdd-full/` y `sdd-lite/`.
2. **Ejecuta el instalador** pasando la **ruta de tu proyecto** (carpeta raíz de tu app, no la del ZIP). Si la omites, el script se detiene y muestra un ejemplo.

| Edición | Windows (PowerShell) | Mac / Linux |
|---------|----------------------|-------------|
| **Full** | `powershell -ExecutionPolicy Bypass -File C:\ruta\agenticAI-main\sdd-full\setup_sdd_full.ps1 -ProjectPath "C:\Users\tu\mi-proyecto"` | `bash /ruta/agenticAI-main/sdd-full/setup_sdd_full.sh "/Users/tu/mi-proyecto"` |
| **Lite** | `powershell -ExecutionPolicy Bypass -File C:\ruta\agenticAI-main\sdd-lite\setup_sdd_lite.ps1 -ProjectPath "C:\Users\tu\mi-proyecto"` | `bash /ruta/agenticAI-main/sdd-lite/setup_sdd_lite.sh "/Users/tu/mi-proyecto"` |

En PowerShell también vale el primer argumento sin nombre: `.\setup_sdd_full.ps1 "C:\Users\tu\mi-proyecto"`.

El script hace tres cosas (en este orden):
1. Pregunta tu agente.
2. Instala el paquete en **`.cursor/`** si usas Cursor, o en **`.agents/`** si usas otro (mismo contenido; solo cambia el nombre). Crea un archivo **puente** solo donde hace falta: `.github/copilot-instructions.md` (Copilot) y `CLAUDE.md` (Claude Code). Cursor, Pi, OpenCode y Cline leen su carpeta directo. En Cursor, además, las reglas se convierten a `.mdc` (el formato que Cursor acepta).
3. (Opcional) Te deja **solo la guía de tu framework** (Laravel/Filament/NativePHP, Django, FastAPI, Flutter) y borra el resto para ahorrar tokens. Si saltas el paso o no hay guía, el agente usa buenas prácticas estándar del lenguaje, sin error.

4. **En el chat de tu agente** ejecuta `/init` (genera `AGENTS.md`, `docs/constitution.md`, `MEMORY.md`). Luego:
   - Full: `/sdd` para planear y construir; código existente → `/retrofit`.
   - Lite: `/sdd` → `/implement` → `/sdd-archive`.

**Sin script**: copia el contenido de `sdd-full/.agents/` (o `sdd-lite/.agents/`) a `.cursor/` (Cursor) o `.agents/` (otros) en la raíz de tu proyecto y ejecuta `/init`.

### Actualizar
En el chat: `/sdd-update`. Detecta tu carpeta (`.cursor/` o `.agents/`) y actualiza **en el sitio**, sin renombrarla. Solo sobrescribe archivos base del paquete (reglas, comandos, plantillas). **Nunca toca** tus skills ni restaura guías de framework que borraste. Corrige en `AGENTS.md` las rutas al framework según tu herramienta y, si tus specs tienen un `history.md` antiguo, te **pregunta** si migrarlo a `history/index.md` + `history/<dominio>.md`.

---

## Organización del repositorio

```text
agenticAI/
├── README.md
├── LICENSE
├── sdd-full/
│   ├── README.md
│   ├── setup_sdd_full.sh / .ps1
│   └── .agents/            ← el paquete de origen (se instala como .cursor/ o .agents/)
└── sdd-lite/
    ├── README.md
    ├── setup_sdd_lite.sh / .ps1
    └── .agents/
```

### Escenario para el que se midió y diseñó **SDD Lite**

| Pieza | Objetivo |
|-------|----------|
| **Hardware** | GPU de consumo con **~8 GB VRAM** |
| **Runtime** | **Ollama** |
| **Contexto** | **32K** tokens (`num_ctx` ≈ 32768); a veces 16K |
| **Modelos** | **8B–14B** cuantizados, p. ej. **Qwen 2.5 Coder 14B**, y variantes **9B / 8B** |
| **Cliente (ideal)** | **Pi** (más liviano) · **OpenCode** · VS Code + Copilot/Ollama (más overhead) |

---

## Estimación de tokens (orientativa)

Aprox. en español/Markdown. Solo kit + docs SDD; **no** incluye código leído, historial del chat ni MCPs de terceros.

### Full — turno típico (Laravel + Filament)

| Escenario | Tokens aprox. |
|-----------|----------------|
| Base fija (regla global + `AGENTS.md` limpio, sin Boost guidelines) | **~2.5–3.5K** |
| Implementar 1 tarea (stack ya adjunto) | **~8–11K** |
| Planificar (plantillas + spec/plan) | **~12–16K** |

### Lite — turno típico (Ollama 32K, p. ej. Qwen 2.5 Coder 14B / 8 GB VRAM)

| Escenario | Tokens aprox. |
|-----------|----------------|
| Turno normal (regla + subagente + guía + `spec.md`) | **~3.0–3.5K** |
| + 1 shard de dominio | **~4.5–5.0K** |

Overhead del cliente (fuera del kit): **Pi** ~1.2–1.8K · **OpenCode** ~3.5–5K · Copilot Agent ~6.5–9K. Reserva ~3–4K para la respuesta. En 8B–14B evita llenar los 32K al tope (~70–75%).

---

## Tips para gastar menos
1. Un hilo/chat por tarea.
2. Planear con modelo fuerte; implementar con Auto / modelo más barato.
3. `/mcp-mode code` por defecto; `/ui-check` solo para pantallas.
4. Laravel: Boost con MCP y **sin** guidelines largas en `AGENTS.md`.
5. Elimina las guías de framework que no uses (el instalador lo ofrece).

---

## Mantenimiento de este repo
1. Cambios Full en `sdd-full/.agents/` (única fuente; no hay espejo `.cursor/`).
2. Cambios Lite en `sdd-lite/.agents/` (única fuente).
3. Al versionar: `sdd-kit.md` + entrada al tope de `sdd-kit/CHANGELOG.md` de la edición.
4. Tras publicar: los proyectos actualizan con `/sdd-update`.
