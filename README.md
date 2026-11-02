# SDD Kit

Kit de **Spec-Driven Development (SDD)** para programar con agentes de IA de forma ordenada: primero el **qué**, luego el **cómo**, después TDD y validación.

**Repositorio**: [https://github.com/pcastrov/agenticAI](https://github.com/pcastrov/agenticAI) · **Licencia**: [MIT](LICENSE)

---

## Dos ediciones: Full y Lite

| | **SDD Full** (v3.5+) | **SDD Lite** (v1.0+) |
|---|---|---|
| **Carpeta en este repo** | Raíz: [`.cursor/`](.cursor/) y [`.agents/`](.agents/) | [`sdd-lite/`](sdd-lite/) → dentro: `.cursor/` y `.agents/` |
| **Para quién** | Cursor Pro / modelos frontier (Claude, GPT, Gemini…) | Modelos **locales** en GPU modestas (ver escenario abajo) |
| **Ventana típica** | 128K+ | **32K** (a veces 16K) vía **Ollama** |
| **Flujo** | 8 fases, 3 subagentes, diagramas Mermaid, propiedades, QA estricto | 3 pasos: planear → implementar → archivar |
| **Specs** | `spec.md` + `plan.md` + `tasks.md` + `history.md` | `spec.md` unificado + `summary.md` + `history/h-NN.md` (máx 3 shards) |
| **Actualizar** | `/sdd-update` (busca `.cursor/` o `.agents/` en la **raíz** del clone) | `/sdd-update` lite (busca `sdd-lite/.cursor` o `sdd-lite/.agents`) |

**No instales Full y Lite a la vez** en el mismo proyecto: el agente se confunde con reglas duplicadas.

```text
agenticAI/
├── README.md                 ← este archivo
├── .cursor/                  ← SDD Full (Cursor)
├── .agents/                  ← SDD Full (otros agentes)
└── sdd-lite/
    ├── README.md
    ├── .cursor/              ← SDD Lite (Cursor / VS Code)
    └── .agents/              ← SDD Lite (Pi, OpenCode, …)
```

> Full vive en la **raíz** (no en `sdd-full/`) para que los proyectos que ya tienen el kit puedan seguir usando `/sdd-update` sin romper la ruta. Lite va en `sdd-lite/` a propósito.

### Escenario para el que se midió y diseñó **SDD Lite**

Lite no es “cualquier modelo chico”: se dimensionó el presupuesto de tokens (~3–3.5K de kit + docs del módulo por turno) pensando en algo así:

| Pieza | Objetivo |
|-------|----------|
| **Hardware** | GPU de consumo con **~8 GB VRAM** (laptop/desktop) |
| **Runtime** | **Ollama** (u otro servidor local compatible) |
| **Contexto** | **32K** tokens de ventana (`num_ctx` ≈ 32768); a veces 16K si el modelo o la VRAM lo obligan |
| **Modelos** | Familia **8B–14B** en cuantización que quepa en 8 GB, p. ej. **Qwen 2.5 Coder 14B** (Q4/Q5 típico), y variantes **9B / 8B** del mismo rango (Coder u otros instruct/coder locales) |
| **Cliente de agente (ideal)** | **Pi** (`pi-coding-agent`) — el más liviano en system prompt/tools · **OpenCode** — buen equilibrio · VS Code + Copilot/Ollama también sirve, pero gasta más overhead |

Con esa combinación, el Lite deja margen para leer 2–3 archivos de código y correr tests **sin** llenar los 32K. Full sigue pensado para Cursor Pro / modelos cloud con ventanas grandes; no hace falta meter Lite ahí.

---

## Estimación de tokens (orientativa)

Los números son **aproximados** (español + Markdown ≈ 1 token cada ~4 caracteres). Incluyen solo el kit y docs SDD típicos; **no** incluyen el código que leas, el historial del chat ni MCPs de terceros.

### SDD Full — por turno en un proyecto Laravel + Filament

| Escenario | Antes (≈3.4) | Ahora (3.5+) | Notas |
|-----------|--------------|--------------|--------|
| Base fija (regla global + `AGENTS.md` limpio) | ~9–11K | **~2.5–3.5K** | Sin bloque `<laravel-boost-guidelines>` |
| Implementar 1 tarea (subagente + guías stack ya adjuntas) | ~20–28K | **~8–11K** | Si las `stack-*.mdc` ya están en contexto, no se releen |
| Planificar (plantillas + spec/plan) | ~18–25K | **~12–16K** | Lee plantillas bajo demanda |
| + Playwright/DevTools siempre-on | +6–10K fijos | **0** con `/mcp-mode code` | UI con `/ui-check` (veredicto corto) |

En la práctica, con Full 3.5+ un turno de implementación suele andar cerca de **la mitad** (o menos) de lo que gastabas en 3.4 si además apagas MCPs de navegador y usas chats cortos por tarea.

### SDD Lite — por turno (Ollama 32K, p. ej. Qwen 2.5 Coder 14B en ~8 GB VRAM)

| Escenario | Tokens aprox. | Qué queda libre en 32K* |
|-----------|---------------|-------------------------|
| Base (regla global lite) | **~500–700** | — |
| Turno normal (regla + subagente + 1 guía stack + `spec.md` + `summary.md`) | **~3.0–3.5K** | ~12–20K útiles según el cliente |
| + 1 shard de historial (`h-NN.md`) | **~4.5–5.0K** | Sigue cabiendo |
| Presupuesto docs del módulo (tope de diseño) | ≤ ~3.5K | `spec` ≤150 líneas, `summary` ≤100, shard ≤150 |

\*Gasto del **cliente** (fuera del kit; orientativo):

| Cliente | Overhead aprox. | Recomendación |
|---------|-----------------|---------------|
| **Pi** | ~1.2–1.8K | **Preferido** con Lite + Ollama |
| **OpenCode** | ~3.5–5K | Muy bueno; un poco más de tools/contexto |
| VS Code + Copilot Agent → Ollama | ~6.5–9K | Válido; deja menos aire en 32K |

Reserva ~3–4K para la respuesta del modelo. En 8B–14B conviene no llenar la ventana al tope (~70–75% de 32K) para no degradar atención.

---

## Instalación — SDD Full

1. Copia **solo** `.cursor/` **o** `.agents/` desde la **raíz** de este repo a tu proyecto.
2. Ejecuta `/init` (y `/retrofit` si ya hay código).
3. Cambios de producto: `/sdd`. Actualizar el kit: `/sdd-update`.

Detalle: [`.cursor/sdd-kit/README.md`](.cursor/sdd-kit/README.md) · [CHANGELOG](.cursor/sdd-kit/CHANGELOG.md)

### Qué cambió en Full 3.5 (ahorro de cuota)

- **GATE** al inicio de `global-sdd`: no editar sin `[EVALUACION SDD]`; no auto-arreglar fallos de Pest/Playwright/`ui_check`.
- **Una sola fuente** de reglas (subagentes y comandos referencian `global-sdd`; no copian textos largos).
- **Laravel Boost**: `guidelines: false` + MCP; propone limpiar `<laravel-boost-guidelines>` de `AGENTS.md`.
- **`/ui-check`** y **`/mcp-mode`**: navegador bajo demanda, sin DOM en el hilo de código.
- Compactación de `history.md` si supera ~300 líneas.

Tras publicar 3.5, en cada proyecto Full: `/sdd-update` y confirma la limpieza de Boost + el puntero de gobernanza en `AGENTS.md`.

---

## Instalación — SDD Lite

1. Copia `sdd-lite/.cursor/` → `.cursor/` del proyecto (o `sdd-lite/.agents/` → `.agents/`).
2. `/init` → `/sdd` → `/implement` → `/sdd-archive`.
3. Actualizar: `/sdd-update` (compara `sdd-lite/...` del `source`).

Specs:

```text
specs/NNN-modulo/
├── spec.md           # índice historial + RF + diseño breve + tareas (máx ~150 líneas)
├── summary.md        # foto actual + scratchpad (máx ~100)
└── history/
    ├── h-01.md …     # detalle reciente (máx ~150 líneas; máx 3 shards)
    └── h-archive.md  # compactado frío
```

Detalle: [`sdd-lite/README.md`](sdd-lite/README.md)

---

## Tips para gastar menos (Full y Lite)

1. **Un chat / hilo por tarea** — el historial largo se reenvía en cada mensaje y suele costar más que el kit.
2. **Planear con modelo fuerte; implementar con Auto / modelo más barato** cuando el plan ya está cerrado.
3. **`/mcp-mode code`** por defecto; `/ui-check` solo al verificar pantallas.
4. En Laravel: deja Boost con MCP y **sin** guidelines largas en `AGENTS.md`.

---

## Mantenimiento de este repositorio

1. Cambios Full primero en `.cursor/`; espejo a `.agents/` (mismo contenido, prefijo `.agents/`).
2. Cambios Lite en `sdd-lite/.cursor/` → espejo `sdd-lite/.agents/`.
3. Publicar → proyectos Full: `/sdd-update`. Proyectos Lite: `/sdd-update` de la edición lite.
