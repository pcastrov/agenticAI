# stay-on-rails

**stay-on-rails** es un framework ligero, declarativo y sin dependencias para desarrollo asistido por agentes de IA bajo Spec-Driven Development (SDD).

Marco para mantener a tus agentes **sobre rieles**: specs primero, TDD siempre, cero improvisación. Primero el **qué** (spec), luego el **cómo**, después TDD y validación.

Este repo **no** es una app: son **dos ediciones** del kit (Full y Lite) listas para instalar en tu proyecto. Eliges **una**. Funciona con Cursor, Claude Code, GitHub Copilot (VS Code), Pi y OpenCode.

**Repositorio**: [https://github.com/pcastrov/stay-on-rails](https://github.com/pcastrov/stay-on-rails) · **Licencia**: [MIT](LICENSE)

---

## Principios (comunes a Full y Lite)

| Principio | Qué significa en el kit |
|-----------|--------------------------|
| **SDD** | Full 4.2+: ANCLAJE + Triage + subagentes nativos. Lite 3.0: ANCLAJE corto + **Micro-Spec** (1 HU / ≤5 tareas, 2 paradas Qué/Cómo) para 8K–32K. Nivel 0 edita directo; Nivel 1 no emite código hasta spec OK. |
| **DRY** | Antes de crear algo, se busca lo existente (`Código Compartido` + módulo activo). Reutilizar se **propone**, nunca se impone. |
| **KISS** | Sin capas, abstracciones ni patrones que el requisito no necesite. |
| **YAGNI** | Nada que ningún requisito (`RF`) pida hoy. |
| **Tests íntegros** | Un test rojo se reporta, nunca se debilita ni se ignora. QA valida con Exit Code 0 en terminal. |
| **Un solo origen** | Mismo contenido con rutas relativas. Carpeta: `.cursor/` (Cursor) o `.agents/` (resto). Cero duplicación en el repo fuente. |

DRY/KISS/YAGNI son **consultas** (`CONSULTA DE SIMPLICIDAD`): el agente pregunta, tú decides.

---

## Elige tu edición

| | **SDD Full** (v4.2+) | **SDD Lite Compacto** (v3.0+) |
|---|---|---|
| **Carpeta** | [`sdd-full/`](sdd-full/) | [`sdd-lite/`](sdd-lite/) |
| **Para quién** | Frontier / ventanas grandes | Compacto: locales **8B–14B** o cloud con topes bajos |
| **Ventana típica** | 128K+ | **8K / 16K / 32K** (locales); cloud puede más |
| **Flujo** | ANCLAJE + Triage + fases; flowchart + secuencia; subagentes nativos | ANCLAJE + Micro-Spec (Qué🛑/Cómo🛑) + TDD aislado |
| **Specs** | `spec` + `plan` + `tasks` + history íntegro | Un `spec.md` (1 HU · ≤5 tareas · ~85 líneas) + shards ≤100 |
| **Memoria** | MEMORY + history detalle | MEMORY ≤30 (activa) + shards condensados |
| **QA (`/review`)** | A ciegas: diff + suite | Tabla 4 criterios; crea tests; runners silenciosos |
| **Convenciones** | Opcionales (stack-conventions) | Opcionales condensadas + `on-demand-tools` |

**No instales Full y Lite a la vez** en el mismo proyecto.

---

## Instalación (ZIP + script)

1. **Descarga el ZIP** del repo: [https://github.com/pcastrov/stay-on-rails/archive/refs/heads/main.zip](https://github.com/pcastrov/stay-on-rails/archive/refs/heads/main.zip) (o *Code → Download ZIP* en GitHub) y descomprímelo en cualquier carpeta. Quedará `stay-on-rails-main/` con `sdd-full/` y `sdd-lite/`.
2. **Ejecuta el instalador** pasando la **ruta de tu proyecto** (carpeta raíz de tu app, no la del ZIP). Si la omites, el script se detiene y muestra un ejemplo.

| Edición | Windows (PowerShell) | Mac / Linux |
|---------|----------------------|-------------|
| **Full** | `powershell -ExecutionPolicy Bypass -File C:\ruta\stay-on-rails-main\sdd-full\setup_sdd_full.ps1 -ProjectPath "C:\Users\tu\mi-proyecto"` | `bash /ruta/stay-on-rails-main/sdd-full/setup_sdd_full.sh "/Users/tu/mi-proyecto"` |
| **Lite** | `powershell -ExecutionPolicy Bypass -File C:\ruta\stay-on-rails-main\sdd-lite\setup_sdd_lite.ps1 -ProjectPath "C:\Users\tu\mi-proyecto"` | `bash /ruta/stay-on-rails-main/sdd-lite/setup_sdd_lite.sh "/Users/tu/mi-proyecto"` |

En PowerShell también vale el primer argumento sin nombre: `.\setup_sdd_full.ps1 "C:\Users\tu\mi-proyecto"`.

El script hace tres cosas (en este orden):

1. Pregunta tu agente: **1 Cursor · 2 Copilot · 3 Claude · 4 Pi · 5 OpenCode** (Full y Lite).
2. Instala en `.cursor/` (Cursor) o `.agents/` (resto). Puentes si hace falta: `.github/copilot-instructions.md` (Copilot / VS Code), `CLAUDE.md` (Claude). Cursor → reglas `.mdc`. Pi → `.pi/extensions/sdd-commands.ts`. OpenCode → `opencode.json` + `.opencode/commands/<cmd>.md`. Tras `/sdd-init`, el **GATE** queda al inicio de `AGENTS.md`.
3. (Opcional) Te deja **solo la guía de tu framework** (Laravel/Filament/NativePHP, Django, FastAPI, Flutter) y borra el resto para ahorrar tokens. Si saltas el paso o no hay guía, el agente usa buenas prácticas estándar del lenguaje, sin error.
4. **En el chat de tu agente** Ejecuta `/sdd-init` (genera `AGENTS.md`, `docs/constitution.md`, `MEMORY.md`). Luego:
   - Full: `/sdd` para planear y construir; código existente → `/retrofit`.
   - Lite: `/sdd` → `/implement` → `/sdd-archive`.

**Sin script**: copia `sdd-full/.agents/` o `sdd-lite/.agents/` a `.cursor/` (Cursor) o `.agents/` (otros) y Ejecuta `/sdd-init`.

### Actualizar

En el chat: `/sdd-update`. Detecta tu carpeta (`.cursor/` o `.agents/`) y actualiza **en el sitio**, sin renombrarla. Solo sobrescribe archivos base del paquete (reglas, comandos, plantillas). **Nunca toca** tus skills ni restaura guías de framework que borraste. Corrige en `AGENTS.md` las rutas al framework según tu herramienta (Full 4.1+: verifica que el GATE muestre **`[ANCLAJE]`** sin borrar el dominio) y, si tus specs tienen un `history.md` antiguo, te **pregunta** si migrarlo a `history/index.md` + `history/<dominio>.md`.

---

## Organización del repositorio

```text
stay-on-rails/
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
| **Hardware (local)** | GPU de consumo **~8 GB VRAM** (diseño base) |
| **Runtime local** | **Ollama** |
| **Contexto local** | **8K / 16K / 32K** (`num_ctx`) según modelo — buen tokens/s; subir más suele bajar el throughput |
| **Modelos locales** | **8B–14B** cuantizados, p. ej. **Qwen 2.5 Coder 7B**, y otros **9B / 8B o MoE** |
| **Cliente recomendado (local)** | **Pi** (más liviano) · **OpenCode** |
| **Cloud / no local** | Cursor · VS Code + Copilot · Claude Code (también Pi/OpenCode) — Lite compacto igual de útil |
| **Local + Cursor/Copilot/Claude** | Mejor con GPU **> ~8 GB**; ahí suele ir bien e incluso **aumentar el contexto** |

---

## Estimación de tokens (orientativa)

> **Estimaciones.** Varían con tokenizer, idioma, tamaño real de `AGENTS`/`MEMORY`/specs, diff, salida de tests, MCPs y el **system prompt del cliente** (Cursor, Claude Code, OpenCode, Copilot, Pi…), que **no** está incluido abajo.

### 1. Inventario estático en disco (por capa)

| Capa                                  | Archivos (Full / Lite) | Full (tok. est.) | Lite (tok. est.) | Carga                           |
| ------------------------------------- | ---------------------- | ---------------- | ---------------- | ------------------------------- |
| Reglas `rules/global-sdd.md`          | 1 / 1                  | ~3 316           | ~862             | Siempre (`alwaysApply`)         |
| Comandos `commands/*.md`              | 13 / 10                | ~11 956          | ~2 945           | Bajo demanda (1 comando)        |
| Subagentes `subagents/*.md`           | 3 / 3                  | ~3 097           | ~935             | Por fase (1 rol)                |
| Skill `stack-conventions`             | 7 / 7                  | ~9 560           | ~694             | Selectivo (1–2 guías)           |
| Skill `sdd-docs-generator`            | 8 / 4                  | ~5 693           | ~1 083           | Por documento (1 plantilla)     |
| Skill `on-demand-tools`               | 0 / 1                  | —                | ~325             | Bajo demanda (UI/BD/consola)    |
| Metadatos `sdd-kit/`                  | 3 / 3                  | ~11 994          | ~1 130           | ~0 en operación (`/sdd-update`) |
| **Total `.agents/` / `.cursor/`**     | **35 / 29**            | **~45 616**      | **~7 974**       | Sin `setup_`* ni README raíz    |
| **Carpeta completa** (+ setup/README) | **38 / 32**            | **~51 988**      | **~14 007**      | Peso en el repo                 |

### 2. Consumo base fijo por turno (antes de leer código de tu app)

| Edición | Base fija aprox. | Desglose |
|---------|------------------|----------|
| **Full** | **~5.3–6.7K** | `global-sdd` ~3 316 + `AGENTS` ~600–1 000 + `MEMORY` ~250–500 + `rules/stack-`* ~1 100–1 900 |
| **Lite** | **~1.5–1.6K** | `global-sdd` ~862 + `AGENTS` ~400 + `MEMORY` ~200 + convención condensada ~60–150 |

En Lite, el README del kit (~**3.0–3.5K**/turno) suma ya subagente + `spec.md` activo; encaja con base + lectura de fase.

### 3. Acumulado por flujo (input + output, multi-turno)

| Escenario | Turnos | Full | Lite |
|-----------|--------|------|------|
| Consulta / arquitectura | 1–2 | 8K–14K | 2.5K–4.5K |
| Bugfix / Nivel 0 | 2–4 | 18K–35K | 5K–10K |
| `/sdd-init` | 3–5 | 35K–55K | 12K–20K |
| Feature Nivel 1 | 8–14 | 120K–260K · **90K–130K** con sesión limpia / subagente aislado antes de `/implement` y `/review` | 30K–65K |

Overhead del cliente (fuera del kit, Lite): **Pi** ~1.2–1.8K · **OpenCode** ~3.5–5K. En 8B–14B con ventana **8K–32K**, reserva ~3–4K para la respuesta y evita llenar el contexto al tope (~70–75%).

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
